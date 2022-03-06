begin_version
3
end_version
begin_metric
0
end_metric
12
begin_variable
var0
-1
2
Atom clear(w)
<none of those>
end_variable
begin_variable
var1
-1
3
Atom on(d, a)
Atom on(d, w)
<none of those>
end_variable
begin_variable
var2
-1
2
Atom ontable(p)
NegatedAtom ontable(p)
end_variable
begin_variable
var3
-1
2
Atom clear(d)
NegatedAtom clear(d)
end_variable
begin_variable
var4
-1
2
Atom clear(p)
NegatedAtom clear(p)
end_variable
begin_variable
var5
-1
2
Atom clear(a)
NegatedAtom clear(a)
end_variable
begin_variable
var6
-1
11
Atom last(eight)
Atom last(five)
Atom last(four)
Atom last(nine)
Atom last(one)
Atom last(seven)
Atom last(six)
Atom last(ten)
Atom last(three)
Atom last(two)
Atom last(zero)
end_variable
begin_variable
var7
-1
5
Atom handempty()
Atom holding(a)
Atom holding(d)
Atom holding(p)
<none of those>
end_variable
begin_variable
var8
-1
2
Atom clear(e)
Atom on(p, e)
end_variable
begin_variable
var9
-1
3
Atom on(a, c)
Atom on(a, p)
<none of those>
end_variable
begin_variable
var10
-1
4
Atom holding(r)
Atom on(r, a)
Atom on(r, d)
Atom on(r, p)
end_variable
begin_variable
var11
-1
2
Atom clear(r)
NegatedAtom clear(r)
end_variable
9
begin_mutex_group
4
5 0
7 1
10 1
1 0
end_mutex_group
begin_mutex_group
3
3 0
7 2
10 2
end_mutex_group
begin_mutex_group
4
4 0
7 3
10 3
9 1
end_mutex_group
begin_mutex_group
2
11 0
10 0
end_mutex_group
begin_mutex_group
2
0 0
1 1
end_mutex_group
begin_mutex_group
5
7 0
7 1
7 2
7 3
10 0
end_mutex_group
begin_mutex_group
3
7 1
9 0
9 1
end_mutex_group
begin_mutex_group
3
7 2
1 0
1 1
end_mutex_group
begin_mutex_group
3
8 1
7 3
2 0
end_mutex_group
begin_state
0
0
0
0
1
1
10
0
0
0
3
0
end_state
begin_goal
4
8 1
9 1
10 1
11 0
end_goal
55
begin_operator
pick-up four five p
0
4
0 4 0 1
0 7 0 3
0 6 2 1
0 2 0 1
1
end_operator
begin_operator
pick-up one five p
0
4
0 4 0 1
0 7 0 3
0 6 4 1
0 2 0 1
1
end_operator
begin_operator
pick-up three five p
0
4
0 4 0 1
0 7 0 3
0 6 8 1
0 2 0 1
1
end_operator
begin_operator
pick-up two five p
0
4
0 4 0 1
0 7 0 3
0 6 9 1
0 2 0 1
1
end_operator
begin_operator
pick-up zero five p
0
4
0 4 0 1
0 7 0 3
0 6 10 1
0 2 0 1
1
end_operator
begin_operator
stack eight ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 0 7
1
end_operator
begin_operator
stack five eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 1 0
0 9 -1 1
1
end_operator
begin_operator
stack five six p e
0
4
0 8 0 1
0 4 -1 0
0 7 3 0
0 6 1 6
1
end_operator
begin_operator
stack five ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 1 7
1
end_operator
begin_operator
stack four eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 2 0
0 9 -1 1
1
end_operator
begin_operator
stack four six p e
0
4
0 8 0 1
0 4 -1 0
0 7 3 0
0 6 2 6
1
end_operator
begin_operator
stack four ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 2 7
1
end_operator
begin_operator
stack nine ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 3 7
1
end_operator
begin_operator
stack one eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 4 0
0 9 -1 1
1
end_operator
begin_operator
stack one four r d
0
5
0 3 0 1
0 11 -1 0
0 7 -1 0
0 10 0 2
0 6 4 2
1
end_operator
begin_operator
stack one six p e
0
4
0 8 0 1
0 4 -1 0
0 7 3 0
0 6 4 6
1
end_operator
begin_operator
stack one ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 4 7
1
end_operator
begin_operator
stack one two d w
0
5
0 3 -1 0
0 0 0 1
0 7 2 0
0 6 4 9
0 1 -1 1
1
end_operator
begin_operator
stack seven eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 5 0
0 9 -1 1
1
end_operator
begin_operator
stack seven ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 5 7
1
end_operator
begin_operator
stack six eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 6 0
0 9 -1 1
1
end_operator
begin_operator
stack six ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 6 7
1
end_operator
begin_operator
stack three eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 8 0
0 9 -1 1
1
end_operator
begin_operator
stack three four r d
0
5
0 3 0 1
0 11 -1 0
0 7 -1 0
0 10 0 2
0 6 8 2
1
end_operator
begin_operator
stack three six p e
0
4
0 8 0 1
0 4 -1 0
0 7 3 0
0 6 8 6
1
end_operator
begin_operator
stack three ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 8 7
1
end_operator
begin_operator
stack two eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 9 0
0 9 -1 1
1
end_operator
begin_operator
stack two four r d
0
5
0 3 0 1
0 11 -1 0
0 7 -1 0
0 10 0 2
0 6 9 2
1
end_operator
begin_operator
stack two six p e
0
4
0 8 0 1
0 4 -1 0
0 7 3 0
0 6 9 6
1
end_operator
begin_operator
stack two ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 9 7
1
end_operator
begin_operator
stack zero eight a p
0
5
0 5 -1 0
0 4 0 1
0 7 1 0
0 6 10 0
0 9 -1 1
1
end_operator
begin_operator
stack zero four r d
0
5
0 3 0 1
0 11 -1 0
0 7 -1 0
0 10 0 2
0 6 10 2
1
end_operator
begin_operator
stack zero six p e
0
4
0 8 0 1
0 4 -1 0
0 7 3 0
0 6 10 6
1
end_operator
begin_operator
stack zero ten r a
0
5
0 5 0 1
0 11 -1 0
0 7 -1 0
0 10 0 1
0 6 10 7
1
end_operator
begin_operator
stack zero two d w
0
5
0 3 -1 0
0 0 0 1
0 7 2 0
0 6 10 9
0 1 -1 1
1
end_operator
begin_operator
unstack eight nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 0 3
1
end_operator
begin_operator
unstack five nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 1 3
1
end_operator
begin_operator
unstack five seven a c
0
4
0 5 0 1
0 7 0 1
0 6 1 5
0 9 0 2
1
end_operator
begin_operator
unstack four nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 2 3
1
end_operator
begin_operator
unstack four seven a c
0
4
0 5 0 1
0 7 0 1
0 6 2 5
0 9 0 2
1
end_operator
begin_operator
unstack one nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 4 3
1
end_operator
begin_operator
unstack one seven a c
0
4
0 5 0 1
0 7 0 1
0 6 4 5
0 9 0 2
1
end_operator
begin_operator
unstack one three r p
0
5
0 4 -1 0
0 11 0 1
0 7 0 4
0 10 3 0
0 6 4 8
1
end_operator
begin_operator
unstack seven nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 5 3
1
end_operator
begin_operator
unstack six nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 6 3
1
end_operator
begin_operator
unstack six seven a c
0
4
0 5 0 1
0 7 0 1
0 6 6 5
0 9 0 2
1
end_operator
begin_operator
unstack three nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 8 3
1
end_operator
begin_operator
unstack three seven a c
0
4
0 5 0 1
0 7 0 1
0 6 8 5
0 9 0 2
1
end_operator
begin_operator
unstack two nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 9 3
1
end_operator
begin_operator
unstack two seven a c
0
4
0 5 0 1
0 7 0 1
0 6 9 5
0 9 0 2
1
end_operator
begin_operator
unstack two three r p
0
5
0 4 -1 0
0 11 0 1
0 7 0 4
0 10 3 0
0 6 9 8
1
end_operator
begin_operator
unstack zero nine r d
0
5
0 3 -1 0
0 11 0 1
0 7 0 4
0 10 2 0
0 6 10 3
1
end_operator
begin_operator
unstack zero one d a
0
5
0 5 -1 0
0 3 0 1
0 7 0 2
0 6 10 4
0 1 0 2
1
end_operator
begin_operator
unstack zero seven a c
0
4
0 5 0 1
0 7 0 1
0 6 10 5
0 9 0 2
1
end_operator
begin_operator
unstack zero three r p
0
5
0 4 -1 0
0 11 0 1
0 7 0 4
0 10 3 0
0 6 10 8
1
end_operator
0
