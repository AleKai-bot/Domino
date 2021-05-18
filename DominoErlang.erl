%Alejandro Morales Sandi
%Proyecto Nùmero 2, DFS
-module(c4).
-export([genera/3, genAux/2, combiAux/2, revuelveList/1, combinations/3, dfs/2, listFind/2]).
-record(ficha, {x, y}).
-import(lists,[nth/2]).

%Dominio: parametros(elementos y cant-fichas) 
%Codomio: llama al metodo que genera las combinaciones
genAux([],_) -> ["Lista de Fichas Vacia"];
genAux([H | T] , N)->genera(N , [H | T], []).

%Dominio: lista de elementos y cantidad  
%Codomio:genera una lista de combinaciones totales
genera(0,_, _) -> [];
genera(N,[], Q) ->  combiAux(Q , N);
genera(N,[H|T], Q) -> genera(N, T, Q ++ [ #ficha{ x=H , y=L } || L <- [H|T] ]).

%Dominio: recibe una lista cualquiera 
%Codomio: devuelve la lista en un orden diferente pero con los mismos elementos
revuelveList(List) -> Random_list = [{rand:uniform(), X} || X <- List],
    		     [X || {_,X} <- lists:sort(Random_list)].	

%Dominio: recibe la lista desordenada 
%Codomio: llama al metodo que selecciona la cantidad de fichas antes dichas
combiAux([],_) -> [];
combiAux(Q , N)-> combinations(revuelveList(Q),N,[]) .

%Dominio: lista de fichas con su cantidad especifica 
%Codomio: llama al metodo que dfs con las ficha ya seleccionadas
combinations(_, 0,P) ->  dfs(P, length(P) );
combinations([],_,_) -> [];
combinations( [H | T] , N, P) -> combinations( T, N-1, P ++  [ H ] ).

%Dominio: recibe la lista de fichas y el valor de cuantas hay 
%Codomio: va tomando cada ficha posicion por posicion para ir buscando las soluciones posibles 
dfs([],_) -> [];
dfs(_,0)->[];
dfs([H | T], Cont) -> ["Solucion"]  ++ [nth(Cont,[H | T])] ++ listFind( nth(Cont,[H | T]), [H | T]-- [nth(Cont,[H | T])] ) ++
		      dfs([H | T]  , Cont-1).

%Dominio: recibe una ficha y la lista total 
%Codomio: busca combinaciones totales entre el elemento recibido y todos los de la lista, segun un parametro especifico
listFind ( _Element, [] ) -> [];
listFind ( Element, [ Item | ListTail ] ) ->
    case ( Item#ficha.x == Element#ficha.y ) of
        true    ->  [Item] ++ listFind(Item, ListTail);
        false   ->  listFind(Element, ListTail)
    end.
