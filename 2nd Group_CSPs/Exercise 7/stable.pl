/*	Konstantina Galouni (sdi1000034)
Input Size: 150 men, 150 women -> CPU Time: 126.85s
Input Size: 200 men, 200 women -> CPU Time: 422.60s
*/

:- lib(fd).
:- [stable_data].

stable(M):-
	men(Men),
	women(Women),
	length(Men, Length),
	length(Match, Length),
	Match :: Women,
	alldifferent(Match),
	constrain(Women, Men, Match),
	labeling(Match),
	result(M, Men, Match).
	
result([], [], []).
result([Man-Woman|M], [Man|Men], [Woman|Match]):-
	/* Result, M, has couples */
	result(M, Men, Match).
	
/* For every Woman call constrain1 and constrain2 */
constrain([], _, _).
constrain([Woman|Women], Men, Match):-
	prefers(Woman, WomanPrefers),
	/*	Constrain1 matches every man with a woman */
	constrain1(Men, Match, Husband, Woman),
	/* Woman likes N-1 Men more than Husband*/
	element(N, WomanPrefers, Husband),
	/*	If Man likes Woman more than his wife, Woman likes more her Husband
		if Woman likes Man more than Husband, Man likes more his wife */
	constrain2(Men, Match, Husband, Woman, WomanPrefers, N),
	constrain(Women, Men, Match).
	
constrain1([], [], _, _).	
constrain1([Man|Men], [Wife|Match], Husband, Woman):-
	/* Husband is the husband of Woman */
	Wife #= Woman #<=> Husband #= Man,
	constrain1(Men, Match, Husband, Woman).
	
constrain2([], [], _, _, _, _).
constrain2([Man|Men], [Wife|Match], Husband, Woman, WomanPrefers, N3):-
	prefers(Man, ManPrefers),
	element(N1, ManPrefers, Wife),
	element(N2, ManPrefers, Woman),
	element(N4, WomanPrefers, Man),
	/* If Man likes Woman more than his wife, Woman likes more her Husband */
	N2 #< N1 #=> N3 #< N4,
	/* If Woman likes Man more than Husband, Man likes more his wife */
	N4 #< N3 #=> N1 #< N2,
	constrain2(Men, Match, Husband, Woman, WomanPrefers, N3).