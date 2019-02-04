classdef NumTetris < handle
    %NumTetris Contains required properties and methods for the game.
    %   The game consists in playing a numeric tetris with only numbers of 
    %   the form 2^n, where n = [1,2,3,4,5,...]. The purpose of the game is
    %   to place adjacent powers of 2 in order to score; for example, 
    %   placing a 2 on the left side of a 4 will give a score of 6, and so
    %   on.
    
    properties
        gameMatrix = []
        score = 0
        status = ''
        locatedNum = ''
        pow2 = 0
        actualRow = 0
        
        selCol = 0
        nextNum = 0
    end
    
    methods
        function gamObj = NumTetris(matrixLen,status,locatedNum,pow2,...
                actualRow)
            % Initial properties initialization.
            gamObj.gameMatrix = zeros(matrixLen);
            gamObj.status = status;
            gamObj.locatedNum = locatedNum;
            gamObj.pow2 = pow2;
            gamObj.actualRow = actualRow;
            
            gamObj.score = 0;
        end
        % Generate next number randomly.
        function randNextNum(self)
            if self.score < power(2,self.pow2)
                self.nextNum = power(2,randi(self.pow2)-1);
            else
                self.pow2 = self.pow2 + 1;
            end
        end
        % Shows the information and the game matrix in the command window
        function displayInfo(self)
            mess1 = ['     Next number: ', num2str(self.nextNum)];
            showScore = ['     Score = ', num2str(self.score)];
            disp(mess1)
            disp('     1  |  2  |  3  |  4  |  5')
            disp('     -------------------------')
            disp(self.gameMatrix)
            disp(showScore)
        end
        
        % Checks if gameMatrix in the location (self.actualRow,self.selCol) 
        % is 0 and inserts the number in the matrix if so.
        function locateNumber(self)
            self.actualRow = 5;
            % Asks the user to prompt in the column number in which the 
            % number should "fall".
            self.selCol = input('     Select column ');
            while (strcmp(self.locatedNum,'false'))
                if self.gameMatrix(self.actualRow,self.selCol) == 0
                    self.gameMatrix(self.actualRow,self.selCol) = ...
                        self.nextNum;
                    self.locatedNum = 'true';
                else
                    self.actualRow = self.actualRow - 1;
                end
                % Number couldn't be located
                if self.actualRow == 0
                    break
                end
            end
        end
        % =================================================================
        % Numeric procedures
        % Check if there is any 2^n number on any adjacent column.
        function checkSides(self)
            r = self.actualRow;
            c = self.selCol;
            switch self.selCol
                case 5
                    checkSide(self,r,c,'left')
                case {2,3,4}
                    checkSide(self,r,c,'both')
                    checkSide(self,r,c,'left')
                    checkSide(self,r,c,'right')
                case 1
                    checkSide(self,r,c,'right')
            end
        end

        function checkSide(self,r,c,side)
            switch side
                case 'both'
                    if (self.gameMatrix(r,c)/2==self.gameMatrix(r,c-1)&&...
                            self.gameMatrix(r,c)*2==self.gameMatrix(r,c+1))
                        % Add score points
                        self.score = self.score + self.gameMatrix(r,c)+...
                            self.gameMatrix(r,c-1)+self.gameMatrix(r,c+1);
                        self.gameMatrix(r,c+1)=self.gameMatrix(r,c+1)/...
                            self.gameMatrix(r,c);
                        self.gameMatrix(r,c)=self.gameMatrix(r,c)/...
                            self.gameMatrix(r,c-1);
                        self.gameMatrix(r,c-1)=1;
                        updateMatrix(self,r,c-1)
                        updateMatrix(self,r,c)
                        updateMatrix(self,r,c+1)
                    end
                case 'left'
                    if (self.gameMatrix(r,c)/2==self.gameMatrix(r,c-1))
                        % Add score points
                        self.score = self.score + self.gameMatrix(r,c)+...
                            self.gameMatrix(r,c-1);
                        self.gameMatrix(r,c)=self.gameMatrix(r,c)/...
                            self.gameMatrix(r,c-1);
                        self.gameMatrix(r,c-1)=1;
                        updateMatrix(self,r,c-1)
                        updateMatrix(self,r,c)
                    end
                case 'right'
                    if (self.gameMatrix(r,c)*2==self.gameMatrix(r,c+1))
                        % Add score points
                        self.score = self.score + self.gameMatrix(r,c)+...
                            self.gameMatrix(r,c+1);
                        self.gameMatrix(r,c+1)=self.gameMatrix(r,c+1)/...
                            self.gameMatrix(r,c);
                        self.gameMatrix(r,c)=1;
                        updateMatrix(self,r,c)
                        updateMatrix(self,r,c+1)
                    end
            end
        end
        
        function updateMatrix(self,r,c)
            for row = r:-1:2
                self.gameMatrix(row,c) = self.gameMatrix(row-1,c);
            end
            self.gameMatrix(1,c) = 0;
        end
    end
end

