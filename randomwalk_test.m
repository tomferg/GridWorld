clc;clear;close all;

numwalks = 1000;
moveTotal(1:numwalks,1) = 0;
rowTotal(1:numwalks,1) = 0;
colTotal(1:numwalks,1) = 0;
rowVisitsTotal(1:numwalks,1:20) = 0;
colVisitsTotal(1:numwalks,1:20) = 0;
gridRow=20;
gridCol = 20;

format long g

for counter = 1:numwalks
    
    %Generate 20 x 20 grid
    grid = zeros(gridRow,gridCol);
    %Place random reward
    reward = 1;
    
    grid(randi(20),randi(20)) = reward;
    winner = 0;
    startx = randi(20);
    starty = randi(20);
    moveCounter = 0;
    rowVisits(1,1:20) = 0;
    colVisits(1,1:20) = 0;
    oldpos = [startx,starty];
    
    %Completely Random
    while winner == 0
        if grid(oldpos(1),oldpos(2)) == 1
            winner = 1;
            break
        end
        [newpos] = nextPos(oldpos,gridRow,gridCol);  %Random movement - choose direction
        oldpos = newpos;        
        moveCounter = moveCounter + 1;
        rowVisits(1,oldpos(1)) = rowVisits(1,oldpos(1)) + 1;
        colVisits(1,oldpos(2)) = colVisits(1,oldpos(2)) + 1;  
    end
    moveTotal(counter) = moveCounter;
    rowVisitsTotal(counter,:) = rowVisits;
    colVisitsTotal(counter,:) = colVisits;
    
    
    %Softmax - SARSA
    
    %Greedy - SARSA
    
    
    
end

disp(mean(moveTotal));
figure
plot(1:gridRow,mean(rowVisitsTotal,1));
hold on
plot(1:gridCol,mean(colVisitsTotal,1));