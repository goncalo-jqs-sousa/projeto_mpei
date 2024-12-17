clear all;
clc;

load("Dataset_reduzido.mat", 'Data');

% Categorias = "Film & Animation" = 1, "Music" = 10, "Sports" = 17, 
%                   "News & Politics" = 25
% Numero de Documentos por Categoria = +2000 por cada
Cat = [10, 25];
n_vezes = 3;
n_max_word = 40;

dbstop if error;
% Testes
for i = 1 : n_vezes
    NB_test_func(Data,Cat,Cat(1),400,200,false,'teste_noTag_400x200_music.txt',n_max_word, false);

    NB_test_func(Data,Cat,Cat(2),400,200,false,'teste_noTag_400x200_news.txt',n_max_word, false);
    
    NB_test_func(Data,Cat,Cat(1),200,50,true,'teste_200x50_music.txt',n_max_word, false);

    NB_test_func(Data,Cat,Cat(1),200,200,true,'teste_200x200_music.txt',n_max_word, false);
    
    NB_test_func(Data,Cat,Cat(1),400,50,true,'teste_400x50_music.txt',n_max_word, false);

    NB_test_func(Data,Cat,Cat(1),400,200,true,'teste_400x200_music.txt',n_max_word, false);
    
    NB_test_func(Data,Cat,Cat(2),400,50,true,'teste_400x50_news.txt',n_max_word, false);

    NB_test_func(Data,Cat,Cat(2),400,200,true,'teste_400x200_news.txt',n_max_word, false);

    NB_test_func(Data,Cat,Cat(1),400,200,true,'teste_noDesc_400x200_music.txt',n_max_word, true);

    NB_test_func(Data,Cat,Cat(2),400,200,true,'teste_noDesc_400x200_news.txt',n_max_word, true);

    
end
