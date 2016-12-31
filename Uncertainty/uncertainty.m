function error = uncertainty (eqn, vars, sigs)
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
end