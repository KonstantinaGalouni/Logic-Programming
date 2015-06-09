/*Konstantina Galouni (sdi1000034)*/

:- lib(fd).
:- [diags].

decode(Lines, Columns, DiagsDown, DiagsUp):-
	length(Lines, LinesLength),
	length(Columns, ColumnsLength),
	length(Matrix, LinesLength),			/*create Matrix with LinesLength lines*/
	init(Matrix, ColumnsLength),			/*every line has ColumnsLength columns*/
	diags(Matrix, DiagsDown1, DiagsUp1),	/*find diags of Matrix*/
	constrain1(Matrix, Lines, 0),			/*each line has a specific number of . and * */
	constrain2(Matrix, Columns, 0),			/*each column has a specific number of . and * */
	constrain1(DiagsDown1, DiagsDown, 0),	/*each diagDown has a specific number of . and * */
	constrain1(DiagsUp1, DiagsUp, 0),		/*each diagUp has a specific number of . and * */
	generate(Matrix),						/*find solution*/
	my_print(Matrix).						/*print solution by matching 0 with . and 1 with * */
	
init([], _).	
init([Head|Tail], ColumnsLength):-
	length(Head, ColumnsLength),
	Head :: 0..1,							/*every value is 0 or 1 (. or * respectively)*/
	init(Tail, ColumnsLength).
	
constrain1([], [], _).
constrain1([[]|Rest], [Line|Lines], Sum):-
	Sum #= Line,!,
	constrain1(Rest, Lines, 0).
constrain1([[Head|Tail]|Rest], [Line|Lines], Sum):-
	constrain1([Tail|Rest], [Line|Lines], Sum+Head).
	
constrain2(_, [], _).
constrain2(Matrix, [Column|Columns], 0):-
	constrain(Matrix, Column, 0, NewMatrix),
	constrain2(NewMatrix, Columns, 0).
	
constrain([], Column, Sum, []):-
	Sum #= Column.
constrain([[Head|Tail]|Rest], Column, Sum, [Tail|Rest1]):-
	constrain(Rest, Column, Sum+Head, Rest1).
	
generate([]).
generate(Matrix) :-
   deleteffc(Value, Matrix, RestMatrix),	/*Value is the most constrained variable from Matrix*/
   indomain(Value),							/*Value is 0 or 1*/
   generate(RestMatrix).
   
my_print([]).
my_print([[]|Rest]):-
	nl,										/*end of a line, print a new line*/
	my_print(Rest).
my_print([[0|Tail]|Rest]):-
	write('. '),
	my_print([Tail|Rest]).
my_print([[1|Tail]|Rest]):-
	write('* '),
	my_print([Tail|Rest]).