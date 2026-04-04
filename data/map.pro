% route(route, difficulty,       cityA,            cityB,              distance)
route(101,     beggining,        littleroot,       oldale,             1000).
route(102,     beggining,        oldale,           petalburg,          1500).
route(103,     early,            oldale,           slateport,          3500).
route(104,     early,            oldale,           mauville,           3600).
route(105,     beggining,        petalburg,        rustboro,           2300).
route(106,     beggining,        petalburg,        dewford,            3200).
route(107,     early,            slateport,        dewford,            4100).
route(108,     middle,           slateport,        pacifidlog,         6100).
route(109,     early,            slateport,        mauville,           2300).
route(110,     early,            dewford,          rustboro,           5500).
route(111,     middle,           mauville,         lavaridge,          2100).
route(112,     early,            mauville,         verdanturf,         1300).
route(113,     middle,           mauville,         fallarbor,          5200).
route(114,     middle,           mauville,         fortree,            4700).
route(115,     middle,           fortree,          lilycove,           5100).
route(116,     early,            verdanturf,       rustboro,           2300).
route(127,     middle,           lavaridge,        fallarbor,          3100).
route(128,     middle,           fallarbor,        rustboro,           4000).
route(129,     late,             pacifidlog,       evergrande,         5800).
route(120,     late,             pacifidlog,       sootopolis,         5500).
route(122,     late,             pacifidlog,       mossdeep,           8100).
route(123,     late,             evergrande,       sootopolis,         3200).
route(124,     late,             evergrande,       mossdeep,           5100).
route(125,     late,             sootopolis,       mossdeep,           3400).

% map
map(littleroot,     'Littleroot Town').
map(oldale,         'Oldale Town').
map(petalburg,      'Petalburg City').
map(rustboro,       'Rustboro City').
map(dewford,        'Dewford Town').
map(slateport,      'Slateport City').
map(mauville,       'Mauville City').
map(verdanturf,     'Verdanturf Town').
map(fallarbor,      'Fallarbor Town').
map(lavaridge,      'Lavaridge Town').
map(fortree,        'Fortree City').
map(lilycove,       'Lilycove City').
map(mossdeep,       'Mossdeep City').
map(sootopolis,     'Sootopolis City').
map(pacifidlog,     'Pacifidlog Town').
map(evergrande,     'Ever Grande City').

% gymnasium(city,       leader,     numberOfFights,   difficulty,   badge)
gymnasium(rustboro,     roxxane,    1,                early,        stone).
gymnasium(mauville,     brawly,     2,                early,        dynamo)
gymnasium(lavaridge,    flannery,   3,                middle,       heat).
gymnasium(fortree,      winona,     4,                middle,       feather).
gymnasium(mossdeep,     brawly,     5,                late,         knuckle).
gymnasium(sootopolis,   wallace,    6,                late,         rain).

% difficuly(difficulty, lower, upper)
difficulty(beggining,   2,     8)
difficulty(early,       6,     14).
difficulty(middle,      15,    23).
difficulty(late,        19,    26).