%função heatmap_ines_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Esta função permite determinar o heatmap
%codigo heatmap adaptado da função ksdensity

%% inputs
% fixacoes: coordenadas das fixacoes realizadas pelos participantes (vetor)
% gridx1 e gridx2: limite da imagem eixo do xx e limite da imagem do eixo
% do yy, respetivamente (vetor com limite inferior e superior)
% image: imagem escolhida para fundo do heatmap
%% output
% plot do heatmap
%%
function []= heatmap_ines(fixacoes,gridx1,gridx2,image)

[x1,x2] = meshgrid(gridx1, gridx2);
x1 = x1(:);
x2 = x2(:);
xi = [x1 x2];

[fout,xout] = mvksdensity(fixacoes,xi);
x1 = xout(:,1);
x2 = xout(:,2);

[xq,yq,z] = computeGrid(x1,x2,fout);

figure
imagesc([gridx1(1) gridx1(end)], [gridx2(1) gridx2(end)], image);
% alpha 1;
hold on
contour(xq,yq,z,'LineWidth',18);
shading flat
view(2);
colorbar
c=colorbar;
c.Label.String = 'Densidade de probabilidade';
xlabel('eixo horizontal do ecrã (pixel)');
ylabel('eixo vertical do ecrã (pixel)');
title('Heatmap');
colormap jet;
alpha 0.5;
xlim([gridx1(1) gridx1(end)])
ylim([gridx2(1) gridx2(end)])
grid off

    function [xq,yq,z] = computeGrid(x1,x2,fout)
        
        x = linspace(min(x1),max(x1));
        y = linspace(min(x2),max(x2));
        [xq,yq] = meshgrid(x,y);
        warning('off','all');
        z = griddata(x1,x2,fout,xq,yq);
        
    end


end