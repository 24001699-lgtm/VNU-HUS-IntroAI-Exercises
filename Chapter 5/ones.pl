% Create a solution for Exercise 5.5, page 88
p(0) :- !.
p(N) :- write(1), write(' '), N1 is N-1, p(N1).
:- p(1024), nl.
