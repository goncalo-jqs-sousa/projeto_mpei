clear all;
clc;

load("Dataset_reduzido.mat", 'Data');

% Categorias = "Film & Animation" = 1, "Music" = 10, "Sports" = 17, 
%                   "News & Politics" = 25
% Numero de Documentos por Categoria = +2000 por cada
Cat = [10, 25];
n_vezes = 1;


dbstop if error;
% Testes
for i = 1 : n_vezes
    % NB_test_func(Data,Cat,Cat(1),400,200,false,1,'teste_noTag_400x200_music.txt');

    % NB_test_func(Data,Cat,Cat(2),400,200,false,1,'teste_noTag_400x200_news.txt');
    
    % NB_test_func(Data,Cat,Cat(1),200,50,true,1,'teste_200x50_music.txt');

    % NB_test_func(Data,Cat,Cat(1),200,200,true,1,'teste_200x200_music.txt');
    
    % NB_test_func(Data,Cat,Cat(1),400,50,true,1,'teste_400x50_music.txt');

    % NB_test_func(Data,Cat,Cat(1),400,200,true,1,'teste_400x200_music.txt');
    
    % NB_test_func(Data,Cat,Cat(2),400,50,true,1,'teste_400x50_news.txt');

    % NB_test_func(Data,Cat,Cat(2),400,200,true,1,'teste_400x200_news.txt');
    
    % NB_test_func(Data,Cat,Cat(1),400,50,true,2,'teste_400x50_music_n2.txt');

    % NB_test_func(Data,Cat,Cat(1),400,200,true,2,'teste_400x200_music_n2.txt');

    % NB_test_func(Data,Cat,Cat(2),400,50,true,2,'teste_400x50_news_n2.txt');

    % NB_test_func(Data,Cat,Cat(2),400,200,true,2,'teste_400x200_news_n2.txt');

    NB_test_func(Data,Cat,Cat(2),400,200,true,2,'algo.txt');
end


%% Analise dos Resultados
% TODO: COMPLETAR