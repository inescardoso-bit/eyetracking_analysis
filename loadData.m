%função loadData_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função tem como objetivo relizar o Load e concatenar a informação run
%e data

%% inputs 
%dir_files: diretoria dos ficheiros
%participant_name: nomes dos participantes (vetor)
%nruns: número de runs (valor)
%% outputs
%run: coordenadas dos dados de eyetracking e os tempos em formato .edf (vetor)
%data: coordenadas dos dados de eyetracking e os tempos em formato .mat (vetor)
%%
function [run,data]=loadData(dir_files,participant_name,nruns)

    run=[];
    data=[];
    
    
    eyeTrackerDir = char(dir_files + "\" + participant_name + "\edffiles"); %acesso aos ficheiros .edf
    dataMatDir = char(dir_files + "\" + participant_name + "\matfiles"); %acesso aos ficheiros .mat
    matfiles = dir(fullfile(dataMatDir,"*.mat")); %definir matfiles
    edffiles = dir(fullfile(eyeTrackerDir,"*.edf")); %definir edffiles

    for i=1:nruns
        
        %importar dados eye tracker
        runi = edfImport(char(strcat(eyeTrackerDir,"\" ,edffiles(i).name)), [1 1 1], '');
        run=[run runi];
        
        %importar dados .mat
        datai = load(char(strcat(dataMatDir,"\",matfiles(i).name)));
        data=[data datai];
    end

end
