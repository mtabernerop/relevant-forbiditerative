begin_version
3
end_version
begin_metric
0
end_metric
5
begin_variable
var0
-1
4
Atom handempty()
Atom holding(ball)
Atom holding(puzzle)
Atom holding(teddy)
end_variable
begin_variable
var1
-1
7
Atom last(five)
Atom last(four)
Atom last(one)
Atom last(six)
Atom last(three)
Atom last(two)
Atom last(zero)
end_variable
begin_variable
var2
-1
3
Atom at(ball, box1)
Atom at(ball, box2)
<none of those>
end_variable
begin_variable
var3
-1
3
Atom at(puzzle, box1)
Atom at(puzzle, box2)
<none of those>
end_variable
begin_variable
var4
-1
3
Atom at(teddy, box1)
Atom at(teddy, box2)
<none of those>
end_variable
3
begin_mutex_group
3
2 0
2 1
0 1
end_mutex_group
begin_mutex_group
3
3 0
3 1
0 2
end_mutex_group
begin_mutex_group
3
4 0
4 1
0 3
end_mutex_group
begin_state
0
6
0
0
0
end_state
begin_goal
3
2 1
3 1
4 1
end_goal
21
begin_operator
pick-up four five teddy box1
0
3
0 4 0 2
0 0 0 3
0 1 1 0
1
end_operator
begin_operator
pick-up one five teddy box1
0
3
0 4 0 2
0 0 0 3
0 1 2 0
1
end_operator
begin_operator
pick-up one three puzzle box1
0
3
0 3 0 2
0 0 0 2
0 1 2 4
1
end_operator
begin_operator
pick-up three five teddy box1
0
3
0 4 0 2
0 0 0 3
0 1 4 0
1
end_operator
begin_operator
pick-up two five teddy box1
0
3
0 4 0 2
0 0 0 3
0 1 5 0
1
end_operator
begin_operator
pick-up two three puzzle box1
0
3
0 3 0 2
0 0 0 2
0 1 5 4
1
end_operator
begin_operator
pick-up zero five teddy box1
0
3
0 4 0 2
0 0 0 3
0 1 6 0
1
end_operator
begin_operator
pick-up zero one ball box1
0
3
0 2 0 2
0 0 0 1
0 1 6 2
1
end_operator
begin_operator
pick-up zero three puzzle box1
0
3
0 3 0 2
0 0 0 2
0 1 6 4
1
end_operator
begin_operator
put-down five six teddy box2
0
3
0 4 -1 1
0 0 3 0
0 1 0 3
1
end_operator
begin_operator
put-down four six teddy box2
0
3
0 4 -1 1
0 0 3 0
0 1 1 3
1
end_operator
begin_operator
put-down one four puzzle box2
0
3
0 3 -1 1
0 0 2 0
0 1 2 1
1
end_operator
begin_operator
put-down one six teddy box2
0
3
0 4 -1 1
0 0 3 0
0 1 2 3
1
end_operator
begin_operator
put-down one two ball box2
0
3
0 2 -1 1
0 0 1 0
0 1 2 5
1
end_operator
begin_operator
put-down three four puzzle box2
0
3
0 3 -1 1
0 0 2 0
0 1 4 1
1
end_operator
begin_operator
put-down three six teddy box2
0
3
0 4 -1 1
0 0 3 0
0 1 4 3
1
end_operator
begin_operator
put-down two four puzzle box2
0
3
0 3 -1 1
0 0 2 0
0 1 5 1
1
end_operator
begin_operator
put-down two six teddy box2
0
3
0 4 -1 1
0 0 3 0
0 1 5 3
1
end_operator
begin_operator
put-down zero four puzzle box2
0
3
0 3 -1 1
0 0 2 0
0 1 6 1
1
end_operator
begin_operator
put-down zero six teddy box2
0
3
0 4 -1 1
0 0 3 0
0 1 6 3
1
end_operator
begin_operator
put-down zero two ball box2
0
3
0 2 -1 1
0 0 1 0
0 1 6 5
1
end_operator
0
