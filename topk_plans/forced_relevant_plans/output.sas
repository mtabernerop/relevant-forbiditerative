begin_version
3
end_version
begin_metric
0
end_metric
11
begin_variable
var0
-1
2
Atom clear(d)
NegatedAtom clear(d)
end_variable
begin_variable
var1
-1
2
Atom ontable(w)
NegatedAtom ontable(w)
end_variable
begin_variable
var2
-1
2
Atom clear(o)
Atom on(e, o)
end_variable
begin_variable
var3
-1
2
Atom ontable(e)
NegatedAtom ontable(e)
end_variable
begin_variable
var4
-1
2
Atom clear(e)
NegatedAtom clear(e)
end_variable
begin_variable
var5
-1
5
Atom handempty()
Atom holding(a)
Atom holding(d)
Atom holding(e)
Atom holding(w)
end_variable
begin_variable
var6
-1
9
Atom last(eight)
Atom last(five)
Atom last(four)
Atom last(one)
Atom last(seven)
Atom last(six)
Atom last(three)
Atom last(two)
Atom last(zero)
end_variable
begin_variable
var7
-1
4
Atom clear(a)
Atom on(d, a)
Atom on(w, a)
<none of those>
end_variable
begin_variable
var8
-1
2
Atom clear(w)
NegatedAtom clear(w)
end_variable
begin_variable
var9
-1
3
Atom on(a, c)
Atom on(a, d)
<none of those>
end_variable
begin_variable
var10
-1
2
Atom ontable(d)
NegatedAtom ontable(d)
end_variable
8
begin_mutex_group
4
7 0
7 1
7 2
5 1
end_mutex_group
begin_mutex_group
3
0 0
5 2
9 1
end_mutex_group
begin_mutex_group
2
4 0
5 3
end_mutex_group
begin_mutex_group
2
8 0
5 4
end_mutex_group
begin_mutex_group
3
5 1
9 0
9 1
end_mutex_group
begin_mutex_group
3
7 1
5 2
10 0
end_mutex_group
begin_mutex_group
3
2 1
5 3
3 0
end_mutex_group
begin_mutex_group
3
7 2
5 4
1 0
end_mutex_group
begin_state
0
0
0
0
0
0
8
1
0
0
1
end_state
begin_goal
4
7 2
8 0
9 1
10 0
end_goal
36
begin_operator
pick-up five seven e
0
4
0 4 0 1
0 5 0 3
0 6 1 4
0 3 0 1
1
end_operator
begin_operator
pick-up four five w
0
4
0 8 0 1
0 5 0 4
0 6 2 1
0 1 0 1
1
end_operator
begin_operator
pick-up four seven e
0
4
0 4 0 1
0 5 0 3
0 6 2 4
0 3 0 1
1
end_operator
begin_operator
pick-up one five w
0
4
0 8 0 1
0 5 0 4
0 6 3 1
0 1 0 1
1
end_operator
begin_operator
pick-up one seven e
0
4
0 4 0 1
0 5 0 3
0 6 3 4
0 3 0 1
1
end_operator
begin_operator
pick-up six seven e
0
4
0 4 0 1
0 5 0 3
0 6 5 4
0 3 0 1
1
end_operator
begin_operator
pick-up three five w
0
4
0 8 0 1
0 5 0 4
0 6 6 1
0 1 0 1
1
end_operator
begin_operator
pick-up three seven e
0
4
0 4 0 1
0 5 0 3
0 6 6 4
0 3 0 1
1
end_operator
begin_operator
pick-up two five w
0
4
0 8 0 1
0 5 0 4
0 6 7 1
0 1 0 1
1
end_operator
begin_operator
pick-up two seven e
0
4
0 4 0 1
0 5 0 3
0 6 7 4
0 3 0 1
1
end_operator
begin_operator
pick-up zero five w
0
4
0 8 0 1
0 5 0 4
0 6 8 1
0 1 0 1
1
end_operator
begin_operator
pick-up zero seven e
0
4
0 4 0 1
0 5 0 3
0 6 8 4
0 3 0 1
1
end_operator
begin_operator
put-down one two d
0
4
0 0 -1 0
0 5 2 0
0 6 3 7
0 10 -1 0
1
end_operator
begin_operator
put-down zero two d
0
4
0 0 -1 0
0 5 2 0
0 6 8 7
0 10 -1 0
1
end_operator
begin_operator
stack five eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 1 0
1
end_operator
begin_operator
stack five six w a
0
4
0 7 0 2
0 8 -1 0
0 5 4 0
0 6 1 5
1
end_operator
begin_operator
stack four eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 2 0
1
end_operator
begin_operator
stack four six w a
0
4
0 7 0 2
0 8 -1 0
0 5 4 0
0 6 2 5
1
end_operator
begin_operator
stack one eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 3 0
1
end_operator
begin_operator
stack one four a d
0
5
0 7 -1 0
0 0 0 1
0 5 1 0
0 6 3 2
0 9 -1 1
1
end_operator
begin_operator
stack one six w a
0
4
0 7 0 2
0 8 -1 0
0 5 4 0
0 6 3 5
1
end_operator
begin_operator
stack seven eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 4 0
1
end_operator
begin_operator
stack six eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 5 0
1
end_operator
begin_operator
stack three eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 6 0
1
end_operator
begin_operator
stack three four a d
0
5
0 7 -1 0
0 0 0 1
0 5 1 0
0 6 6 2
0 9 -1 1
1
end_operator
begin_operator
stack three six w a
0
4
0 7 0 2
0 8 -1 0
0 5 4 0
0 6 6 5
1
end_operator
begin_operator
stack two eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 7 0
1
end_operator
begin_operator
stack two four a d
0
5
0 7 -1 0
0 0 0 1
0 5 1 0
0 6 7 2
0 9 -1 1
1
end_operator
begin_operator
stack two six w a
0
4
0 7 0 2
0 8 -1 0
0 5 4 0
0 6 7 5
1
end_operator
begin_operator
stack zero eight e o
0
4
0 4 -1 0
0 2 0 1
0 5 3 0
0 6 8 0
1
end_operator
begin_operator
stack zero four a d
0
5
0 7 -1 0
0 0 0 1
0 5 1 0
0 6 8 2
0 9 -1 1
1
end_operator
begin_operator
stack zero six w a
0
4
0 7 0 2
0 8 -1 0
0 5 4 0
0 6 8 5
1
end_operator
begin_operator
unstack one three a c
0
4
0 7 0 3
0 5 0 1
0 6 3 6
0 9 0 2
1
end_operator
begin_operator
unstack two three a c
0
4
0 7 0 3
0 5 0 1
0 6 7 6
0 9 0 2
1
end_operator
begin_operator
unstack zero one d a
0
4
0 7 1 0
0 0 0 1
0 5 0 2
0 6 8 3
1
end_operator
begin_operator
unstack zero three a c
0
4
0 7 0 3
0 5 0 1
0 6 8 6
0 9 0 2
1
end_operator
0
