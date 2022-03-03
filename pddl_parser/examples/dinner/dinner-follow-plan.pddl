(define (domain dinner)
(:requirements :strips)
(:types order)
(:predicates
	(clean)
	(dinner)
	(quiet)
	(present)
	(garbage)
	
	(last ?o - order)
	(before ?o1 ?o2 - order)

	(plan-action-cook ?o - order)
	(plan-action-wrap ?o - order)
	(plan-action-carry ?o - order)
	(plan-action-dolly ?o - order)
)
(:action cook
	:parameters (?olast - order ?ocurrent - order)
	:precondition (and			
			 (clean)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-cook ?ocurrent))
	:effect (and			
			 (dinner)
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action wrap
	:parameters (?olast - order ?ocurrent - order)
	:precondition (and			
			 (quiet)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-wrap ?ocurrent))
	:effect (and			
			 (present)
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action carry
	:parameters (?olast - order ?ocurrent - order)
	:precondition (and			
			 (garbage)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-carry ?ocurrent))
	:effect (and			
			 (not (garbage))
			 (not (clean))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action dolly
	:parameters (?olast - order ?ocurrent - order)
	:precondition (and			
			 (garbage)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-dolly ?ocurrent))
	:effect (and			
			 (not (garbage))
			 (not (quiet))
			 (not (last ?olast))
			 (last ?ocurrent))
)

)