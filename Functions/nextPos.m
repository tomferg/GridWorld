function [newValue,newPos,choice] = nextPos(oldValue,oldPos,numberRow,numberCol)
        


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
        
        choice = randi(4);
        newValue = New.value;
        newPos = New.position;
       

end