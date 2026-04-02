/*
pokéball(type, cost).

level(level, experience).

wildPokemón(nombre, attack power, state, health, experience, level).
tamedPokemón(nombre, attack power, state, health, experience, level).

ataque(pokemón, name, base_damage).

huevo(pokemón, distance_to_hatch).

evolution(pokemón, evolution, required_level).
    > cinco tipos diferentes de pokémon y se definirán tres por cada uno de ellos
    > cada Pokémon tiene cuatro ataques que puede usar en sus peleas.
    > kilometros que debe caminarse para que eclosionen los huevos según el tipo-pokémon al que corresponda.
    > las diferentes evoluciones de cada pokémon y el nivel de experiencia necesario para que se lleve a cabo.
    > ataques que puede realizar cada pokémon, así como el puntaje que se reduce a su contrincante después de recibir dicho ataque.

city(name, next_city, distance)

trainer(name, [team], [pokéballs], money)

bill([[wilPokemon, entrenador]])

location(city, place_in_city).
*/

% cities

% level calculation
level(Level, CurrentExp, RequiredExp):-
    RequiredExp is 50 + (Level / 2 * (40 + ((Level - 1) * 20))).

% learns move at level ?
learns(_, Move, Level):-
    move(Move, Type, _, Level) ; move(Move, normal, _, Level).

% pokéballs
pokeball(normal, 50).
pokeball(superball, 100).

% eggs
% ===== NORMAL =====
/*egg(eeve, ).
egg(pidgey, ).
egg(jigglypuff, ).

% ===== FIRE =====
egg(charmander, ).
egg(vulpix, ).
egg(ponyta, ).

% ===== WATER =====
egg(psyduck, ).
egg(poliwag, ).
egg(squirtle, ).

% ===== GRASS =====
egg(bellsprout,).
egg(oddish, ).
egg(bulbasaur, ).

% ===== GHOST =====
egg(gastly, ).
egg(litwick, ).
egg(mimikyu, ).*/

% types
    % ===== NORMAL =====
    type(eeve, normal).
    type(pidgey, normal).
    type(pidgeotto, normal).
    type(pidgeot, normal).
    type(jigglypuff, normal).
    type(wigglytuff, normal).

    % ===== FIRE =====
    type(charmander, fire).
    type(charmeleon, fire).
    type(vulpix, fire).
    type(ninetales, fire).
    type(ponyta, fire).
    type(rapidash, fire).
    type(flareon, fire).

    % ===== WATER =====
    type(squirtle, water).
    type(wartortle, water).
    type(blastoise, water).
    type(poliwag, water).
    type(poliwhirl, water).
    type(poliwrath, water).
    type(psyduck, water).
    type(vaporeon, water).

    % ===== GRASS =====
    type(bellsprout, grass).
    type(weepinbell, grass).
    type(victreebel, grass).
    type(bulbasaur, grass).
    type(ivysaur, grass).
    type(venusaur, grass).
    type(oddish, grass).
    type(gloom, grass).
    type(vileplume, grass).
    type(leafeon, grass).

    % ===== GHOST =====
    type(gastly, ghost).
    type(haunter, ghost).
    type(gengar, ghost).
    type(litwick, ghost).
    type(lampent, ghost).
    type(chandelure, ghost).
    type(mimikyu, ghost).

% wild_pokemón(pokemón, base attack power, state, health, experience, level).
    % ===== NORMAL =====
    wild_pokemon(eevee, 4, normal, 20, 0, 0, []).
    wild_pokemon(pidgey, 5, normal, 22, 0, 0, []).
    wild_pokemon(jigglypuff, 4, normal, 25, 0, 0, []).

    % ===== FIRE =====
    wild_pokemon(charmander, 6, normal, 24, 0, 0, []).
    wild_pokemon(vulpix, 5, normal, 23, 0, 0, []).
    wild_pokemon(ponyta, 5, normal, 24, 0, 0, []).

    % ===== WATER =====
    wild_pokemon(psyduck, 3, normal, 20, 0, 0, []).
    wild_pokemon(poliwag, 5, normal, 23, 0, 0, []).
    wild_pokemon(squirtle, 6, normal, 24, 0, 0, []).

    % ===== GRASS =====
    wild_pokemon(bellsprout, 2, normal, 19, 0, 0, []).
    wild_pokemon(oddish, 3, normal, 20, 0, 0, []).
    wild_pokemon(bulbasaur, 6, normal, 24, 0, 0, []).

    % ===== GHOST =====
    wild_pokemon(gastly, 5, normal, 22, 0, 0, []).
    wild_pokemon(litwick, 4, normal, 19, 0, 0, []).
    wild_pokemon(mimikyu, 4, normal, 20, 0, 0, []).

% evolves_into(pokemón, evolution, required_level)
    % ===== NORMAL =====
    evolves_into(eevee, flareon, 17).
    evolves_into(eevee, vaporeon, 17).
    evolves_into(eevee, leafeon, 17).

    evolves_into(pidgey, pidgeotto, 17).
    evolves_into(pidgeotto, pidgeot, 24).

    evolves_into(jigglypuff, wigglytuff, 17).

    % ===== FIRE =====
    evolves_into(charmander, charmeleon, 17).
    evolves_into(charmeleon, charizard, 24).

    evolves_into(vulpix, ninetales, 17).

    evolves_into(ponyta, rapidash, 17).

    % ===== WATER =====
    evolves_into(squirtle, wartortle, 17).
    evolves_into(wartortle, blastoise, 24).

    evolves_into(poliwag, poliwhirl, 17).
    evolves_into(poliwhirl, poliwrath, 24).

    evolves_into(psyduck, golduck, 17).

    % ===== GRASS =====
    evolves_into(bellsprout, weepinbell, 17).
    evolves_into(weepinbell, victreebel, 24).

    evolves_into(bulbasaur, ivysaur, 17).
    evolves_into(ivysaur, venusaur, 24).

    evolves_into(oddish, gloom, 17).
    evolves_into(gloom, vileplume, 24).

    % ===== GHOST =====
    evolves_into(gastly, haunter, 17).
    evolves_into(haunter, gengar, 24).

    evolves_into(litwick, lampent, 17).
    evolves_into(lampent, chandelure, 24).

% move(attack power, level)
% ===== NORMAL =====
move(tackle, normal, 25, 1).
move(quick_attack, normal, 40, 8).
move(facade, normal, 70, 14).
move(swift, normal, 60, 16).
move(headbutt, normal, 70, 21).
move(body_slam, normal, 55, 24).
move(hyper_voice, normal, 90, 36).
move(take_down, normal, 90, 40).
move(hyperbeam, normal, 100, 58).

% ===== FIRE =====


% ===== WATER =====
% ===== GRASS =====
% ===== GHOST =====
move(lick, ghost, 30, 1).
move(shadow_sneak, 40, 12).
move(shadow_claw, 70, 16).
move(shadow_claw, 80, 40).
move(phantom_force, 80, 55).
