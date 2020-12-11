function [choiceProb] = Greedy(values,episilon,trials,numRow,numCol)
%This is just an alternative way of doing the greedy selection - more
%streamlined



[maxChoice, maxLocation] = max(values); %essentially this just feeds in the max values

%determine ties
find(values == maxChoice);

%Go with a random arm instead
if rand() < episilon
    
end



end