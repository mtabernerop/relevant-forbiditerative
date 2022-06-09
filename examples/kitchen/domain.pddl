(define (domain kitchen)
	(:requirements :strips :typing :action-costs)
	(:types objects useable)
	(:constants
		water_jug keetle cloth tea_bag bowl milk
		cereal creamer cup sugar coffee bread cheese plate
		butter knife peanut_butter spoon
		pill_box juice popcorn dressing salad_tosser 
		lunch_bag - object
		microwave phone toaster plants - useable )
	(:predicates
		(taken ?o - object)
		(used ?o - useable)
		(water_boiled)
		(made_tea)
		(made_cereals)
		(made_coffee)
		(made_cheese_sandwich)
		(made_toast)
		(made_buttered_toast)
		(made_peanut_butter_sandwich)
		(lunch_packed)
		(made_breakfast)
		(made_salad)
		(made_dinner)
		(taken_medicine)
		(watching_movie)
		(phone_call_tended)
		(counter_wiped)
		(plants_tended)
		(drank_juice)
		(leaving_for_work)
		(going_to_bed)
		(dummy)
	)
	(:functions
		(total-cost) - number
	)
	(:action TAKE
		:parameters (?obj - object )
		:precondition (and (dummy) )
		:effect ( and
				(taken ?obj)
				(increase (total-cost) 1)
			)
	)
	(:action USE
		:parameters (?obj - useable )
		:precondition (and (dummy) )
		:effect (and
				(used ?obj)
				(increase (total-cost) 1)
			)
	)
	(:action ACTIVITY-Boil-Water
		:parameters ()
		:precondition 	(and
					(taken water_jug)
					(taken keetle)
					(taken cloth)
				)
		:effect		(and
					(water_boiled)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Tea1
		:parameters ()
		:precondition	(and
					(taken tea_bag)
					(taken cup)
					(taken sugar)
					(water_boiled)
				)
		:effect		(and
					(made_tea)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Tea2
		:parameters ()
		:precondition	(and
					(taken tea_bag)
					(taken cup)
					(taken sugar)
					(taken milk)
					(water_boiled)
				)
		:effect		(and
					(made_tea)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Tea3
		:parameters ()
		:precondition	(and
					(taken tea_bag)
					(taken cup)
					(water_boiled)
				)
		:effect		(and
					(made_tea)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Cereals
		:parameters ()
		:precondition	(and
					(taken bowl)
					(taken cereal)
					(taken milk)
				)
		:effect		(and
					(made_cereals)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Coffee1
		:parameters ()
		:precondition	(and
					(taken cup)
					(taken coffee)
					(taken creamer)
					(taken sugar)
					(water_boiled)
				)
		:effect		(and
					(made_coffee)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Coffee2
		:parameters ()
		:precondition	(and
					(taken cup)
					(taken coffee)
					(taken milk)
					(taken sugar)
					(water_boiled)
				)
		:effect		(and
					(made_coffee)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Cheese-Sandwich
		:parameters ()
		:precondition	(and
					(taken bread)
					(taken cheese)
					(taken plate)
				)
		:effect		(and
					(made_cheese_sandwich)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Toast
		:parameters ()
		:precondition	(and
					(taken bread)
					(used toaster)
				)
		:effect		(and
					(made_toast)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Buttered-Toast
		:parameters ()
		:precondition	(and
					(made_toast)
					(taken butter)
					(taken knife)
				)
		:effect		(and
					(made_buttered_toast)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Peanut-Butter-Sandwich
		:parameters ()
		:precondition	(and
					(taken bread)
					(taken peanut_butter)
					(taken knife)
					(taken plate)
				)
		:effect		(and
					(made_peanut_butter_sandwich)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Pack-Lunch1
		:parameters ()
		:precondition	(and
					(taken lunch_bag)
					(made_cheese_sandwich)
				)
		:effect		(and
					(lunch_packed)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Pack-Lunch2
		:parameters ()
		:precondition	(and
					(taken lunch_bag)
					(made_peanut_butter_sandwich)
				)
		:effect		(and
					(lunch_packed)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Breakfast1
		:parameters ()
		:precondition	(and
					(made_tea)
					(taken spoon)
					(made_cereals)
					(made_buttered_toast)
				)
		:effect		(and
					(made_breakfast)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Breakfast2
		:parameters ()
		:precondition	(and
					(made_coffee)
					(taken spoon)
					(made_cereals)
					(made_buttered_toast)
				)
		:effect		(and
					(made_breakfast)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Salad1
		:parameters ()
		:precondition	(and
					(taken bowl)
					(taken plate)
					(taken dressing)
					(taken salad_tosser) 
				)
		:effect		(and
					(made_salad)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Salad2
		:parameters ()
		:precondition	(and
					(taken bowl)
					(taken plate)
					(taken salad_tosser) 
				)
		:effect		(and
					(made_salad)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Dinner1
		:parameters ()
		:precondition	(and
					(made_salad)
				)
		:effect		(and
					(made_dinner)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Dinner2
		:parameters ()
		:precondition	(and
					(made_cheese_sandwich)
				)
		:effect		(and
					(made_dinner)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Make-Dinner3
		:parameters ()
		:precondition	(and
					(made_salad)
					(made_cheese_sandwich)
				)
		:effect		(and
					(made_dinner)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Take-Medicine
		:parameters ()
		:precondition	(and
					(taken pill_box)
				)
		:effect		(and
					(taken_medicine)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Watch-Movie
		:parameters ()
		:precondition	(and
					(taken popcorn)
					(used microwave)
				)
		:effect		(and
					(watching_movie)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Wipe-Counter
		:parameters ()
		:precondition	(and
					(taken cloth)
				)
		:effect		(and
					(counter_wiped)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Tend-Plants
		:parameters ()
		:precondition	(and
					(taken water_jug)
					(used plants)
				)
		:effect		(and
					(plants_tended)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Drink-Juice
		:parameters ()
		:precondition	(and
					(taken juice)
					(taken cup)
				)
		:effect		(and
					(drank_juice)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Leave-For-Work
		:parameters ()
		:precondition	(and
					(made_breakfast)
					(lunch_packed)
					(plants_tended)
				)
		:effect		(and
					(leaving_for_work)
					(increase (total-cost) 1)
				)
	)
	(:action ACTIVITY-Go-To-Bed
		:parameters ()
		:precondition	(and
					(made_dinner)
					(taken_medicine)
				)
		:effect		(and
					(going_to_bed)
					(increase (total-cost) 1)
				)
	)
)
