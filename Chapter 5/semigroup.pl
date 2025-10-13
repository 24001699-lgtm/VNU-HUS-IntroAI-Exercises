% Create a solution for Exercise 5.1, page 88. More precisely, you will attempt to prove the equality of left- and right-neutral elements of semigroups with PROLOG and fail. Try to explain why?
% Phép nhân của semigroup: op(X,Y,Z) nghĩa là X·Y = Z

% left_identity(E): E là trung hòa trái nếu E * X = X với mọi X
left_identity(E) :-
    \+ (op(E, X, Y), X \= Y).

% right_identity(E): E là trung hòa phải nếu X * E = X với mọi X
right_identity(E) :-
    \+ (op(X, E, Y), X \= Y).

% kiểm tra nếu left_identity(L) và right_identity(R) thì L = R
check_identity(L,R) :-
    left_identity(L),
    right_identity(R),
    L = R.
