function [errors] = f_identifyErrors(S)
    
    %% Identify Social Errors in the dataMat matrix obtained during acquisition
    %   Social errors for keypress and saccade
    %   Multiple click and Antecipated resposnses are also accounted for
    %but are not identified in all of the social error types (Go<->NoGo,...)
    
    S.socialErrorType_KeyPress = zeros(1,S.NrTrials);
    S.socialErrorType_Saccade = zeros(1,S.NrTrials);
    errors = zeros(1,S.NrTrials);
    
    ParCode = [S.SUBJECT S.RUN_ID];
    dataMat = S.dataMat(:,:);
    picNr = S.instMatRand;
    
    %%
    % S.socialErrorType_KeyPress:
    %       = 1 -> Go instead NoGo
    %       = 2 -> NoGo instead Go
    %       = 3 -> Anti instead Pro
    %       = 4 -> Pro instead Anti
    %       = 5 -> Antecipated Go instead NoGo
    %       = 6 -> Antecipated NoGo instead Go
    %       = 7 -> Antecipated Anti instead Pro
    %       = 8 -> Antecipated Pro instead Anti
    
    % S.socialErrorType_Saccade:
    %       = 1 -> Go instead NoGo
    %       = 2 -> NoGo instead Go
    %       = 3 -> Anti instead Pro
    %       = 4 -> Pro instead Anti
    %       = 5 -> Antecipated Go instead NoGo
    %       = 6 -> Antecipated NoGo instead Go
    %       = 7 -> Antecipated Anti instead Pro
    %       = 8 -> Antecipated Pro instead Anti
    
    %%
    for trial = 1:S.NrTrials
% SOCIAL ERRORS FOR KEYPRESS INSTRUCTION =============================================== 
        if dataMat(4,trial) == 1 % targetShown == 1 (square corresponding to keypress)
            % No-Go Social Instructions 
            if picNr(trial) == 2 || picNr(trial) == 3
                % Go instead of No-Go
                if dataMat(3,trial) == 1 || dataMat(3,trial) == 2 || dataMat(3,trial) == 31 || dataMat(3,trial) == 32
                    S.socialErrorType_KeyPress(trial) = 1;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 41 || dataMat(3,trial) == 42
                    S.socialErrorType_KeyPress(trial) = 5;
                    errors(trial) = 1;
                end
            % Anti instead of pro
            elseif picNr(trial) == 4
                if dataMat(3,trial) == 2 || dataMat(3,trial) == 32
                    S.socialErrorType_KeyPress(trial) = 3;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 42
                    S.socialErrorType_KeyPress(trial) = 7;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 0
                    S.socialErrorType_KeyPress(trial) = 2;
                    errors(trial) = 1;
                end
            elseif picNr(trial) == 5
                if dataMat(3,trial) == 1 || dataMat(3,trial) == 31
                    S.socialErrorType_KeyPress(trial) = 3;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 41
                    S.socialErrorType_Keypress(trial) = 7;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 0
                    S.socialErrorType_KeyPress(trial) = 2;
                    errors(trial) = 1;
                end

            % Pro instead of Anti
            elseif picNr(trial) == 6
                if dataMat(3,trial) == 1 || dataMat(3,trial) == 31
                    S.socialErrorType_KeyPress(trial) = 4;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 41
                    S.socialErrorType_Keypress(trial) = 8;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 0
                    S.socialErrorType_KeyPress(trial) = 2;
                    errors(trial) = 1;
                end
            elseif picNr(trial) == 7
                if dataMat(3,trial) == 2 || dataMat(3,trial) == 32
                    S.socialErrorType_KeyPress(trial) = 4;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 42
                    S.socialErrorType_Keypress(trial) = 8;
                    errors(trial) = 1;
                elseif dataMat(3,trial) == 0
                    S.socialErrorType_KeyPress(trial) = 2;
                    errors(trial) = 1;
                end
            end
            
% SOCIAL ERRORS FOR SACCADE INSTRUCTION =============================================== 
        elseif dataMat(4,trial) == 2 % targetShown == 2 (diamnd corresponding to Keypress)
            % No-Go Social Instructions 
            if picNr(trial) == 2 || picNr(trial) == 3
                % Go instead of No-Go
                if dataMat(14,trial) == 1 || dataMat(14,trial) == 2  || dataMat(14,trial) == 31 || dataMat(14,trial) == 32 || dataMat(14,trial) == 41 || dataMat(14,trial) == 42
                    if isnan(dataMat(16,trial)) == false
                        S.socialErrorType_Saccade(trial) = 5;
                        errors(trial) = 1;
                    else
                        S.socialErrorType_Saccade(trial) = 1;
                        errors(trial) = 1;
                    end
                elseif dataMat(14,trial) == 51 || dataMat(14,trial) == 52
                    S.socialErrorType_Saccade(trial) = 5;
                    errors(trial) = 1;
                end
            % Anti instead of pro
            elseif picNr(trial) == 4
                if dataMat(14,trial) == 2 || dataMat(14,trial) == 31 || dataMat(14,trial) == 32 || dataMat(14,trial) == 42
                    if isnan(dataMat(16,trial)) == false
                        S.socialErrorType_Saccade(trial) = 7;
                        errors(trial) = 1;
                    else
                        S.socialErrorType_Saccade(trial) = 3;
                        errors(trial) = 1;
                    end
                elseif dataMat(14,trial) == 52
                    S.socialErrorType_Saccade(trial) = 7;
                    errors(trial) = 1;
                elseif dataMat(14,trial) == 0
                    S.socialErrorType_Saccade(trial) = 2;
                    errors(trial) = 1;
                end
            elseif picNr(trial) == 5
                if dataMat(14,trial) == 1  || dataMat(14,trial) == 31 || dataMat(14,trial) == 32 || dataMat(14,trial) == 41
                    if isnan(dataMat(16,trial)) == false
                        S.socialErrorType_Saccade(trial) = 7;
                        errors(trial) = 1;
                    else
                        S.socialErrorType_Saccade(trial) = 3;
                        errors(trial) = 1;
                    end
                elseif dataMat(14,trial) == 51
                    S.socialErrorType_Saccade(trial) = 7;
                    errors(trial) = 1;
                elseif dataMat(14,trial) == 0
                    S.socialErrorType_Saccade(trial) = 2;
                    errors(trial) = 1;
                end
            % Pro instead of Anti
            elseif picNr(trial) == 6
                if dataMat(14,trial) == 1 || dataMat(14,trial) == 31 || dataMat(14,trial) == 32 || dataMat(14,trial) == 41
                    if isnan(dataMat(16,trial)) == false
                        S.socialErrorType_Saccade(trial) = 8;
                        errors(trial) = 1;
                    else
                        S.socialErrorType_Saccade(trial) = 4;
                        errors(trial) = 1;
                    end
                elseif dataMat(14,trial) == 51
                    S.socialErrorType_Saccade(trial) = 8;
                    errors(trial) = 1;
                elseif dataMat(14,trial) == 0
                    S.socialErrorType_Saccade(trial) = 2;
                    errors(trial) = 1;
                end
            elseif picNr(trial) == 7
                if dataMat(14,trial) == 2 || dataMat(14,trial) == 31 || dataMat(14,trial) == 32 || dataMat(14,trial) == 42
                    if isnan(dataMat(16,trial)) == false
                        S.socialErrorType_Saccade(trial) = 8;
                        errors(trial) = 1;
                    else
                        S.socialErrorType_Saccade(trial) = 4;
                        errors(trial) = 1;
                    end
                elseif dataMat(14,trial) == 52
                    S.socialErrorType_Saccade(trial) = 8;
                    errors(trial) = 1;
                elseif dataMat(14,trial) == 0
                    S.socialErrorType_Saccade(trial) = 2;
                    errors(trial) = 1;
                end
            end
        end
    end
    
    
end