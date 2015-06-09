/*Konstantina Galouni (sdi1000034)*/

:- lib(fd).

labs(N, Labs, AC):-
	length(Labs, N),
	Labs :: [-1, 1],					/*every value is -1 or 1*/
	constrain(Labs, AC, 1, N, Labs),
	minimize(generate(Labs), AC).

constrain(_, 0, N, N, _):-!.
constrain(Labs, AC, K, N, [_|Labs2]):-
	K1 is K+1,
	Limit is N-K,
	constrain1(C, Labs, 0, Limit, Labs2),
	Temp #= C*C,
	AC #= AC1+Temp,						/*outer sum, total autocorrelation: E*/
	constrain(Labs, AC1, K1, N, Labs2).

constrain1(0, _, Limit, Limit, _):-!.
constrain1(C, [S1|Labs], I, Limit, [S2|Labs2]):-
	I1 is I+1,
	Temp #= S1*S2,						/*S1 is Si, S2 is Si+k*/
	C #= C1+Temp,						/*inner sum, k-autocorrelation: c*/
	constrain1(C1, Labs, I1, Limit, Labs2).

generate([]).
generate(L) :-
	deletemin(X, L, R),					/*X has the smallest lower domain bound*/
	indomain(X),						/*X is -1 or 1*/
	generate(R). 