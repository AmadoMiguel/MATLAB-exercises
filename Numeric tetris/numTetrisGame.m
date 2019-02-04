clear, clc
% Create instance and initialize the game.
game = NumTetris(5,'playing','false',5,5);
while (strcmp(game.status, 'playing'))
    % Next number
    game.randNextNum();
    % Show game information
    clc
    game.displayInfo()
    % Asks the user to prompt in the colum and locate next number in the 
    % selected column
    game.locateNumber()
    % If number couldn't be located, game finishes
    if strcmp(game.locatedNum,'false')
        clc
        disp('     WRONG! ')
        disp('     YOU LOST! ')
        game.status = 'lost';
        disp(['     Final score = ', num2str(game.score)])
    else
        game.locatedNum = 'false';
        % This method and the ones called within it do all numeric 
        % procedures.
        game.checkSides()
    end
    % Checks if user won
    if game.score >= 1000
        game.status = 'won';
    end
end
if strcmp(game.status, 'won')
    clc
    disp('     CONGRATULATIONS! ')
    disp('     YOU WON! ')
    disp(['     Final score = ', num2str(game.score)])
end