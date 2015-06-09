%Konstantina Galouni (sdi1000034)

member1(X, [X|Tail]).
member1(X, [Head|Tail]):-
	member1(X, Tail).

append1([], L, L).
append1([X|L1], L2, [X|L3]):-
	append1(L1, L2, L3).
	
sublist1(S,L):-
	append1(L1, L2, L),
	append1(S, L3, L2).	
sublist1(S,L):-
	append1([X|S1], [Y|S2], S),
	append1(L1, [X|S1], L),
	append1([Y|S2], L2, L).
	
checkRules([], Seats).
checkRules([1|Tail], Seats):-
	sublist1([johan, _, _, _, _, _, _, antti], Seats),
	checkRules(Tail, Seats).
checkRules([2|Tail], Seats):-
	sublist1([luis, _, _, _, _, _, _, _, _, johan], Seats),
	checkRules(Tail, Seats).
checkRules([3|Tail], Seats):-
	sublist1([eric, _, _, _, _, _, _, jeroen], Seats),
	checkRules(Tail, Seats).
checkRules([4|Tail], Seats):-
	sublist1([michel, _, _, _, _, _, jeroen], Seats),
	checkRules(Tail, Seats).
checkRules([5|Tail], Seats):-
	sublist1([harris, _, _, _, _, _, _, _, eric], Seats),
	checkRules(Tail, Seats).
checkRules([6|Tail], Seats):-
	sublist1([antti, _, _, _, _, _, _, _, wolfgang], Seats),
	checkRules(Tail, Seats).
checkRules([7|Tail], Seats):-
	sublist1([peter, _, _, _, _, _, _, wolfgang], Seats),
	checkRules(Tail, Seats).
	
seats(Seats):-
	append1([yanis],[_,_,_,_,_,_,_,_,_],Seats),
	sublist1([johan, _, _, _, _, _, _, antti], Seats),
	sublist1([luis, _, _, _, _, _, _, _, _, johan], Seats),
	sublist1([eric, _, _, _, _, _, _, jeroen], Seats),
	sublist1([michel, _, _, _, _, _, jeroen], Seats),
	sublist1([harris, _, _, _, _, _, _, _, eric], Seats),
	sublist1([antti, _, _, _, _, _, _, _, wolfgang], Seats),
	sublist1([peter, _, _, _, _, _, _, wolfgang], Seats).
	
seats(Rules, Seats):-
	append1([yanis],[_,_,_,_,_,_,_,_,_],Seats),
	checkRules(Rules, Seats),
	member1(antti, Seats),
	member1(eric, Seats),
	member1(harris, Seats),
	member1(jeroen, Seats),
	member1(johan, Seats),
	member1(luis, Seats),
	member1(michel, Seats),
	member1(peter, Seats),
	member1(wolfgang, Seats).
	
bonus1(Seats):-
	append1([yanis],[_,_,_,_,_,_,_,_,_],Seats),
	sublist1([eric, _, _, _, _, antti], Seats),
	sublist1([eric, michel], Seats),
	sublist1([eric, _, _, wolfgang], Seats),
	sublist1([jeroen, _, _, eric], Seats),
	sublist1([johan, luis], Seats),
	sublist1([peter, _, _, _, _, _, harris], Seats).
	
bonus2(Seats):-
	append1([yanis],[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],Seats),
	sublist1([yanis, _, pier], Seats),
	sublist1([yanis, _, _, _, rimantas], Seats),
	sublist1([yanis, _, _, _, _, _, edward], Seats),
	sublist1([yanis, _, _, _, _, _, _, eric], Seats),
	sublist1([yanis, _, _, _, _, _, _, _, _, peter], Seats),
	sublist1([yanis, _, _, _, _, _, _, _, _, _, _, luis], Seats),
	sublist1([yanis, _, _, _, _, _, _, _, _, _, _, _, _, hans], Seats),
	sublist1([yanis, _, _, _, _, _, _, _, _, _, _, _, _, _, _, harris], Seats),
	sublist1([yanis, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, antti], Seats),
	sublist1([michel, wolfgang], Seats),
	sublist1([pierre, _, _, maria], Seats),
	sublist1([maris, _, _, _, _, michael], Seats),
	sublist1([janis, _, _, _, _, _, _, dusan], Seats),
	sublist1([jeroen, _, johan], Seats).	