%função sacinfo_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função permite calcular o número de sacadas, a sua direção e o número
%de fixações
%% inputs
% xcord: coordenadas X visualizadas (vetor)
% ycord: coordenadas Y visualizadas (vetor)
% xsac: coordenadas X para avaliar sacadas (neste parametro pode ser introduzido um vetor vazio ao qual se vao adicionar coordenadas X)
% ysac: coordenadas Y para avaliar sacadas (neste parametro pode ser
% introduzido um vetor vazio ao qual se vao adicionar coordenadas Y)
% sacadas: coordenadas sacadas necessárias para plot das sacadas (vetor vazio)
% psacadasx: X das sacadas para desenhar ponto de inicio e fim das sacadas
% (vetor vazio)
% psacadasy: Y das sacadas para desenhar ponto de inicio e fim das sacadas
% (vetor vazio)
% fixacoes: coordenadas das fixacoes (vetor vazio)
% DirEsq: nº sacadas sentido esquerda- direita (vetor vazio)
% EsqDir: nº sacadas sentido direita- esquerda (vetor vazio)
%% outputs
% nsacadas: numero de sacadas (valor)
% fixacoe: fixacoes realizadas (vetor)
% psacadasx: pontos X das sacadas para desenhar ponto de inicio e fim das sacadas(vetor)
% psacadasy: ponto Y das sacadas para desenhar ponto de inicio e fim das sacadas(vetor)
% sacadas: coordenadas sacadas necessárias para plot das sacadas(vetor)
% EsqDir: nº sacadas sentido esquerda- direita (vetor)
% DirEsq: nº sacadas sentido direita- esquerda (vetor)
%%

function [nsacadas,fixacoes, psacadasx, psacadasy,sacadas,EsqDir,DirEsq]=sacinfo(xcord,ycord,xsac,ysac,sacadas,psacadasx,psacadasy,fixacoes,DirEsq,EsqDir)

    nsacadas=0; %conta numero de sacadas
    for i=1:length(xcord)
        xsac=[xsac xcord(i)]; 
        ysac=[ysac ycord(i)];
        if ~issorted(xsac,'monotonic') %senao for monótono
            xamp=xsac(end-1)-xsac(1); %amplitude entre 1ºponto e ultimo
            if abs(xamp)>=19.8  %amplitude superior a 0.5 graus
               if length(xsac)>16
                   sacadas=[sacadas; xsac(1:end-1)' ysac(1:end-1)'];%guarda coordenadas sacadas 
                   psacadasx=[psacadasx; xsac(1) xsac(end-1)]; %guarda x das sacadas
                   psacadasy=[psacadasy; ysac(1) ysac(end-1)]; %guarda y das sacadas
                   if (xsac(1)<xsac(end-1))
                        EsqDir=EsqDir+1; 
                   else
                        DirEsq=DirEsq+1;
                   end
                    xsac=[];
                    ysac=[];
                   nsacadas=nsacadas+1; %numero de sacadas
               end
            else
               fixacoes=[fixacoes; xsac' ysac']; %coordenadas das fixacoes
               xsac=[];
               ysac=[];
            end
        end  
    end
end