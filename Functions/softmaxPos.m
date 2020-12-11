function [newValue,newPos,choice] = softmaxPos(oldValue,oldPos,temperature,numberRow,numberCol)
        
        if oldPos(2) < numberCol %move north
            New.value(1,1) = oldValue(oldPos(1),oldPos(2)+1);
            New.position(1,:) = [oldPos(1),oldPos(2)+1];
        else
            New.value(1,1) = oldValue(oldPos(1),oldPos(2));
            New.position(1,:) = [oldPos(1),oldPos(2)];
        end
        if  oldPos(2) > 1
            New.value(2,1) = oldValue(oldPos(1),oldPos(2)-1);
            New.position(2,:) = [oldPos(1),oldPos(2)-1];
        else
            New.value(2,1) = oldValue(oldPos(1),oldPos(2));
            New.position(2,:) = [oldPos(1),oldPos(2)];
        end
        if oldPos(1) < numberRow
            New.value(3,1) = oldValue(oldPos(1)+1,oldPos(2));
            New.position(3,:) = [oldPos(1)+1,oldPos(2)];
        else
            New.value(3,1) = oldValue(oldPos(1),oldPos(2));
            New.position(3,:) = [oldPos(1),oldPos(2)];
        end
        if oldPos(1) > 1
            New.value(4,1) = oldValue(oldPos(1)-1,oldPos(2));
            New.position(4,:) = [oldPos(1)-1,oldPos(2)];
        else
            New.value(4,1) = oldValue(oldPos(1),oldPos(2));
            New.position(4,:) = [oldPos(1),oldPos(2)];
        end
        newValue = New.value;
        newPos = New.position;
        
        
        %Softmax Equation
        possibleOptions = 1:1:4;
        numerator = exp(newValue/temperature);
        denom = sum(numerator);
        total = numerator/denom;
        probabilities = cumsum(total);
        randselect = rand(1);
        check = randselect >= probabilities;
        findChoice = find(check == 0,1,'first');
        choice = possibleOptions(findChoice);
end