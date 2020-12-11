function [newValue,newPos,choice] = greedyPos(oldValue,oldPos,exploreRate,numberRow,numberCol)
        
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
        
        %Choose Max
        [value,choice] = max(New.value);
        %Check if the values are equal?
        [ties] = find(New.value == value);
        %Breaks tie randomly
        if sum(ties) > 1
            choice = ties(randi(length(ties)));
        end
        
        %Randomize based on the explore rate
        if exploreRate > rand
            choice = randi(4);
        end
             
end