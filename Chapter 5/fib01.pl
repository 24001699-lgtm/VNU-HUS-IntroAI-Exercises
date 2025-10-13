% Create a solution for Exercise 5.8(c)
% fib01.pl
:- dynamic fib_memo/2.

fib_memo(0, 1).
fib_memo(1, 1).

fib(N, R) :-
    fib_memo(N, R), !.               

fib(N, R) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, R1),
    fib(N2, R2),
    R is R1 + R2,
    asserta(fib_memo(N, R)).       
