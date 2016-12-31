function output = uncertainty2 (eqn, vars, sigs, vals, uncs)
    eqn = sym(eqn); %creates a symbolic equation for the function
    syms error; %creates a symbolic for the error

    for i = 1:length(vars) %loops through all the variables
        sigmas{i} = sym(sigs{i}); %converts sigma strings to symbols
        variable{i} = sym(vars{i}); %converts variable strings to symbols
    end

    error = diff(eqn, variable{1})*diff(eqn, variable{1})*sigmas{1}*sigmas{1};
    %first term in the equation
    
    for i = 2:length(variable) %rest of the terms in the equations
        error = error + diff(eqn, variable{i})*diff(eqn, variable{i})*sigmas{i}*sigmas{i};
    end
    error = sqrt(error); %correct error function is square rooted
    error2 = error; %backup error to later compare to
    eqn2 = eqn; %backup function to later compare to

    for j = 1:size(vals, 1) %goes through all values for each variable
        for i = 1:length(vars) %goes through each variable
            %evaluates error function with mantissas and uncertainties
            error2 = subs(error2, variable{i}, vals(j, i)); 
            error2 = subs(error2, sigmas{i}, uncs(j, i));
            %evaluates function as well
            eqn2 = subs(eqn2, variable{i}, vals(j, i));
        end
        %adds the evaluated values to the output matrix
        output(j, 1) = double(eqn2);
        output(j, 2) = double(error2);
        
        %resets the error and function
        eqn2 = eqn;
        error2 = error;
    end
end