%função PlotFix_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função permite realizar o plot das sacadas e das fixações

%% inputs 
%gridx1 e gridx2: limite da imagem eixo do xx e limite da imagem do eixo
% do yy, respetivamente (vetor com 2 posiçoes, correspondentes ao limite inferior e superior)
%image: imagem escolhida para fundo do heatmap
%fixacoes: coordenadas x e y das fixaçoes realizadas pelos participantes (vetor)
%% output
% plot das coordenadas das fixações
%%

function []=PlotFix(fixacoes,gridx1,gridx2,image)

    %% plot fixaçoes 
    figure
    imagesc([gridx1(1) gridx1(end)], [gridx2(1) gridx2(end)], image);
    hold on 
    plot(fixacoes(:,1), fixacoes(:,2)-40,'k.');
    xlabel('eixo horizontal do ecrã (pixel)');
    ylabel('eixo vertical do ecrã (pixel)');
    title('Fixações');
    xlim([gridx1(1) gridx1(end)])
    ylim([gridx2(1) gridx2(end)])
    
    
end
