function output = uncertainty3 (val, unc) 
    unc = round(unc, 1, 'significant');  %rounds sigma to 1 sig fig
    counter = 0; %initializes counter 

    %Two loops below make sure uncertainty is between 1 and 9
    %multiplies value with it
    while (unc > 9) 
        unc = unc/10;
        val = val/10;
        counter = counter + 1;
    end
    
    while (unc < 1 && unc ~= 0) 
        unc = unc*10;
        val = val*10;
        counter = counter - 1;
    end
    
    %rounds to same number of decimal places as uncertainty
    val = round(val);

    %Makes the mantissa from 0.01 to 999
    while (val > 999) 
        val = val/10;
        unc = unc/10;
        counter = counter + 1;
    end
    while (val < 0.01 && val ~= 0) 
        val = val*10;
        unc = unc*10;
        counter = counter - 1;
    end
    
    %Converts uncertainty to a string with no scientific notation
    unc2 = num2str(unc, '%f');
    %removes first 0 in uncertainity (0.01 --> .01)
    if (strcmp(unc2(1), '0'))
        unc2(1) = '';
    end
    
    %Removes any trailing zeros
    while (strcmp(unc2(length(unc2)), '0'))
        unc2(length(unc2)) = '';
    end
    if (strcmp(unc2(length(unc2)), '.'))
        unc2(length(unc2)) = '';
    end
    
    %Converts value toa  string
    val2 = num2str(val);
    
    %Checks where the zero first appears
    a = 1;
    while (strcmp(val2(a), '.') ~= 1 && a < length(val2))
        a = a+1;
    end
    
    %Adds appropriate number of zeros to the end to make same length as
    %sigma
    while (length(val2)-a < length(unc2)-1) 
        val2 = strcat(val2, '0');
    end
    
    %concatenates mantissa and sigma in correct format
    output = horzcat('(', val2, '±', unc2, ') E', int2str(counter));
end