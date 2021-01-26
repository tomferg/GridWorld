%% Random Walk
% This solves the grid world problem

%To Do: turn this into a function?
%make sure all options are available?

%Clear workspace
clc;clear;close all;

%% Grid World Parameters
%All these parameters can be modified
format long g
addpath('./Functions/');
%Determine number of walks
numberPaths = 100;

%Generate Grid World
numActor = 4; %North,South,East,West
gridRow=20;
gridCol=20;
grid = zeros(gridRow,gridCol);
%Place random reward location
reward = 1;
grid(randi(gridRow),randi(gridCol)) = reward;
%Initialize random Start location
startX = randi(gridRow);
startY = randi(gridCol);
CurrentX = startX;
CurrentY = startY;

%Initialize the Row, Col, and moves takens
rowVisits(1,1:gridRow) = 0;
colVisits(1,1:gridCol) = 0;
movesTaken = 0;
overallMoves(1,1:numberPaths) = 0;

%Generate Path (for plotting)
path = zeros(gridRow,gridCol,numberPaths);
expectedValue(gridRow,gridCol) = 0; %this initializes what the initial win parameters are
actorValue = zeros(gridRow,gridCol,numActor); %essentially keeps track of all actors
%Parameters for possible solutions
learningRate = 0.5; %Learning rate for the Prediction Error
discountFactor = 0.95; %This is the discounting factor
explorationRate = 0.1; %explore rate for the greedy model
temperature = 0.001; %Temperature for the softmax function

%% Solution Choices
%You need the following action functions for this to work:
%You need the following method functions for this work:

solution.action = 'SoftmaxPos'; %Can be GreedyPos, SoftmaxPos, RandomPos
solution.method = 'SARSA'; %Can be QLearning, SARSA, ActorCritic (all using TD)


%% Trials
for pathCounter = 1:numberPaths
    disp(strcat(['Trial ', num2str(pathCounter)]));
    winner = 0;
    rewardVal = 0;
    currentPos = [startX,startY];
    currentPath = [CurrentX,CurrentY];
    movesTaken = 0;
    %Generate path grid
    pathGrid(1:gridRow,1:gridCol) = 0;

    
    while ~winner 
        oldValues = expectedValue(currentPos(1),currentPos(2)); %assigns the expected values
        oldPos = currentPos; %save the old position  
        choiceValues = []; %deletes the choice values
        %This is the action solution we want to use
        switch solution.action
            case 'GreedyPos'
                [choiceValues,newPositions,choice] = greedyPos(expectedValue,oldPos,explorationRate,gridRow,gridCol);
            case 'SoftmaxPos'
                [choiceValues,newPositions,choice] = softmaxPos(expectedValue,oldPos,temperature,gridRow,gridCol);
            case 'RandomPos'
                [choiceValues,newPositions,choice] = nextPos(expectedValue,oldPos,gridRow,gridCol);
        end
        %This is the solution method
        switch solution.method
            case 'SARSA'
                newValue = choiceValues(choice); %just goes with the one chose by the action
            case 'ActorCritic'
                  newValue= actorValue(newPositions(choice,1),newPositions(choice,2),choice); %Updates the actor & critic
            case 'QLearning'
                newValue = max(choiceValues); %updates the maximal one
        end
        
        %Assign Actor Critic Values
        %actorValue = actorValue(CurrentX,CurrentY,choice);
        
        %Assign new position to current
        currentPos(1) = newPositions(choice,1);
        currentPos(2) = newPositions(choice,2);
        
        %Determine if Winner - if so breaks while loop
        if grid(currentPos(1),currentPos(2)) == 1
            winner = 1;
            rewardVal = 1;
            %break
        end
        
        %Prediction Error for TD learning
        PredictError = rewardVal + discountFactor*newValue - oldValues;
        
        %Update expected values
        expectedValue(oldPos(1),oldPos(2)) = expectedValue(oldPos(1),oldPos(2)) + learningRate*PredictError;
        
        %Constrain model to avoid problems - this just avoids it going
        %larger than -1 and 1 (breaks model if not)
        if expectedValue(oldPos(1),oldPos(2)) > 1
            expectedValue(oldPos(1),oldPos(2)) = 1;
        end
        if expectedValue(oldPos(1),oldPos(2)) < -1
            expectedValue(oldPos(1),oldPos(2)) = -1;
        end        
        
        %Update Actor and constrain
        if strcmp(solution.method,'ActorCritic') == 1 %Can be Q-Learning, SARSA, ActorCritic (all using TD)
                 %Update Actor
                 actorValue(oldPos(1),oldPos(2),choice) = actorValue(oldPos(1),oldPos(2),choice) +learningRate*PredictError;
                 if actorValue(oldPos(1),oldPos(2)) < -1
                     actorValue(oldPos(1),oldPos(2)) = -1;
                 end
                 if actorValue(oldPos(1),oldPos(2)) > 1
                     actorValue(oldPos(1),oldPos(2)) = 1;
                 end     
        end 

        pathGrid(oldPos(1),oldPos(2)) = 0.5;
        pathGrid(currentPos(1),currentPos(2)) = 1;
        
        movesTaken = movesTaken + 1; %adds to the move counter
        

        
    end
    overallMoves(1,pathCounter) = movesTaken;
    path(:,:,pathCounter) = pathGrid;
end

%% Output plots

figure
%Moves Taken - Bar graph
subplot(2,3,1);
bar(overallMoves);

%Path - Wavelet
% subplot(2,3,2);
% surf(path);

%Expected Values - Wavelet
subplot(2,3,2);
surf(expectedValue)
title('Expedted Values');
caxis([-1 1]);
view(2);
xlim([1,20]);ylim([1,20]);
set(gca,'YDir','reverse');

%Actual Path Needed - Wavelet
subplot(2,3,4);
maze = grid;
maze(startX,startY) = 2;
surf(maze)
xlim([1,20]);ylim([1,20]);
view(2);
%legend('Blue=Start','Yellow=Win');
set(gca,'YDir','reverse');

%First Walk
subplot(2,3,5);
surf(path(:,:,1));
view(2);
xlim([1,20]);ylim([1,20]);
set(gca,'YDir','reverse');


%Last Walk
subplot(2,3,6);
surf(path(:,:,numberPaths));
view(2);
xlim([1,20]);ylim([1,20]);
set(gca,'YDir','reverse');


%Actor values?
% subplot(2,3,4);
