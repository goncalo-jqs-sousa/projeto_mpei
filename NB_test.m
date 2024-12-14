clear all;
clc;

load("Dataset_reduzido.mat", 'Data');

% Categorias = "Film & Animation", "Music", "Sports", "News & Politics"
% Numero de Documentos por Categoria = +2000 por cada
Cat = ["Music", "News & Politics"];

% Testes
NB_test_func(Data,Cat,Cat(1),400,50,false,1,'teste_no_tag_music.txt');
NB_test_func(Data,Cat,Cat(1),400,50,false,1,'teste_no_tag_music.txt');
NB_test_func(Data,Cat,Cat(1),400,50,false,1,'teste_no_tag_music.txt');

NB_test_func(Data,Cat,Cat(2),400,50,false,1,'teste_no_tag_news.txt');
NB_test_func(Data,Cat,Cat(2),400,50,false,1,'teste_no_tag_news.txt');
NB_test_func(Data,Cat,Cat(2),400,50,false,1,'teste_no_tag_news.txt');

NB_test_func(Data,Cat,Cat(1),200,50,true,1,'teste_200x50_music.txt');
NB_test_func(Data,Cat,Cat(1),200,50,true,1,'teste_200x50_music.txt');
NB_test_func(Data,Cat,Cat(1),200,50,true,1,'teste_200x50_music.txt');

NB_test_func(Data,Cat,Cat(1),200,200,true,1,'teste_200x200_music.txt');
NB_test_func(Data,Cat,Cat(1),200,200,true,1,'teste_200x200_music.txt');
NB_test_func(Data,Cat,Cat(1),200,200,true,1,'teste_200x200_music.txt');

NB_test_func(Data,Cat,Cat(1),400,50,true,1,'teste_400x50_music.txt');
NB_test_func(Data,Cat,Cat(1),400,50,true,1,'teste_400x50_music.txt');
NB_test_func(Data,Cat,Cat(1),400,50,true,1,'teste_400x50_music.txt');

NB_test_func(Data,Cat,Cat(1),400,200,true,1,'teste_400x200_music.txt');
NB_test_func(Data,Cat,Cat(1),400,200,true,1,'teste_400x200_music.txt');
NB_test_func(Data,Cat,Cat(1),400,200,true,1,'teste_400x200_music.txt');

NB_test_func(Data,Cat,Cat(2),400,50,true,1,'teste_400x50_news.txt');
NB_test_func(Data,Cat,Cat(2),400,50,true,1,'teste_400x50_news.txt');
NB_test_func(Data,Cat,Cat(2),400,50,true,1,'teste_400x50_news.txt');

NB_test_func(Data,Cat,Cat(2),400,200,true,1,'teste_400x200_news.txt');
NB_test_func(Data,Cat,Cat(2),400,200,true,1,'teste_400x200_news.txt');
NB_test_func(Data,Cat,Cat(2),400,200,true,1,'teste_400x200_news.txt');

%% Analise dos Resultados
% TODO: COMPLETAR