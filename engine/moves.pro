:- consult('../data/moves.pro').
:- consult('../data/types.pro').

% available moves given level and pokemon type
encounter_moves(Pokemon, Level, Moves):-
    pokemon_type(Pokemon, Type),
    findall(MoveLevel-Move, 
        (learns(Type, Move, MoveLevel), MoveLevel =< Level), AllMoves),
    sort(0, @>=, AllMoves, Sorted),
    take(4, Sorted, Top4),
    pairs_values(Top4, Moves).

% take first N elements of a list
take(_, [], []).
take(N, [H | T], [H | R]):-
    N > 0,
    N1 is N - 1,
    take(N1, T, R).