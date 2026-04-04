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