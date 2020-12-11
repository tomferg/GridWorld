function [choice] = softmax(values,temperature)
    
    possibleOptions = 1:1:length(values);
    numerator = exp(values/temperature);
    denominator = sum(numerator);
    total = numerator/denominator;
    probabilities = cumsum(total);
    check = rand(1) >= probabilities;
    findChoice = find(check == 0,1,'first');
    choice = possibleOptions(findChoice);
    
end