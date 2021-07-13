%script_estagio no ICNAS, 3º ano da licenciatura de Engenharia Biomédica
%Autora: Inês dos Santos Cardoso
%Supervisores(ICNAS): Camila Dias e João Estiveira
%Orientador (ISEC): Teresa Sousa

%Main principal que tem como objetivo, através de dados .edf e dados .mat, proceder à 
%análise de dados de eye tracking com consequente representação de resultados. 
%Duas técnicas de visualização para a representação de dados espaço temporais são 
%mapas do movimento ocular e heatmaps. O número e o sentido de sacadas bem como o número de fixações 
%são métricas também calculadas. 

close all;
clear all;
clc;

%colocar a 1 para analisar trials corretas e erradas
corretoErrado=0;
%colocar a 1 para análise balanceada
balanceado=0;

%% Inputs %explicar inputs
nruns=4; %número de runs que temos ou desejamos usar
nregioes=5; %número de regiões definidas
nparticipantes=20; %número de participantes
gridx1 = 720-474/2:1:720+474/2; %limites imagem
gridx2 = 500-540/2:1:500+540/2; 
base = imread('baseline.jpg'); %imagens que fazem parte da experiência
sadL = imread('anti_left.jpg');
sadR = imread('anti_right.jpg');
neutralL = imread('neutral_left.jpg');
neutralR = imread('neutral_right.jpg');
happyL = imread('pro_left.jpg');
happyR = imread('pro_right.jpg');
dir_files = "C:\Users\35192\Desktop\matlab_estag"; %diretoria dos dados

%participantes na experiência
participants = char('P01','P02','P03', 'P04', 'P05', 'P06',...
         'P07','P08','P09', 'P10','P11', 'P12', 'P13', 'P14',...
         'P15','P16', 'P17','P18', 'P19', 'P20');
     


image=happyR; %determinar imagem a ser usada 
 
%para cada ADI
nariz=[];
olhoE=[];
olhoD=[];
boca=[];
fora=[];
total=[];
numbersacadas=[]; %numero sacadas
numberDirEsq=[]; %sacadas direita para a esquerda da face de estimulação
numberEsqDir=[]; %sacadas esquerda para a direita da face de estimulação
fixacoesAll=[]; %fixacoes de todos os participantes
    
for p = 1:length(participants)
    
    %para cada ADI
    narizP=0;
    olhoEP=0;
    olhoDP=0;
    bocaP=0;
    foraP=0;
    totalP=0;
    %concatena pontos das sacadas
    psx1=[];
    psx2=[];
    psy1=[];
    psy2=[];
    
    participant_name = participants(p,:); %input de loadData
    %participant_name = participants;
    disp(participant_name)
    
    %carregar os dados
    [run,data]=loadData(dir_files,participant_name,nruns); %função loadData
    
    %para juntar coordenadas das 4 runs
    xcord=[];
    ycord=[];
    xruns=[];
    yruns=[];
    
    %inputs e outputs de sacinfo
    xsac=[];
    ysac=[];
    sacadas=[];
    fixacoes=[];
    psacadasx=[];
    psacadasy=[];
    sacadasplot=[];
    EsqDir=0;
    DirEsq=0;
    
    for r = 1:nruns
        erro1=f_identifyErrors(data(r).Output.Run); %%ativar para
        %monitorização de erro
        t = double((run(r).Samples.time - run(r).Samples.time(1)))/1000;
        x = run(r).Samples.gx(1,:);
        y = run(r).Samples.gy(1,:);
        instStart = data(r).Output.Run.dataMat(7,:); %início de cada run
        instFinish = data(r).Output.Run.dataMat(8,:); %fim de cada run
        
        %array com numeros das caras (120)
        A = data(r).Output.Run.dataMat(1,:);
        
        %encontrar trials das mesmas caras
        Expr7 = find(A==7); %7 = sad (anti) right
        Expr6 = find(A==6); %6 = sad (anti) left
        Exprsad= cat(2,Expr7,Expr6); %concatena sad
        Expr5 = find(A==5); %5 = happy (pro) right
        Expr4 = find(A==4); %4 = happy (pro) left
        Exprhappy= cat(2,Expr5,Expr4); %concatena happy
        Expr3 = find(A==3); %3 = neutral right
        Expr2 = find(A==2); %2 = neutral left
        Exprneutral= cat(2,Expr3,Expr2); %concatena neutral
        
%% Correto e Errado
%         %encontrar trials das mesmas caras com erro ou sem erro
%         %errou tem valor 1 
%         %acertou tem valor 0 
        if (corretoErrado==1)
        %% Para expressão triste
        Expr7corr = find(A==7 & erro1==0);%7 = sad (anti) right
        Expr7erro = find(A==7 & erro1==1); 
        Expr6corr = find(A==6 & erro1==0);%6 = sad (anti) left
        Expr6erro = find(A==6 & erro1==1);
        Exprsadcorr= cat(2,Expr7corr,Expr6corr);
        Exprsaderro= cat(2,Expr7erro,Expr6erro);
        %% Para expressão feliz
        Expr5corr = find(A==5 & erro1==0);%5 = happy (pro) right
        Expr5erro = find(A==5 & erro1==1);
        Expr4corr = find(A==4 & erro1==0);%4 = happy (pro) left
        Expr4erro = find(A==4 & erro1==1);
        Exprhappycorr= cat(2,Expr5corr,Expr4corr);
        Exprhappyerro= cat(2,Expr5erro,Expr4erro);
        %% Para expressão neutra
        Expr3corr = find(A==3 & erro1==0);%3 = neutral right
        Expr3erro = find(A==3 & erro1==1); 
        Expr2corr = find(A==2 & erro1==0);%2 = neutral left
        Expr2erro = find(A==2 & erro1==1);
        Exprneutralcorr= cat(2,Expr2corr,Expr3corr);
        Exprneutralerro= cat(2,Expr2erro,Expr3erro);
        %% para juntar expressões todas
        Exprtotalcorr= find(erro1==0);
        Exprtotalerro= find(erro1==1);
        hold on
        end
        
        if (balanceado==1)
        %% para comparação balanceada
            if length(Expr5corr)> length(Expr5erro)
                randomArray = randperm(length(Expr5corr),length(Expr5erro));
                Expr5corr=Expr5corr(randomArray);
            else 
                randomArray = randperm(length(Expr5erro),length(Expr5corr));
                Expr5erro=Expr5erro(randomArray);

            end
        end

%%       
        for i=1:length(Expr7corr)
            
            startTime = instStart(Expr7corr(i)) %tempo que inicia social instruction e vamos buscar os pontos correspondentes
            endTime = instFinish(Expr7corr(i)) %tempo que termina social instruction
            index = find(t>=startTime & t<=endTime); %index das runs
            xruns=[xruns x(index)]; %junta x(index) das 4 runs
            yruns=[yruns y(index)]; %junta y(index) das 4 runs
            xcord=[xcord x(index)];
            ycord=[ycord y(index)]; 
            
        end
        
%% Função sacinfo
        [nsacadas,fixacoes, psacadasx, psacadasy,sacadas,EsqDir,DirEsq]=sacinfo(xcord,ycord,xsac,ysac,sacadas,psacadasx,psacadasy,fixacoes,DirEsq,EsqDir);
        
    end
    
    for u=1:length(xruns)     
         if (xruns(u)>700 && xruns(u)<750 && yruns(u)>450 && yruns(u)<599)
             narizP=narizP+1; %juntar pontos do nariz da face de estimulação

         elseif (xruns(u)>625 && xruns(u)<800 && yruns(u)>600 && yruns(u)<675)
             bocaP=bocaP+1; %juntar pontos da boca da face de estimulação

         elseif (xruns(u)>600 && xruns(u)<699 && yruns(u)>375 && yruns(u)<550)
             olhoDP=olhoDP+1; %juntar pontos do olho direito da face de estimulação

         elseif (xruns(u)>751 && xruns(u)<850 && yruns(u)>375 && yruns(u)<550)
             olhoEP=olhoEP+1; %juntar pontos do olho esquerdo da face de estimulação

         else 
                 foraP=foraP+1; %juntar pontos da área fora das outras áreas da face de estimulação
         end
    end
    
    TotalP=narizP+bocaP+olhoEP+olhoDP+foraP; %total dos pontos
    nariz=[nariz narizP]; %concatena pontos nariz
    boca=[boca bocaP]; %concatena pontos boca
    olhoE=[olhoE olhoEP]; %concatena pontos olho esquerdo
    olhoD=[olhoD olhoDP]; %concatena pontos olho direito
    fora=[fora foraP]; %concatena pontos fora
    total=[total TotalP]; %concatena pontos total

    sacadasplot=[sacadasplot sacadas]; %concatena pontos sacada
    fixacoesAll=[fixacoesAll; fixacoes];

    numberEsqDir=[numberEsqDir EsqDir]; %concatena numero sacadas
    numberDirEsq=[numberDirEsq DirEsq]; %concatena sacadas direita para a esquerda da face de estimulação
    numbersacadas=[numbersacadas nsacadas]; %concatena sacadas esquerda para a direita da face de estimulação
    
    
    psx1=[psx1 psacadasx(:,1)']; %concatena pontos x(inicial) da sacada
    psx2=[psx2 psacadasx(:,2)']; %concatena pontos x(final) da sacada

    psy1=[psy1 psacadasy(:,1)']; %concatena pontos y(inicial) da sacada
    psy2=[psy2 psacadasy(:,2)']; %concatena pontos y(final) da sacada

    
%     %% movimento ocular
%     PlotMov(xruns,yruns,gridx1,gridx2,image);
%     
%     %% Plot Sacadas e fixções
%     %plot das sacadas e das fixações
%     PlotFix(fixacoes,gridx1,gridx2,image)
%     PlotSac(sacadas,psx1,psy1,psx2,psy2,gridx1,gridx2,image);


end

Regioes=[olhoE;olhoD;nariz;boca;fora;total];

%% Determinar tempo relativo de cada região e guardar em Excel


% %determinar tabela para o excel    
% [T]=tempo_relativo_regioes(Regioes,total,nregioes,participants,nparticipantes);
% 
% 
% %escrever para o excel      
% writetable(T,'results.xlsx', 'Sheet', 'check'); %guardar tempo relativo que cada participante olhou para cada região definida
% 
% %% Heatmap   
%  heatmap_ines(fixacoesAll,gridx1,gridx2,image);
