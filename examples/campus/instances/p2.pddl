(define (problem bui-campus_generic_hyp-1_full_73)
(:domain campus)
(:objects
)
(:init
(= (total-cost) 0)
(at davis_theater)
)
(:goal
(and
(breakfast) (lecture-1-taken) (group-meeting-1) (lecture-2-taken) (coffee)
)
)
(:metric minimize (total-cost))
)
