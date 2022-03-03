(define (problem pb1)
(:domain dinner)
(:objects
	zero one two three - order)
(:init
	(quiet)
	(garbage)
	(clean)
	
	;; numbers
	(before zero one)
	(before zero two)
	(before zero three)
	(before one two)
	(before one three)
	(before two three)
	(last zero)
	
	;; found plan
	(plan-action-cook one)
	(plan-action-wrap two)
	(plan-action-dolly three)
)
(:goal
	(and
		(present)
		(dinner)
		(not (garbage))
	)
)
)