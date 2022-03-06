begin_version
3
end_version
begin_metric
0
end_metric
9
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
Atom clear(e)
<none of those>
end_variable
begin_variable
var2
-1
2
Atom clear(a)
NegatedAtom clear(a)
end_variable
begin_variable
var3
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
var4
-1
2
Atom handempty()
NegatedAtom handempty()
end_variable
begin_variable
var5
-1
3
Atom holding(d)
Atom on(d, a)
Atom ontable(d)
end_variable
begin_variable
var6
-1
3
Atom holding(a)
Atom on(a, c)
Atom on(a, d)
end_variable
begin_variable
var7
-1
4
Atom holding(w)
Atom on(w, a)
Atom on(w, e)
Atom ontable(w)
end_variable
begin_variable
var8
-1
2
Atom clear(w)
NegatedAtom clear(w)
end_variable
5
begin_mutex_group
4
2 0
6 0
5 1
7 1
end_mutex_group
begin_mutex_group
3
0 0
6 2
5 0
end_mutex_group
begin_mutex_group
2
1 0
7 2
end_mutex_group
begin_mutex_group
2
8 0
7 0
end_mutex_group
begin_mutex_group
4
4 0
6 0
5 0
7 0
end_mutex_group
begin_state
0
0
1
8
0
1
1
3
0
end_state
begin_goal
4
5 2
6 2
7 1
8 0
end_goal
36
begin_operator
pick-up zero one w
0
4
0 8 0 1
0 4 0 1
0 7 3 0
0 3 8 3
1
end_operator
begin_operator
put-down one four d
0
4
0 0 -1 0
0 4 -1 0
0 5 0 2
0 3 3 2
1
end_operator
begin_operator
put-down three four d
0
4
0 0 -1 0
0 4 -1 0
0 5 0 2
0 3 6 2
1
end_operator
begin_operator
put-down two four d
0
4
0 0 -1 0
0 4 -1 0
0 5 0 2
0 3 7 2
1
end_operator
begin_operator
put-down zero four d
0
4
0 0 -1 0
0 4 -1 0
0 5 0 2
0 3 8 2
1
end_operator
begin_operator
stack five eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 1 0
1
end_operator
begin_operator
stack five six a d
0
5
0 2 -1 0
0 0 0 1
0 4 -1 0
0 6 0 2
0 3 1 5
1
end_operator
begin_operator
stack four eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 2 0
1
end_operator
begin_operator
stack four six a d
0
5
0 2 -1 0
0 0 0 1
0 4 -1 0
0 6 0 2
0 3 2 5
1
end_operator
begin_operator
stack one eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 3 0
1
end_operator
begin_operator
stack one six a d
0
5
0 2 -1 0
0 0 0 1
0 4 -1 0
0 6 0 2
0 3 3 5
1
end_operator
begin_operator
stack one two w e
0
5
0 1 0 1
0 8 -1 0
0 4 -1 0
0 7 0 2
0 3 3 7
1
end_operator
begin_operator
stack seven eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 4 0
1
end_operator
begin_operator
stack six eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 5 0
1
end_operator
begin_operator
stack three eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 6 0
1
end_operator
begin_operator
stack three six a d
0
5
0 2 -1 0
0 0 0 1
0 4 -1 0
0 6 0 2
0 3 6 5
1
end_operator
begin_operator
stack two eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 7 0
1
end_operator
begin_operator
stack two six a d
0
5
0 2 -1 0
0 0 0 1
0 4 -1 0
0 6 0 2
0 3 7 5
1
end_operator
begin_operator
stack zero eight w a
0
5
0 2 0 1
0 8 -1 0
0 4 -1 0
0 7 0 1
0 3 8 0
1
end_operator
begin_operator
stack zero six a d
0
5
0 2 -1 0
0 0 0 1
0 4 -1 0
0 6 0 2
0 3 8 5
1
end_operator
begin_operator
stack zero two w e
0
5
0 1 0 1
0 8 -1 0
0 4 -1 0
0 7 0 2
0 3 8 7
1
end_operator
begin_operator
unstack five seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 1 4
1
end_operator
begin_operator
unstack four five a c
0
4
0 2 0 1
0 4 0 1
0 6 1 0
0 3 2 1
1
end_operator
begin_operator
unstack four seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 2 4
1
end_operator
begin_operator
unstack one five a c
0
4
0 2 0 1
0 4 0 1
0 6 1 0
0 3 3 1
1
end_operator
begin_operator
unstack one seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 3 4
1
end_operator
begin_operator
unstack one three d a
0
5
0 2 -1 0
0 0 0 1
0 4 0 1
0 5 1 0
0 3 3 6
1
end_operator
begin_operator
unstack six seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 5 4
1
end_operator
begin_operator
unstack three five a c
0
4
0 2 0 1
0 4 0 1
0 6 1 0
0 3 6 1
1
end_operator
begin_operator
unstack three seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 6 4
1
end_operator
begin_operator
unstack two five a c
0
4
0 2 0 1
0 4 0 1
0 6 1 0
0 3 7 1
1
end_operator
begin_operator
unstack two seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 7 4
1
end_operator
begin_operator
unstack two three d a
0
5
0 2 -1 0
0 0 0 1
0 4 0 1
0 5 1 0
0 3 7 6
1
end_operator
begin_operator
unstack zero five a c
0
4
0 2 0 1
0 4 0 1
0 6 1 0
0 3 8 1
1
end_operator
begin_operator
unstack zero seven w e
0
5
0 1 -1 0
0 8 0 1
0 4 0 1
0 7 2 0
0 3 8 4
1
end_operator
begin_operator
unstack zero three d a
0
5
0 2 -1 0
0 0 0 1
0 4 0 1
0 5 1 0
0 3 8 6
1
end_operator
0
