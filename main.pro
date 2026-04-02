% load files
% dynamics
:- consult('engine/dynamics.pro').
% data
:- consult('data/cities.pro').
:- consult('data/evolutions.pro').
:- consult('data/moves.pro').
:- consult('data/pokemon.pro').
:- consult('data/trainers.pro').
:- consult('data/types.pro').
% engine
:- consult('engine/battle.pro').
:- consult('engine/moves.pro').
:- consult('engine/player_actions.pro').
:- consult('engine/stats.pro').

enemy(pokemon, hp, moves).
tamed(ID, pokemon, level, current_hp, experience, state, moves).