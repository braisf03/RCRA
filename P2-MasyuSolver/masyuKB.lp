
%Estos parametros ya estan definidos
%#const n=6.
%black(0;12;26).
%white(10;13;22;23;31;34).


num(0..(n*n)-1).


adyacentes(X,Y) :- num(X),num(Y), |X - Y| = 1, (X / n) = (Y / n).
adyacentes(X,Y) :- num(X),num(Y), |X - Y| = n.



{line(X,Y) : num(X), num(Y)} :- adyacentes(X,Y),X!=Y. %solo genera lineas adyacentes

:- line(X,Y), not line(Y,X). %Generar simetricos




%Un numero tiene que tener dos segmentos o ninguno

:- num(X), #count{Y : line(X,Y)} = 1.
:- num(X), #count{Y : line(X,Y)} = 3.
:- num(X), #count{Y : line(X,Y)} = 4.




path(X, Y) :- line(X, Y).
path(X, Z) :- line(X, Y), path(Y, Z).
:- line(_,X),line(Y,_), not path(X, Y). %Desde todas las lineas se tiene que poder llegar a todas las lineas


corner(X) :- line(Y,X),line(X,Z),Z!=Y, (Y / n) != (Z / n), (Y \ n) != (Z \ n). 


:- white(X), not line(X,_). %Tiene que pasar por las blancas
:- white(X),  corner(X). %No puede haber blancos en esquinas


:- white(X),line(X,Y),line(X,Z),Y!=Z,not corner(Y) ; not corner(Z). %Minimo una esquina adyacente


:- black(X),not line(X,_). %TIene que pasar por los negros
:- black(X), not corner(X). %Tiene que estar en la esquina el negro



:- black(X),line(X,Y),corner(Y).  %No puede haber esquinas adyacentes




seg(X,Y) :- line(X,Y), X < Y. %Fijar el orden para imprimir bien





#show seg/2.