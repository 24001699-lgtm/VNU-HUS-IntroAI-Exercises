% Create a solution for Exercise 5.9, page 89
% einstein.pl -- giải bài Einstein (CLP bằng clpfd)
:- use_module(library(clpfd)).

einstein(Owner) :-
    % Các thuộc tính là biến biểu diễn vị trí (1..5) của từng giá trị
    Houses = [1,2,3,4,5],

    % Colors
    Red   = R, Green = G, White = W, Yellow = Y, Blue = B,
    Colors = [R,G,W,Y,B],
    Colors ins 1..5, all_different(Colors),

    % Nationalities
    Brit = Brit, Swede = Swede, Dane = Dane, Norwegian = Norwegian, German = German,
    Nations = [Brit,Swede,Dane,Norwegian,German],
    Nations ins 1..5, all_different(Nations),

    % Drinks
    Tea = Tea, Coffee = Coffee, Milk = Milk, Beer = Beer, Water = Water,
    Drinks = [Tea,Coffee,Milk,Beer,Water],
    Drinks ins 1..5, all_different(Drinks),

    % Smokes
    PallMall = Pall, Dunhill = Dun, Marlboro = Marl, Winfield = Win, Rothmanns = Roth,
    Smokes = [Pall, Dun, Marl, Win, Roth],
    Smokes ins 1..5, all_different(Smokes),

    % Pets
    Dog = Dog, Bird = Bird, Cat = Cat, Horse = Horse, Fish = Fish,
    Pets = [Dog,Bird,Cat,Horse,Fish],
    Pets ins 1..5, all_different(Pets),

    % Hints as constraints
    Brit #= R,                % Briton lives in the red house
    Swede #= Dog,             % Swede has a dog
    Dane #= Tea,              % Dane likes tea
    G + 1 #= W,               % green is immediately left of white
    G #= Coffee,              % owner of green drinks coffee
    Pall #= Bird,             % Pall Mall -> bird
    Milk #= 3,                % middle house drinks milk
    Y #= Dun,                 % yellow house smokes Dunhill
    Norwegian #= 1,          % Norwegian in first house
    abs(Marl - Cat) #= 1,    % Marlboro next to cat
    abs(Horse - Dun) #= 1,   % horse next to Dunhill
    Win #= Beer,              % Winfield drinks beer
    abs(Norwegian - B) #= 1, % Norwegian next to blue
    German #= Roth,           % German smokes Rothmanns
    abs(Marl - Water) #= 1,  % Marlboro smoker has neighbor who drinks water

    % Domains already set, now labeling (search)
    append(Colors, Nations, T1),
    append(T1, Drinks, T2),
    append(T2, Smokes, T3),
    append(T3, Pets, Vars),
    labeling([], Vars),

    % Find which nationality corresponds to Fish
    (Brit #= Fish -> Owner = brit ;
     Swede #= Fish -> Owner = swede ;
     Dane  #= Fish -> Owner = dane ;
     Norwegian #= Fish -> Owner = norwegian ;
     German #= Fish -> Owner = german).

% Helper to run and print result
run :-
    einstein(Owner),
    format('The fish belongs to: ~w~n', [Owner]).
