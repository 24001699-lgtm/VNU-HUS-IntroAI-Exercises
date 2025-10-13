% Create a solution for Exercises 5.2 and 5.3, page 88 using plan.pl
start :-
    action(state(left,left,left,left),
           state(right,right,right,right)).

% state(Farmer,Wolf,Goat,Cabbage)
% left/right thể hiện bên nào đang đứng

action(Start,Goal) :-
   plan(Start,Goal,[Start],Path),
   nl, write('Solution:'), nl,
   write_path(Path), nl, fail.   % in chuỗi hành động đẹp

plan(Start,Goal,Visited,Path) :-
   go(Start,Next),
   safe(Next),
   \+ member(Next,Visited),
   plan(Next,Goal,[Next|Visited],Path).
plan(Goal,Goal,Path,Path).

% Di chuyển: Farmer có thể đi một mình hoặc mang theo một trong 3 thứ
go(state(X,X,Z,K),state(Y,Y,Z,K)) :- across(X,Y). % farmer + wolf
go(state(X,W,X,K),state(Y,W,Y,K)) :- across(X,Y). % farmer + goat
go(state(X,W,Z,X),state(Y,W,Z,Y)) :- across(X,Y). % farmer + cabbage
go(state(X,W,Z,K),state(Y,W,Z,K)) :- across(X,Y). % farmer alone

across(left,right).
across(right,left).

% trạng thái an toàn: Wolf-Goat và Goat-Cabbage không bị để lại 1 mình
safe(state(_,W,G,C)) :-
    (W = G ; _ = _),       % nếu Wolf và Goat cùng bờ => OK
    (G = C ; _ = _),       % nếu Goat và Cabbage cùng bờ => OK
    (W \= G -> _ = _ ; true),
    (G \= C -> _ = _ ; true).

safe(state(B,W,G,C)) :-
    (W = G ; B = G),       % Goat không bị ăn bởi Wolf
    (G = C ; B = G).       % Cabbage không bị ăn bởi Goat

% ===========================================
% Bài 5.2(a): mô tả hành động
% ===========================================
write_move(state(F1,W1,G1,C1), state(F2,W2,G2,C2)) :-
    across(F1,F2),
    (
        (W1 \= W2, Actor = 'Farmer and wolf') ;
        (G1 \= G2, Actor = 'Farmer and goat') ;
        (C1 \= C2, Actor = 'Farmer and cabbage') ;
        (W1 = W2, G1 = G2, C1 = C2, Actor = 'Farmer alone')
    ),
    format('~w cross from ~w to ~w.~n', [Actor, F1, F2]).

% ===========================================

write_path([_]). 
write_path([S1,S2|Rest]) :-
    write_move(S1,S2),
    write_path([S2|Rest]).
