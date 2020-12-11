function [choice] = Greedy(values,episilon)

        %Choose Max
        [values,choice] = max(values);
        %Check if the values are equal?
        [ties] = find(maxValue == values);
        %Breaks tie randomly
        if sum(ties) > 1
            choice = ties(randi(length(ties)));
        end
        
        %Randomize based on the explore rate
        if episilon > rand
            choice = randi(length(values));
        end

end