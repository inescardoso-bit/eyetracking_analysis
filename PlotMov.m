%função PlotMov_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função permite realizar o plot do movimento ocular
%% inputs 
%gridx1 e gridx2: limite da imagem eixo do xx e limite da imagem do eixo
% do yy, respetivamente (vetor com limite inferior e superior)
%image: imagem escolhida para fundo do heatmap
%xruns: coordenadas X dos pontos de visualização realizado pelos
%partipantes (vetor)
%yruns:coordenadas Y dos pontos de visualização realizado pelos
%partipantes (vetor)
%% output 
% plot das coordenadas do movimento ocular realizado
%%

function []=PlotMov(xruns,yruns,gridx1,gridx2,image)

    figure
    imagesc(gridx1, gridx2, image); %localização da imagem
    hold on
    plot(xruns,yruns-40)
    %legenda eixos
    xlabel('eixo horizontal do ecrã (pixel)');
    ylabel('eixo vertical do ecrã (pixel)');
    title('Movimento Ocular');
    %limites do plot
    xlim([720-474/2 720+474/2])
    ylim([500-540/2 500+540/2])
    
end

  