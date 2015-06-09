/*Konstantina Galouni (sdi1000034)*/

:- lib(fd).
:- [warehouses_data].

warehouses(N1, M1, YesNoLocs, CustServs, Cost):-
	/*Use only N1 warehouses and M1 customers from given data*/
	N1 > 0,
	M1 > 0,
	fixedcosts(FixedCosts),
	varcosts(VarCosts),
	warehouses(N1, M1, YesNoLocs, CustServs, Cost, FixedCosts, VarCosts).
warehouses(N1, 0, YesNoLocs, CustServs, Cost):-
	N1 > 0,
	fixedcosts(FixedCosts),
	varcosts(VarCosts),
	length(VarCosts, M1New),	/*M1 is 0, use all customers*/
	warehouses(N1, M1New, YesNoLocs, CustServs, Cost, FixedCosts, VarCosts).
warehouses(0, M1, YesNoLocs, CustServs, Cost):-
	M1 > 0,
	fixedcosts(FixedCosts),
	varcosts(VarCosts),
	length(FixedCosts, N1New),	/*N1 is 0, use all warehouses*/
	warehouses(N1New, M1, YesNoLocs, CustServs, Cost, FixedCosts, VarCosts).
warehouses(0, 0, YesNoLocs, CustServs, Cost):-
	/*Use all warehouses and customers from given data*/
	fixedcosts(FixedCosts),
	varcosts(VarCosts),
	length(FixedCosts, N1New),
	length(VarCosts, M1New),
	warehouses(N1New, M1New, YesNoLocs, CustServs, Cost, FixedCosts, VarCosts).
	
warehouses(N1, M1, YesNoLocs, CustServs, Cost, FixedCosts, VarCosts):-
	length(YesNoLocs, N1),		/*N1 warehouses*/
	length(CustServs, M1),		/*M1 customers*/
	YesNoLocs :: 0..1,			/*A warehouse is built (1) or not (0)*/
	CustServs :: 1..N1,			/*A customer is served by one of the N1 warehouses*/
	constrainDom(YesNoLocs, CustServs, 1),
	constrainFixed(YesNoLocs, FixedCosts, Fixed),
	constrainVar(CustServs, VarCosts, Var),
	constrainCost(Fixed, Var, Cost),
	append(YesNoLocs, CustServs, L),
	minimize(generate(L), Cost).

mycheck(_, [], _).
mycheck(Y, [X|CustServs], N):-
	X #= N #=> Y #= 1,			/*Customer X is served by warehouse Y, so Y is built*/
	mycheck(Y, CustServs, N).

constrainDom([], _, _).
constrainDom([Y|YesNoLocs], CustServs, N):-
	mycheck(Y, CustServs, N),	/*Y warehouse exists if there is one customer served by Y*/
	N1 is N+1,					/*Check next warehouse*/
	constrainDom(YesNoLocs, CustServs, N1).

/*Fixed cost is the sum of fixed costs of every built warehouse*/
constrainFixed([], _, 0).
constrainFixed([Y|YesNoLocs], [X|FixedCosts], Fixed):-
	Fixed #= Fixed1 + X*Y,
	constrainFixed(YesNoLocs, FixedCosts, Fixed1).

/*Var Cost is the sum of var costs of every customer,
 depending on the warehouse that serves them*/
constrainVar([], _, 0).
constrainVar([X|CustServs], [Y|VarCosts], Var):-
	element(X, Y, CurVar),
	Var #= Var1 + CurVar,
	constrainVar(CustServs, VarCosts, Var1).
	
constrainCost(Fixed, Var, Cost):-
	Cost #= Fixed + Var.		/*Final Cost is the sum of Fixed and Var cost*/

generate([]).
generate(L):-
	deletemin(X, L, R),			/*X has the smallest lower domain bound*/
	indomain(X),
	generate(R). 