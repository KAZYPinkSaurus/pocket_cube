go:-cube([y,b,w,r,b,y,g,r,o,w,b,y,w,g,r,o,g,r,o,w,b,y,g,o]).

/*展開図をリスト形式で表した問題を解く*/
cube(OriginalData):-
draw_View(OriginalData),
solve(OriginalData,SolvedOperation),nl,
write(ー操作ー),nl,
draw_Operation(SolvedOperation),
list_length(SolvedOperation,N),
write(最短経路は以上の),
NumSolve is N -2,
write(NumSolve),
write(手です),nl,nl,
write(ーーーーーーーーー操作説明ーーーーーーーーー),nl,
write(白),put(32),write(緑),put(32),write(橙),put(32),write(のブロックを),put(32),write(緑),put(32),write(を正面にして),nl,
write(左下),put(32),write(に配置して),put(32),write(固定して),put(32),write(操作してください),nl,nl,
write(upー正面右列を上側に９０度回転),nl,
write(downー正面右列を下側に９０度回転),nl,
write(up-upー正面右列を１８０度回転),nl,
write(rightー正面上段を右側に９０度回転),nl,
write(leftー正面上段を左側に９０度回転),nl,
write(right-rightー正面上段を１８０度回転),nl,
write(cwー奥面を正面側から見て時計回りに９０度回転),nl,
write(ccwー奥面を正面から見て半時計周りに９０度回転),nl,
write(cw-cwー奥面を１８０度回転),nl,
write(ーーーーーーーーーーーーーーーーーーーーーー),nl,!.

/*任意の開始地点、最終地点*/
cube2(OriginalData,EndData):-
draw_View(OriginalData),
solve2(OriginalData,SolvedOperation,EndData),nl,
write(ー操作ー),nl,
draw_Operation(SolvedOperation),
list_length(SolvedOperation,N),
write(最短経路は以上の),
NumSolve is N -2,
write(NumSolve),
write(手です),nl,nl,
write(ーーーーーーーーー操作説明ーーーーーーーーー),nl,
write(白),put(32),write(緑),put(32),write(橙),put(32),write(のブロックを),put(32),write(緑),put(32),write(を正面にして),nl,
write(左下),put(32),write(に配置して),put(32),write(固定して),put(32),write(操作してください),nl,nl,
write(upー正面右列を上側に９０度回転),nl,
write(downー正面右列を下側に９０度回転),nl,
write(up-upー正面右列を１８０度回転),nl,
write(rightー正面上段を右側に９０度回転),nl,
write(leftー正面上段を左側に９０度回転),nl,
write(right-rightー正面上段を１８０度回転),nl,
write(cwー奥面を正面側から見て時計回りに９０度回転),nl,
write(ccwー奥面を正面から見て半時計周りに９０度回転),nl,
write(cw-cwー奥面を１８０度回転),nl,
write(ーーーーーーーーーーーーーーーーーーーーーー),nl,!.


/*問題を入力すると操作リストが返る*/
solve(OriginData,Operation):-
converse_Data(OriginData,NumData),
((search([NumData],[[3,3,3,3,0,0,0,0,5,5,5,5,1,1,1,1,2,2,2,2,4,4,4,4]],[[0]],[[0]],Operation,1,1,0))).

    /*任意の開始地点、最終地点*/
solve2(OriginData,Operation,EndData):-
converse_Data(OriginData,NumData),
converse_Data(EndData,NumData2),
((search([NumData],[NumData2],[[0]],[[0]],Operation,1,1,0))).

/*展開図を描く*/
draw_View([D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24]):-
write(ー展開図ー),nl,
write(g-green),put(32),
write(b-blue),put(32),put(32),put(32),
write(w-white),put(32),nl,
write(r-red),put(32),put(32),put(32),
write(y-yellow),put(32),
write(o-orange),nl,nl,
put(32),put(32),write(D1),write(D2),nl,
put(32),put(32),write(D3),write(D4),nl,
write(D17),write(D18),write(D5),write(D6),write(D21),write(D22),nl,
write(D19),write(D20),write(D7),write(D8),write(D23),write(D24),nl,
put(32),put(32),write(D9),write(D10),nl,
put(32),put(32),write(D11),write(D12),nl,
put(32),put(32),write(D13),write(D14),nl,
put(32),put(32),write(D15),write(D16),nl.


/*操作リストを人間が読める形に出力する*/
draw_Operation([]).

draw_Operation([Head|RestOperation]):-
((Head is 0);
((Head is 1),write(up),nl);
((Head is 2),write(down),nl);
((Head is 3),write(up-up),nl);
((Head is 4),write(right),nl);
((Head is 5),write(left),nl);
((Head is 6),write(right-right),nl);
((Head is 7),write(cw),nl);
((Head is 8),write(ccw),nl);
((Head is 9),write(cw-cw),nl)),
draw_Operation(RestOperation).

/*幅優先探索でスタート側ゴール側の両端から解を探す*/
/*Forwardでマッチした時*/
search(_,_,_,_,_,_,0,_):-!.

 /*Backでマッチした時*/
search(_,_,_,_,_,_,_,1):-!. 

/*11手の時用*/ 
search(_,_,_,_,_,7,_,_):-!.

search(ForwardLeaves,BackLeaves,OperationSet1,OperationSet2,Operation,Depth,_,_):-!,
Depth < 7,
NewDepth is Depth + 1,
next(ForwardLeaves,NewForwardLeaves,OperationSet1,NewOperationSet1,1),
((match(NewForwardLeaves,BackLeaves,IndexF,IndexB),
create_Operation(IndexF,IndexB,NewOperationSet1,OperationSet2,Operation),!,NewBackDoFlag is 0);
NewBackDoFlag is 1),
next(BackLeaves,NewBackLeaves,OperationSet2,NewOperationSet2,NewBackDoFlag),
((NewBackDoFlag == 1,match(NewForwardLeaves,NewBackLeaves,IndexF,IndexB),
create_Operation(IndexF,IndexB,NewOperationSet1,NewOperationSet2,Operation),!,NewEndFlag is 1);
NewEndFlag is 0),
search(NewForwardLeaves,NewBackLeaves,NewOperationSet1,NewOperationSet2,Operation,NewDepth,NewBackDoFlag,NewEndFlag),!.

/*文字書かれた図面を数字に変換*/
converse_Data([],[]):-!.
converse_Data([HeadOrigin|RestOrigin],[HeadNum|RestNum]):-
converse(HeadOrigin,HeadNum),converse_Data(RestOrigin,RestNum),!.

converse(Char,Num):-
(Char == g,Num is 0);
(Char == b,Num is 1);
(Char == w,Num is 2);
(Char == r,Num is 3);
(Char == y,Num is 4);
(Char == o,Num is 5),!.

/*現在のすべての葉ノードを展開。*/
next(_,_,_,_,0):-!.

next([],[],[],[],1):-!.

next([Leaf|Leaves],NewLeaves,[Operation|OperationSet],NewOperationSet,1):-
(next(Leaves,NextLeaves1,OperationSet,NextOperationSet1,1),
open_Leaf(Leaf,NextLeaves2,Operation,NextOperationSet2,9),
conc(NextOperationSet2,NextOperationSet1,NewOperationSet),
conc(NextLeaves2,NextLeaves1,NewLeaves));
next(Leaves,NewLeaves,OperationSet,NewOperationSet,1),!.

/*葉ノードを展開。新い葉ノードの数だけ操作リストが作られる。履歴にある展開ノードは切る。履歴も更新する。 ok*/
open_Leaf(_,_,_,_,0):-!.

open_Leaf(Leaf,NextLeaves,[PreOperation|RestOperation],NextOperationSet,N):-
N > 0,NewN is N - 1,
((open_Leaf(Leaf,NextLeaves2,[PreOperation|RestOperation],NextOperationSet1,NewN),
PreOperation \== N,
not(cut_Operation(N,PreOperation)),
operate(N,Leaf,NextLeaf,[PreOperation|RestOperation],NextOperation),
conc([NextOperation],NextOperationSet1,NextOperationSet),
conc([NextLeaf],NextLeaves2,NextLeaves));
open_Leaf(Leaf,NextLeaves,[PreOperation|RestOperation],NextOperationSet,NewN)),!.
    
/*ある番号の操作を行う ok*/
operate(N,Leaf,NextLeaf,Operation,NewOperation):-
(N is 1, r(Leaf,NextLeaf,Operation,NewOperation));
(N is 2, r_(Leaf,NextLeaf,Operation,NewOperation));
(N is 3, r2(Leaf,NextLeaf,Operation,NewOperation));
(N is 4, t(Leaf,NextLeaf,Operation,NewOperation));
(N is 5, t_(Leaf,NextLeaf,Operation,NewOperation));
(N is 6, t2(Leaf,NextLeaf,Operation,NewOperation));
(N is 7, b(Leaf,NextLeaf,Operation,NewOperation));
(N is 8, b_(Leaf,NextLeaf,Operation,NewOperation));
(N is 9, b2(Leaf,NextLeaf,Operation,NewOperation)),!.

/*先端ノード同士が一致しているかどうか ok*/
match(ForwardLeaves,BackLeaves,IndexF,IndexB):-
scan(ForwardLeaves,BackLeaves,1,IndexF,IndexB),!.

scan([],_,_,_,_):-!,false.

scan([HeadLeaf|RestForwardLeaves],BackLeaves,NowIndex,IndexF,IndexB):-
(scan2(HeadLeaf,BackLeaves,1,IndexB),IndexF = NowIndex);
(NewIndex is NowIndex + 1,scan(RestForwardLeaves,BackLeaves,NewIndex,IndexF,IndexB)),!.

scan2(_,[],_,_,_):-!,false.

scan2(Leaf,[HeadLeaf|Leaves],NowIndex,Index):-
(Leaf == HeadLeaf,Index is NowIndex);
(NewIndex is NowIndex + 1,scan2(Leaf,Leaves,NewIndex,Index)),!.

/*最終的な操作を返す ok*/
create_Operation(IndexF,IndexB,OperationSet1,OperationSet2,Operation):-
nth(IndexF,LeafF,OperationSet1),
reverse(LeafF,NewLeafF),
nth(IndexB,LeafB,OperationSet2),
reverse_Operation(LeafB,NewLeafB),conc(NewLeafF,NewLeafB,Operation),!.

/*ゴールから辿った操作をゴールへ戻す手順に変換 ok*/
reverse_Operation([],[]):-!.

reverse_Operation([0],[0]):-!.

reverse_Operation([Head|Rest],[NewHead|Rest2]):-
(((Head is 1),(NewHead is 2));
((Head is 2),(NewHead is 1));
((Head is 3),(NewHead is 3));
((Head is 4),(NewHead is 5));
((Head is 5),(NewHead is 4));
((Head is 6),(NewHead is 6));
((Head is 7),(NewHead is 8));
((Head is 8),(NewHead is 7));
((Head is 9),(NewHead is 9))),
reverse_Operation(Rest,Rest2).

/*剪定のための禁止展開 ok*/
cut_Operation(H,N):-
((H is 1),(N is 2));
((H is 1),(N is 3));
((H is 2),(N is 1));
((H is 2),(N is 3));
((H is 3),(N is 2));
((H is 3),(N is 1));
((H is 4),(N is 5));
((H is 4),(N is 6));
((H is 5),(N is 4));
((H is 5),(N is 6));
((H is 6),(N is 4));
((H is 6),(N is 5));
((H is 7),(N is 8));
((H is 7),(N is 9));
((H is 8),(N is 7));
((H is 8),(N is 9));
((H is 9),(N is 7));
((H is 9),(N is 8)).

/*％％％％キューブ操作全9種％％％％*/

/*表面右列を上に９０度　下に９０度　１８０度回転　：（3種）ok*/
r([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[A1,B2,A3,B4,B1,C2,B3,C4,C1,D2,C3,D4,D1,A2,D3,A4,E1,E2,E3,E4,F3,F1,F4,F2],Operation,[1|Operation]).
r_([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[A1,D2,A3,D4,B1,A2,B3,A4,C1,B2,C3,B4,D1,C2,D3,C4,E1,E2,E3,E4,F2,F4,F1,F3],Operation,[2|Operation]).
r2([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[A1,C2,A3,C4,B1,D2,B3,D4,C1,A2,C3,A4,D1,B2,D3,B4,E1,E2,E3,E4,F4,F3,F2,F1],Operation,[3|Operation]).

/*表面上行を右に９０度　左に９０度　１８０度回転：（3種）ok*/
t([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[A2,A4,A1,A3,E1,E2,B3,B4,C1,C2,C3,C4,D1,D2,F2,F1,D4,D3,E3,E4,B1,B2,F3,F4],Operation,[4|Operation]).
t_([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[A3,A1,A4,A2,F1,F2,B3,B4,C1,C2,C3,C4,D1,D2,E2,E1,B1,B2,E3,E4,D4,D3,F3,F4],Operation,[5|Operation]).
t2([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[A4,A3,A2,A1,D4,D3,B3,B4,C1,C2,C3,C4,D1,D2,B2,B1,F1,F2,E3,E4,E1,E2,F3,F4],Operation,[6|Operation]).

/*奥面を右回りに９０度　左回りに９０度　１８０度回転：（3種) ok*/
b([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[E3,E1,A3,A4,B1,B2,B3,B4,C1,C2,F4,F2,D2,D4,D1,D3,C3,E2,C4,E4,F1,A1,F3,A2],Operation,[7|Operation]).
b_([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[F2,F4,A3,A4,B1,B2,B3,B4,C1,C2,E1,E3,D3,D1,D4,D2,A2,E2,A1,E4,F1,C4,F3,C3],Operation,[8|Operation]).
b2([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4],[C4,C3,A3,A4,B1,B2,B3,B4,C1,C2,A2,A1,D4,D3,D2,D1,F4,E2,F2,E4,F1,E3,F3,E1],Operation,[9|Operation]).

/*％％％％基本的な操作述語％％％％％*/

/*リストの結合*/
conc([],L,L).

conc([A|L],R,[A|LR]):-conc(L,R,LR).

/*リストの指定の位置の要素を取り出す*/
nth(1,A,[A|_]).

nth(N,A,[_|L]):-M is N-1,nth(M,A,L).

/*リストの反転*/
reverse(L,R):-rev(L,[],R).

rev([],L,L).

rev([A|L],R,ANS):- rev(L,[A|R],ANS).

/*リストの長さを求める*/
list_length(L,N):-
list_length(L,0,N).

list_length([],N,N).

list_length([_|L],N,M):- 
NN is N+1,
list_length(L,NN,M).

