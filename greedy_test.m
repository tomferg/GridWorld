clc;clear;close all;

gridRow=20;
gridCol = 20;
numberPaths = 100;
format long g
%Generate 20 x 20 grid
grid = zeros(gridRow,gridCol);
reward = 1; %Place random reward
grid(randi(20),randi(20)) = reward;
winner = 0;
startx = randi(20);
starty = randi(20);
rowVisits(1,1:20) = 0;
colVisits(1,1:20) = 0;
oldpos = [startx,starty];
rewardVal = 0;

learningRate = [0.01,0.1,0.2,0.3,0.4,0.5];
explorationRate = 0.4;
expectedValue(1:20,1:20) = 0.5;


for LRcounter = 1:length(learningRate)
    for counter = 1:numberPaths
        winner = 0;
        moveCounter = 0;
        winnerMatrix = zeros(gridRow,gridCol);
        oldpos = [startx,starty]; %always starts in the same place for these runs?
        %Greedy - choses highest value reward except randomly
        while winner == 0
            if grid(oldpos(1),oldpos(2)) == 1
                winner = 1;
                rewardVal = 1;
                break
            end
            if explorationRate > rand %chooses a random direction (within reason)
                [newPos] = nextPos(oldpos,gridRow,gridCol);  %Random movement - choose direction
                oldpos = newPos;
            else %choose highest value action
                [newPos] = greedyPos(oldpos,gridRow,gridCol,expectedValue);
                oldpos = newPos;
            end
            winnerMatrix(oldpos(1),oldpos(2)) = winnerMatrix(oldpos(1),oldpos(2))+1;
            moveCounter = moveCounter + 1;
        end
        moveCounterTotal(counter) = moveCounter;
        disp('got here');
        %Logical index (i.e., the path) and back propogate reward
        %for counter = 1:length(numRows)
        test = find(winnerMatrix == 1);
        expectedValue(test) = expectedValue(test)+(learningRate(LRcounter)*(1-expectedValue(test)));
        %end
    end
    moveCounterTotalLR(LRcounter,:) = moveCounterTotal;
end

figure
for counter = 1:length(learningRate)
    subplot(1,length(learningRate),counter);
    plot(moveCounterTotalLR(counter,:))
    ylim([0,10000]);
    LRTitle = ['Learning Rate ',num2str(learningRate(counter))];
    title(LRTitle);
end