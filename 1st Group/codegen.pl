/*Konstantina Galouni (sdi1000034)*/

move(N, State, NextState):-
	Length is N-1,
	length(L, Length),
	append(L, [A,_|Tail], State),
	append(L, [A,A|Tail], NextState).
move(N, State, NextState):-
	Length is N-1,
	length([B|Tail], Length),
	append([B|Tail], [A], State),
	append([A|Tail], [A], NextState).	/*This case is for move(N) instruction*/
	
swap(X, X, State, State).
swap(X, Y, State, NextState):-
	X < Y,
	Length1 is X-1,
	Length2 is Y-X-1,
	length(L1, Length1),
	length(L2, Length2),
	append(L1, [A|L2], Temp1),			/*A is the element at position X*/
	append(Temp1, [B|Tail], State),		/*B is the element at position Y*/
	append(L1, [B|L2], Temp2),
	append(Temp2, [A|Tail], NextState).

/*Return recursively all numbers between N1, N2 including them*/
between(N1,N2,N1):-
	N1 =< N2.
between(N1,N2,N):-
	N1 < N2,
	NewN1 is N1+1,
	between(NewN1, N2, N).

/*Continue to next state executing one instruction (move or swap)*/	
nextMove(State, NextState, GoalLength, move(Current), Last):-
	between(1, GoalLength, Current),
	Last \== move(Current),
	move(Current, State, NextState).
nextMove(State, NextState, GoalLength, swap(CurrentX, CurrentY), Last):-
	between(1, GoalLength, CurrentX),
	between(1, GoalLength, CurrentY),
	CurrentY > CurrentX,
	Last \== swap(CurrentX, CurrentY),
	swap(CurrentX, CurrentY, State, NextState).
			
codegen(State, Goal, Path):-	/*Path is the list which contains the minimum necessary instructions*/
	length(Goal, GoalLength),	/*GoalLength is the lenth of Goal list*/
    length(Path, _),			/*Path's length increases gradually*/
    ids(State, Goal, Path, GoalLength, null).

ids(Goal, Goal, [], _, _).
ids(Goal1, Goal, [], GoalLength, Last):-
	append(L1,[*|L3],Goal),				/*Register in Goal list may contain indefferent value*/
	append(L1,[_|L4],Goal1),	
	ids(L4, L3, [], GoalLength, Last).	/*There may be more than one registers as above*/
ids(State, Goal, [Instruction|Path], GoalLength, Last) :-
	nextMove(State, NextState, GoalLength, Instruction, Last),	/*continue to next state*/
    ids(NextState, Goal, Path, GoalLength, Instruction).		/*NextState is a goal state, otherwise continue*/