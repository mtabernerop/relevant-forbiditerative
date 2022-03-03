(define (domain tsp)
(:requirements :strips :negative-preconditions :typing)
(:types order)
(:predicates
	(at ?pos - object)
	(connected ?start - object ?finish - object)
	(visited ?finish - object)
	
	(last ?o - order)
	(before ?o1 ?o2 - order)

	(plan-action-move ?o - order ?start - position ?finish - position)
)
(:action move
	:parameters (?olast - order ?ocurrent - order ?start - position ?finish - position)
	:precondition (and			
			 (at ?start)
			 (connected ?start ?finish)			
			 (not (visited ?finish))
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move ?ocurrent ?start ?finish))
	:effect (and			
			 (visited ?finish)
			 (at ?finish)			
			 (not (at ?start))
			 (not (last ?olast))
			 (last ?ocurrent))
)

)