%função PlotSac_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função permite realizar o plot das sacadas 
%% inputs
%gridx1 e gridx2: limite da imagem eixo do xx e limite da imagem do eixo
% do yy, respetivamente (vetor com limite inferior e superior)
%image: imagem escolhida para fundo do heatmap
%sacadasplot: coordenadas das sacadas realizadas pelos participantes
%psx1: coordenada X do início sacada (vetor)
%psy1: coordenada Y do início sacada (vetor)
%psx2: coordenada X do fim sacada (vetor)
%psy2: coordenada Y do fim sacada (vetor)
%% output
% plot das coordenadas sacadas realizadas 
%%
function []=PlotSac(sacadasplot,psx1,psy1,psx2,psy2,gridx1,gridx2,image)

    %% plot sacadas
    figure
    imagesc([gridx1(1) gridx1(end)], [gridx2(1) gridx2(end)], image);
    hold on
    plot(sacadasplot(:,1), sacadasplot(:,2)-40,'k.');
    hold on
    plot(psx1,psy1-40,'r*');
    hold on
    plot(psx2,psy2-40,'m*');
    xlabel('eixo horizontal do ecrã (pixel)');
    ylabel('eixo vertical do ecrã (pixel)');
    title('Sacadas');
    xlim([gridx1(1) gridx1(end)])
    ylim([gridx2(1) gridx2(end)])
end