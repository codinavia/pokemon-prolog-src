:- dynamic nextTag/1.
:- dynamic owned/9.

:- retractall(nextTag(_)), asserta(nextTag(1)).
:- retractall(owned(_, _, _, _, _, _, _, _, _)), asserta(owned(none, none, none, none, none, none, none, none, none)).