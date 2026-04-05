% ==== LOAD FILES ====
% dynamics
:- consult('engine/dynamics.pro').
% data
:- consult('data/map.pro').
:- consult('data/pokemon.pro').
:- consult('data/trainers.pro').

% ==== HELPERS ====
% take first N elements of a list
take(_, [], []).
take(N, [H | T], [H | R]):-
    N > 0,
    N1 is N - 1,
    take(N1, T, R).

% find all posible pokemon and return a random one
randomPokemon(O):-
    findall(X, type(X, _), All),
    random_member(O, All).

% generate tag
nextTag(1).
generateTag(Tag):- 
    retract(nextTag(Tag)),
    Next is + 1,
    asserta(nextTag(Next)).

% ==== POKEMON ====
level(Level, RequiredExp):- RequiredExp is 50 + (20 * Level).

% learns move at level ?
learns(Type, Move, Level):- move(Move, Type, _, Level).
learns(_, Move, Level):- move(Move, normal, _, Level).

% select the four most recent moves given level and pokemon type
encounterMoves(Pokemon, Level, Moves):-
    type(Pokemon, Type),
    findall(MoveLevel-Move, (learns(Type, Move, MoveLevel), MoveLevel =< Level), AllMoves),
    sort(0, @>=, AllMoves, Sorted),
    take(4, Sorted, Top4),
    pairs_values(Top4, Moves).

% get scaled stats
scaledAttack(BaseAtk, Level, Attack) :- Attack is BaseAtk + (Level * 2).
scaledHP(BaseHP, Level, MaxHP) :- MaxHP is BaseHP + (Level * 3).

% 

% ==== PLAYER ====
% player(money, [team])
player(0, []).

% player state
traveling(none, none, none).
battling(none, none).
idling(map).

% active pokemon
activePokemon(none, none).

% eggs player has aquired
playerEggs(none, none, none).

% default location
location(littleroot, square).

% move to another city
travel(City, Location) :-
    retractall(location(_, _)),
    asserta(location(City, Location)).

% update egg distance
growEgg(Route, [Tag-Type | T]):-
    Type == egg,
    playerEggs(Tag, Pokemon, CurrentDistance),
    route(Route, _, _, RouteDistance, _),
    NewDistance is CurrentDistance - min(RouteDistence, CurrentDistance), 
    retract(playerEggs(Tag, Pokemon, _)),
    asserta(playerEggs(Tag, Pokemon, NewDistance)).

% check if any eggs are about to hatch
checkEgg([Tag-Type | T]):-
    Type == egg,
    playerEggs(Tag, Pokemon, Distance),
    Distance == 0,

    hatchEgg(Tag).

hatchEgg(Tag):-
    playerEggs(Tag, Pokemon, _),
    baseStats(Pokemon, Atk, HP),
    asserta(owned(Tag, Pokemon, 0, Atk, HP, 0, [])).

% owned(tag, pokemon, level, atk, hp, exp, moves)
owned(none, none, none, none, none, none, none).

% ==== BATTLE LOGIC ====
% enemy(pokemon, atk,   hp,     moves)
enemy(none, none, none, none).

% generate random encounter of type T
% 0 -> wild pokemon
% 1 -> trainer
encounter(Route, T):-
    T == 0,
    % get encounter difficulty
    route(Route, _, _, _, Difficulty),
    difficulty(Difficulty, L, U),
    random_between(L, U, Level),

    % set pokemon stats
    random(Pokemon),
    baseStats(Pokemon, BaseAtk, BaseHP),
    scaledAttack(BaseAtk, Level, Attack),
    scaledHP(BaseHP, Level, HP),
    encounterMoves(Pokemon, Level, Moves),
    retractall(enemy(_, _, _, _)),
    asserta(enemy(Pokemon, Atk, HP, Moves)).