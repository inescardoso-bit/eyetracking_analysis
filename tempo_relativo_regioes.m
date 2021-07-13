%função Percentagem2_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função permite calcular a percentagem de tempo que os participantes
%olharam para cada ADI

%% inputs 
% regioes: limite de x e y de cada região definida (vetor)
% total: total de pontos visualizados pelos participantes (vetor)
% nregioes: nº de regiões definidas (valor)
% colunas: nome dos participantes (vetor)
% nparticipantes: nº de participantes (valor)
%% outupts
% T: tabela do tempo relativo visualizado por regiao (colunas) e participante (linhas)
%%

function [T]=tempo_relativo_regioes(regioes,total,colunas)

        nregioes = length(regioes);
        nparticipantes=length(participants);
        colunas_tabela=[]; 
        for s=1:nregioes
            
            regiao=[];
            for p=1:nparticipantes
                regiao=[regiao; regioes(s,p)/total(p)];
            end
            colunas_tabela=[colunas_tabela regiao];
                       
        end
disp(size(colunas_tabela));
disp(size(colunas));
T = table(colunas,colunas_tabela); 

end