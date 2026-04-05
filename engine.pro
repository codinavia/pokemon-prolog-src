% ==== LOAD FILES ====
% dynamics
:- consult('engine/dynamics.pro').
% data
:- consult('data/map.pro').
:- consult('data/pokemon.pro').
:- consult('data/trainers.pro').

% ==== HELPERS ====
% take first N elements of a list
take(0, _, []).
take(_, [], []).
take(N, [H | T], [H | R]) :-
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

% mark as learned moves in a given list
learnMoves(_, [], []).

learnMoves(Learned, [M-locked | T], [M-learned | R]) :-
    member(M, Learned),
    learnMoves(Learned, T, R).

learnMoves(Learned, [M-locked | T], [M-forgotten | R]) :-
    \+ member(M, Learned),
    move(M, _, _, ML),
    findall(LL, (member(LM, Learned), move(LM, _, _, LL)), LLs),
    min_list(LLs, MinLL),
    ML =< MinLL,
    learnMoves(Learned, T, R).

learnMoves(Learned, [M-S | T], [M-S | R]) :-
    learnMoves(Learned, T, R).

% ==== POKEMON ====
level(Level, RequiredExp):- RequiredExp is 50 + (20 * Level).

% learns move at level ?
learnsAt(Type, Move, Level):- move(Move, Type, _, Level).
learnsAt(_, Move, Level):- move(Move, normal, _, Level).

% available moves for a pokemon given type
availableMoves(Type, Moves):- findall(M-locked, (move(M, Type, _, _) ; move(M, normal, _, _)), M), sort(M, Moves).

% mark the four most recent moves as learned given level and pokemon type
pokemonMoves(Pokemon, Level, Moves):-
    type(Pokemon, Type),
    availableMoves(Type, AllMoves),
    findall(MoveLevel-Move, (learnsAt(Type, Move, MoveLevel), MoveLevel =< Level), A),
    sort(0, @>=, A, S),
    take(4, S, T),
    pairs_values(T, M),
    learnMoves(M, AllMoves, Moves).

% get scaled stats
scaledAttack(BaseAtk, Level, Attack) :- Attack is BaseAtk + (Level * 2).
scaledHP(BaseHP, Level, MaxHP) :- MaxHP is BaseHP + (Level * 3).

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
checkEgg([], []).
checkEgg([Tag-Type | T], [Tag | R]):-
    Type == egg,
    playerEggs(Tag, Pokemon, Distance),
    Distance == 0,
    checkEgg(T, R).

hatchEgg(Tag):-
    playerEggs(Tag, Pokemon, _),
    baseStats(Pokemon, BaseAtk, BaseHP),
    random_between(2, 4, Level),
    pokemonMoves(Pokemon, Level, Moves),
    retract(playerEggs(Tag, _, _)),
    asserta(owned(Tag, Pokemon, Level, Atk, HP, 0, Moves)).

% owned(tag, pokemon, level, atk, hp, exp, moves)
owned(none, none, none, none, none, none, none).

% catch(pokemon)
catch(Pokemon):-
    enemy(Pokemon, Atk, CurrentHP, Moves)

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
    learnMoves(Pokemon, Level, Moves),
    retractall(enemy(_, _, _, _)),
    asserta(enemy(Pokemon, Atk, HP, Moves)).