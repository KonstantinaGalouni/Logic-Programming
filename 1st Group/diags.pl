%Y: ari8mos grammhs
%X: ari8mos sthlhs
%C: a8roisma pou 8elw na exw
%C1: a8roisma pou ontws exw
%elegxw an auta ta 2 einai isa. An nai to A mpainei sth lista B kai eksetazw to epomeno (?). An oxi prepei na allaksei to C kai to B

%oso auksanetai to ena toso prepei na meiwnetai to allo


add(X, L, [X|L]).


check(Matrix, [[A|DownTail]|Tail], B,SolutionTail, Y, X, Sum, Sum1):-	
	Sum > Sum1,
	X1 is (X + 1),
	diagsDown(Matrix, [DownTail|Tail], B,SolutionTail, Y, X1, Sum).		
check(Matrix, [[A|DownTail]|Tail], B,SolutionTail, Y, X, Sum, Sum1):-	
	Sum < Sum1,
	Y1 is (Y - 1),
	diagsDown(Matrix, Tail, B,SolutionTail, Y1, 1, Sum).
check(Matrix, [[A|DownTail]|Tail], B,[B|SolutionTail], Y, X, Sum, Sum):-
	add(A, B, B1),
	Y1 is (Y - 1),
	diagsDown(Matrix, Tail, B1,[B1|SolutionTail], Y1, 1, Sum).	
	
	
diagsDown(Matrix, [], B,[B|SolutionTail], Y, X, Sum):-
	length(Matrix, TotalLength),
	Y < TotalLength,
	Sum1 is (Sum + 1),
	append(C, SolutionTail, SolutionTail1),
	diagsDown(Matrix, Matrix, C,[B|[C|SolutionTail1]], TotalLength, 1, Sum1).
diagsDown(Matrix, [[]|Matrix1], B,[B|SolutionTail], Y, X, Sum):-
	length(Matrix, TotalLength),
	Y < TotalLength,
	Sum1 is (Sum + 1),
	append(C, SolutionTail, SolutionTail1),
	diagsDown(Matrix, Matrix, C,[B|[C|SolutionTail1]], TotalLength, 1, Sum1).
	
diagsDown(Matrix, [[]|Matrix1], B,DiagsDown, Y, X, Sum):-
	length(Matrix, TotalLength),
	Y =:= TotalLength.
	
diagsDown(Matrix, [A|Matrix1], B,[B|SolutionTail], 0, X, Sum):-
	length(Matrix, TotalLength),
	Sum1 is (Sum + 1),
	append(C, SolutionTail, SolutionTail1),
	diagsDown(Matrix, Matrix, C,[B|[C|SolutionTail1]], TotalLength, 1, Sum1).

diagsDown(Matrix, [A|Matrix1], B,DiagsDown, Y, X, Sum):-
	Y > 0,
	Sum1 is (Y+X),
	check(Matrix, [A|Matrix1], B,DiagsDown, Y, X, Sum, Sum1).	
	

diags(Matrix, DiagsDown):-
	length(Matrix, TotalLength),
	append(B, DiagsTail, DiagsDown),
	diagsDown(Matrix, Matrix, B,[B|DiagsTail], TotalLength, 1, 2).