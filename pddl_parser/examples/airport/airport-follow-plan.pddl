(define (domain airport_fixed_structure)
(:requirements :typing)
(:types
	airplane segment direction airplanetype order - object
)
(:predicates
	(has-type ?a - airplane ?t - airplanetype)
	(at-segment ?a - airplane ?s - segment)
	(facing ?a - airplane ?d - direction)
	(occupied ?s - segment)
	(not_occupied ?s - segment)
	(blocked ?s - segment ?a - airplane)
	(not_blocked ?s - segment ?a - airplane)
	(is-start-runway ?s - segment ?d - direction)
	(airborne ?a - airplane ?s - segment)
	(is-moving ?a - airplane)
	(is-pushing ?a - airplane)
	(is-parked ?a - airplane ?s - segment)
	
	(last ?o - order)
	(before ?o1 ?o2 - order)

	(plan-action-move_seg_pp_0_60_seg_ppdoor_0_40_north_north_medium ?o - order ?a - airplane)
	(plan-action-move_seg_ppdoor_0_40_seg_tww1_0_200_north_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_tww1_0_200_seg_twe1_0_200_north_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_twe1_0_200_seg_twe2_0_50_south_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_twe2_0_50_seg_twe3_0_50_south_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_twe3_0_50_seg_twe4_0_50_south_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_twe4_0_50_seg_rwe_0_50_south_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_rwe_0_50_seg_rw_0_400_south_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_rw_0_400_seg_rww_0_50_south_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_rww_0_50_seg_tww4_0_50_south_north_medium ?o - order ?a - airplane)
	(plan-action-move_seg_tww4_0_50_seg_tww3_0_50_north_north_medium ?o - order ?a - airplane)
	(plan-action-move_seg_tww3_0_50_seg_tww2_0_50_north_north_medium ?o - order ?a - airplane)
	(plan-action-move_seg_tww2_0_50_seg_tww1_0_200_north_north_medium ?o - order ?a - airplane)
	(plan-action-move_seg_tww1_0_200_seg_ppdoor_0_40_north_south_medium ?o - order ?a - airplane)
	(plan-action-move_seg_ppdoor_0_40_seg_pp_0_60_south_south_medium ?o - order ?a - airplane)
	(plan-action-takeoff_seg_rww_0_50_north ?o - order ?a - airplane)
	(plan-action-takeoff_seg_rwe_0_50_south ?o - order ?a - airplane)
	(plan-action-park_seg_pp_0_60_north ?o - order ?a - airplane)
	(plan-action-park_seg_pp_0_60_south ?o - order ?a - airplane)
	(plan-action-startup_seg_pp_0_60_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_pp_0_60_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_ppdoor_0_40_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_ppdoor_0_40_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww1_0_200_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww1_0_200_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe1_0_200_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe1_0_200_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww2_0_50_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww2_0_50_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww3_0_50_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww3_0_50_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww4_0_50_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_tww4_0_50_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe4_0_50_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe4_0_50_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe3_0_50_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe3_0_50_south_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe2_0_50_north_medium ?o - order ?a - airplane)
	(plan-action-startup_seg_twe2_0_50_south_medium ?o - order ?a - airplane)
)
(:action move_seg_pp_0_60_seg_ppdoor_0_40_north_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_ppdoor_0_40)
			 (has-type ?a medium)
			 (not_blocked seg_ppdoor_0_40 airplane_cfbeg)
			 (facing ?a north)
			 (is-moving ?a)
			 (at-segment ?a seg_pp_0_60)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_pp_0_60_seg_ppdoor_0_40_north_north_medium ?ocurrent ?a))
	:effect (and			
			 (occupied seg_ppdoor_0_40)
			 (blocked seg_ppdoor_0_40 ?a)
			 (at-segment ?a seg_ppdoor_0_40)
			 (not_occupied seg_pp_0_60)			
			 (not (not_occupied seg_ppdoor_0_40))
			 (not (at-segment ?a seg_pp_0_60))
			 (not (not_blocked seg_ppdoor_0_40 ?a))
			 (not (occupied seg_pp_0_60))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_ppdoor_0_40_seg_tww1_0_200_north_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (not_occupied seg_twe1_0_200)
			 (at-segment ?a seg_ppdoor_0_40)
			 (not_occupied seg_tww1_0_200)
			 (facing ?a north)
			 (is-moving ?a)
			 (not_blocked seg_tww1_0_200 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_ppdoor_0_40_seg_tww1_0_200_north_south_medium ?ocurrent ?a))
	:effect (and			
			 (not_occupied seg_ppdoor_0_40)
			 (blocked seg_twe1_0_200 ?a)
			 (blocked seg_tww1_0_200 ?a)
			 (not_blocked seg_pp_0_60 ?a)
			 (facing ?a south)
			 (occupied seg_tww1_0_200)
			 (at-segment ?a seg_tww1_0_200)			
			 (not (occupied seg_ppdoor_0_40))
			 (not (at-segment ?a seg_ppdoor_0_40))
			 (not (not_blocked seg_twe1_0_200 ?a))
			 (not (not_blocked seg_tww1_0_200 ?a))
			 (not (not_occupied seg_tww1_0_200))
			 (not (facing ?a north))
			 (not (blocked seg_pp_0_60 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_tww1_0_200_seg_twe1_0_200_north_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_ppdoor_0_40)
			 (has-type ?a medium)
			 (not_occupied seg_twe1_0_200)
			 (at-segment ?a seg_tww1_0_200)
			 (facing ?a north)
			 (is-moving ?a)
			 (not_blocked seg_twe1_0_200 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_tww1_0_200_seg_twe1_0_200_north_south_medium ?ocurrent ?a))
	:effect (and			
			 (occupied seg_twe1_0_200)
			 (blocked seg_twe1_0_200 ?a)
			 (facing ?a south)
			 (not_occupied seg_tww1_0_200)
			 (at-segment ?a seg_twe1_0_200)
			 (not_blocked seg_tww2_0_50 ?a)
			 (blocked seg_ppdoor_0_40 ?a)			
			 (not (not_occupied seg_twe1_0_200))
			 (not (blocked seg_tww2_0_50 ?a))
			 (not (not_blocked seg_twe1_0_200 ?a))
			 (not (occupied seg_tww1_0_200))
			 (not (facing ?a north))
			 (not (at-segment ?a seg_tww1_0_200))
			 (not (not_blocked seg_ppdoor_0_40 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_twe1_0_200_seg_twe2_0_50_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (facing ?a south)
			 (not_occupied seg_twe2_0_50)
			 (at-segment ?a seg_twe1_0_200)
			 (is-moving ?a)
			 (not_blocked seg_twe2_0_50 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_twe1_0_200_seg_twe2_0_50_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (not_occupied seg_twe1_0_200)
			 (blocked seg_twe2_0_50 ?a)
			 (not_blocked seg_tww1_0_200 ?a)
			 (occupied seg_twe2_0_50)
			 (at-segment ?a seg_twe2_0_50)
			 (not_blocked seg_ppdoor_0_40 ?a)			
			 (not (occupied seg_twe1_0_200))
			 (not (not_blocked seg_twe2_0_50 ?a))
			 (not (blocked seg_tww1_0_200 ?a))
			 (not (at-segment ?a seg_twe1_0_200))
			 (not (not_occupied seg_twe2_0_50))
			 (not (blocked seg_ppdoor_0_40 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_twe2_0_50_seg_twe3_0_50_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (facing ?a south)
			 (at-segment ?a seg_twe2_0_50)
			 (not_occupied seg_twe3_0_50)
			 (not_blocked seg_twe3_0_50 airplane_cfbeg)
			 (is-moving ?a)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_twe2_0_50_seg_twe3_0_50_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe3_0_50 ?a)
			 (not_blocked seg_twe1_0_200 ?a)
			 (not_occupied seg_twe2_0_50)
			 (occupied seg_twe3_0_50)
			 (at-segment ?a seg_twe3_0_50)			
			 (not (blocked seg_twe1_0_200 ?a))
			 (not (not_blocked seg_twe3_0_50 ?a))
			 (not (occupied seg_twe2_0_50))
			 (not (at-segment ?a seg_twe2_0_50))
			 (not (not_occupied seg_twe3_0_50))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_twe3_0_50_seg_twe4_0_50_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (not_blocked seg_twe4_0_50 airplane_cfbeg)
			 (not_occupied seg_twe4_0_50)
			 (facing ?a south)
			 (is-moving ?a)
			 (at-segment ?a seg_twe3_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_twe3_0_50_seg_twe4_0_50_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (not_blocked seg_twe2_0_50 ?a)
			 (occupied seg_twe4_0_50)
			 (not_occupied seg_twe3_0_50)
			 (at-segment ?a seg_twe4_0_50)
			 (blocked seg_twe4_0_50 ?a)			
			 (not (blocked seg_twe2_0_50 ?a))
			 (not (not_occupied seg_twe4_0_50))
			 (not (not_blocked seg_twe4_0_50 ?a))
			 (not (occupied seg_twe3_0_50))
			 (not (at-segment ?a seg_twe3_0_50))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_twe4_0_50_seg_rwe_0_50_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (facing ?a south)
			 (not_occupied seg_rwe_0_50)
			 (at-segment ?a seg_twe4_0_50)
			 (is-moving ?a)
			 (not_blocked seg_rwe_0_50 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_twe4_0_50_seg_rwe_0_50_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (not_blocked seg_twe3_0_50 ?a)
			 (not_occupied seg_twe4_0_50)
			 (blocked seg_rwe_0_50 ?a)
			 (occupied seg_rwe_0_50)
			 (at-segment ?a seg_rwe_0_50)			
			 (not (blocked seg_twe3_0_50 ?a))
			 (not (not_blocked seg_rwe_0_50 ?a))
			 (not (not_occupied seg_rwe_0_50))
			 (not (occupied seg_twe4_0_50))
			 (not (at-segment ?a seg_twe4_0_50))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_rwe_0_50_seg_rw_0_400_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (facing ?a south)
			 (not_blocked seg_rw_0_400 airplane_cfbeg)
			 (is-moving ?a)
			 (at-segment ?a seg_rwe_0_50)
			 (not_occupied seg_rw_0_400)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_rwe_0_50_seg_rw_0_400_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (at-segment ?a seg_rw_0_400)
			 (not_occupied seg_rwe_0_50)
			 (not_blocked seg_twe4_0_50 ?a)
			 (blocked seg_rw_0_400 ?a)
			 (occupied seg_rw_0_400)			
			 (not (not_occupied seg_rw_0_400))
			 (not (occupied seg_rwe_0_50))
			 (not (blocked seg_twe4_0_50 ?a))
			 (not (at-segment ?a seg_rwe_0_50))
			 (not (not_blocked seg_rw_0_400 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_rw_0_400_seg_rww_0_50_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (facing ?a south)
			 (at-segment ?a seg_rw_0_400)
			 (not_blocked seg_rww_0_50 airplane_cfbeg)
			 (not_occupied seg_rwe_0_50)
			 (is-moving ?a)
			 (not_occupied seg_rww_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_rw_0_400_seg_rww_0_50_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (occupied seg_rww_0_50)
			 (blocked seg_rww_0_50 ?a)
			 (at-segment ?a seg_rww_0_50)
			 (not_occupied seg_rw_0_400)			
			 (not (not_occupied seg_rww_0_50))
			 (not (at-segment ?a seg_rw_0_400))
			 (not (not_blocked seg_rww_0_50 ?a))
			 (not (occupied seg_rw_0_400))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_rww_0_50_seg_tww4_0_50_south_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (at-segment ?a seg_rww_0_50)
			 (facing ?a south)
			 (not_occupied seg_tww4_0_50)
			 (not_occupied seg_rwtw1_0_10)
			 (is-moving ?a)
			 (not_blocked seg_tww4_0_50 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_rww_0_50_seg_tww4_0_50_south_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_rwtw1_0_10 ?a)
			 (not_blocked seg_rwe_0_50 ?a)
			 (facing ?a north)
			 (blocked seg_tww4_0_50 ?a)
			 (occupied seg_tww4_0_50)
			 (not_occupied seg_rww_0_50)
			 (at-segment ?a seg_tww4_0_50)
			 (not_blocked seg_rw_0_400 ?a)			
			 (not (at-segment ?a seg_rww_0_50))
			 (not (not_blocked seg_tww4_0_50 ?a))
			 (not (blocked seg_rwe_0_50 ?a))
			 (not (facing ?a south))
			 (not (not_blocked seg_rwtw1_0_10 ?a))
			 (not (not_occupied seg_tww4_0_50))
			 (not (occupied seg_rww_0_50))
			 (not (blocked seg_rw_0_400 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_tww4_0_50_seg_tww3_0_50_north_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_tww3_0_50)
			 (not_blocked seg_tww3_0_50 airplane_cfbeg)
			 (has-type ?a medium)
			 (facing ?a north)
			 (is-moving ?a)
			 (at-segment ?a seg_tww4_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_tww4_0_50_seg_tww3_0_50_north_north_medium ?ocurrent ?a))
	:effect (and			
			 (occupied seg_tww3_0_50)
			 (at-segment ?a seg_tww3_0_50)
			 (not_blocked seg_rwtw1_0_10 ?a)
			 (not_occupied seg_tww4_0_50)
			 (blocked seg_tww3_0_50 ?a)
			 (not_blocked seg_rww_0_50 ?a)			
			 (not (not_occupied seg_tww3_0_50))
			 (not (blocked seg_rwtw1_0_10 ?a))
			 (not (not_blocked seg_tww3_0_50 ?a))
			 (not (occupied seg_tww4_0_50))
			 (not (blocked seg_rww_0_50 ?a))
			 (not (at-segment ?a seg_tww4_0_50))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_tww3_0_50_seg_tww2_0_50_north_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_tww2_0_50)
			 (has-type ?a medium)
			 (not_blocked seg_tww2_0_50 airplane_cfbeg)
			 (at-segment ?a seg_tww3_0_50)
			 (facing ?a north)
			 (is-moving ?a)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_tww3_0_50_seg_tww2_0_50_north_north_medium ?ocurrent ?a))
	:effect (and			
			 (not_occupied seg_tww3_0_50)
			 (occupied seg_tww2_0_50)
			 (not_blocked seg_tww4_0_50 ?a)
			 (blocked seg_tww2_0_50 ?a)
			 (at-segment ?a seg_tww2_0_50)			
			 (not (occupied seg_tww3_0_50))
			 (not (not_occupied seg_tww2_0_50))
			 (not (at-segment ?a seg_tww3_0_50))
			 (not (blocked seg_tww4_0_50 ?a))
			 (not (not_blocked seg_tww2_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_tww2_0_50_seg_tww1_0_200_north_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (not_occupied seg_tww1_0_200)
			 (at-segment ?a seg_tww2_0_50)
			 (facing ?a north)
			 (is-moving ?a)
			 (not_blocked seg_tww1_0_200 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_tww2_0_50_seg_tww1_0_200_north_north_medium ?ocurrent ?a))
	:effect (and			
			 (not_occupied seg_tww2_0_50)
			 (blocked seg_tww1_0_200 ?a)
			 (occupied seg_tww1_0_200)
			 (at-segment ?a seg_tww1_0_200)
			 (not_blocked seg_tww3_0_50 ?a)			
			 (not (occupied seg_tww2_0_50))
			 (not (not_blocked seg_tww1_0_200 ?a))
			 (not (not_occupied seg_tww1_0_200))
			 (not (at-segment ?a seg_tww2_0_50))
			 (not (blocked seg_tww3_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_tww1_0_200_seg_ppdoor_0_40_north_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_ppdoor_0_40)
			 (has-type ?a medium)
			 (not_occupied seg_twe1_0_200)
			 (not_blocked seg_ppdoor_0_40 airplane_cfbeg)
			 (at-segment ?a seg_tww1_0_200)
			 (facing ?a north)
			 (is-moving ?a)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_tww1_0_200_seg_ppdoor_0_40_north_south_medium ?ocurrent ?a))
	:effect (and			
			 (occupied seg_ppdoor_0_40)
			 (blocked seg_twe1_0_200 ?a)
			 (at-segment ?a seg_ppdoor_0_40)
			 (not_occupied seg_tww1_0_200)
			 (facing ?a south)
			 (not_blocked seg_tww2_0_50 ?a)
			 (blocked seg_ppdoor_0_40 ?a)			
			 (not (not_occupied seg_ppdoor_0_40))
			 (not (blocked seg_tww2_0_50 ?a))
			 (not (not_blocked seg_twe1_0_200 ?a))
			 (not (occupied seg_tww1_0_200))
			 (not (facing ?a north))
			 (not (at-segment ?a seg_tww1_0_200))
			 (not (not_blocked seg_ppdoor_0_40 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action move_seg_ppdoor_0_40_seg_pp_0_60_south_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (has-type ?a medium)
			 (at-segment ?a seg_ppdoor_0_40)
			 (facing ?a south)
			 (not_occupied seg_pp_0_60)
			 (is-moving ?a)
			 (not_blocked seg_pp_0_60 airplane_cfbeg)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-move_seg_ppdoor_0_40_seg_pp_0_60_south_south_medium ?ocurrent ?a))
	:effect (and			
			 (not_occupied seg_ppdoor_0_40)
			 (not_blocked seg_twe1_0_200 ?a)
			 (not_blocked seg_tww1_0_200 ?a)
			 (blocked seg_pp_0_60 ?a)
			 (occupied seg_pp_0_60)
			 (at-segment ?a seg_pp_0_60)			
			 (not (occupied seg_ppdoor_0_40))
			 (not (blocked seg_twe1_0_200 ?a))
			 (not (at-segment ?a seg_ppdoor_0_40))
			 (not (blocked seg_tww1_0_200 ?a))
			 (not (not_blocked seg_pp_0_60 ?a))
			 (not (not_occupied seg_pp_0_60))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action takeoff_seg_rww_0_50_north
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-moving ?a)
			 (at-segment ?a seg_rww_0_50)
			 (facing ?a north)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-takeoff_seg_rww_0_50_north ?ocurrent ?a))
	:effect (and			
			 (not_occupied seg_rww_0_50)
			 (not_blocked seg_rww_0_50 ?a)
			 (not_blocked seg_tww4_0_50 ?a)
			 (airborne ?a seg_rww_0_50)			
			 (not (at-segment ?a seg_rww_0_50))
			 (not (blocked seg_tww4_0_50 ?a))
			 (not (is-moving ?a))
			 (not (occupied seg_rww_0_50))
			 (not (blocked seg_rww_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action takeoff_seg_rwe_0_50_south
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (at-segment ?a seg_rwe_0_50)
			 (facing ?a south)
			 (is-moving ?a)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-takeoff_seg_rwe_0_50_south ?ocurrent ?a))
	:effect (and			
			 (not_blocked seg_rwe_0_50 ?a)
			 (not_occupied seg_rwe_0_50)
			 (not_blocked seg_twe4_0_50 ?a)
			 (airborne ?a seg_rwe_0_50)			
			 (not (blocked seg_rwe_0_50 ?a))
			 (not (occupied seg_rwe_0_50))
			 (not (blocked seg_twe4_0_50 ?a))
			 (not (is-moving ?a))
			 (not (at-segment ?a seg_rwe_0_50))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action park_seg_pp_0_60_north
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-moving ?a)
			 (at-segment ?a seg_pp_0_60)
			 (facing ?a north)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-park_seg_pp_0_60_north ?ocurrent ?a))
	:effect (and			
			 (is-parked ?a seg_pp_0_60)			
			 (not (is-moving ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action park_seg_pp_0_60_south
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (facing ?a south)
			 (at-segment ?a seg_pp_0_60)
			 (is-moving ?a)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-park_seg_pp_0_60_south ?ocurrent ?a))
	:effect (and			
			 (is-parked ?a seg_pp_0_60)
			 (not_blocked seg_ppdoor_0_40 ?a)			
			 (not (blocked seg_ppdoor_0_40 ?a))
			 (not (is-moving ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_pp_0_60_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (at-segment ?a seg_pp_0_60)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_pp_0_60_north_medium ?ocurrent ?a))
	:effect (and			
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_pp_0_60_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (at-segment ?a seg_pp_0_60)
			 (not_occupied seg_ppdoor_0_40)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_pp_0_60_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_ppdoor_0_40 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_ppdoor_0_40 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_ppdoor_0_40_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_pp_0_60)
			 (at-segment ?a seg_ppdoor_0_40)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_ppdoor_0_40_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_pp_0_60 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_pp_0_60 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_ppdoor_0_40_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_twe1_0_200)
			 (not_occupied seg_tww1_0_200)
			 (at-segment ?a seg_ppdoor_0_40)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_ppdoor_0_40_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe1_0_200 ?a)
			 (is-moving ?a)
			 (blocked seg_tww1_0_200 ?a)			
			 (not (not_blocked seg_tww1_0_200 ?a))
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe1_0_200 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww1_0_200_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_tww2_0_50)
			 (at-segment ?a seg_tww1_0_200)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww1_0_200_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_tww2_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_tww2_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww1_0_200_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_ppdoor_0_40)
			 (not_occupied seg_twe1_0_200)
			 (at-segment ?a seg_tww1_0_200)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww1_0_200_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_ppdoor_0_40 ?a)
			 (blocked seg_twe1_0_200 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_ppdoor_0_40 ?a))
			 (not (not_blocked seg_twe1_0_200 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe1_0_200_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_twe2_0_50)
			 (at-segment ?a seg_twe1_0_200)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe1_0_200_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe2_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe2_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe1_0_200_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_tww1_0_200)
			 (not_occupied seg_ppdoor_0_40)
			 (at-segment ?a seg_twe1_0_200)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe1_0_200_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_ppdoor_0_40 ?a)
			 (is-moving ?a)
			 (blocked seg_tww1_0_200 ?a)			
			 (not (not_blocked seg_tww1_0_200 ?a))
			 (not (is-pushing ?a))
			 (not (not_blocked seg_ppdoor_0_40 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww2_0_50_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_tww3_0_50)
			 (is-pushing ?a)
			 (at-segment ?a seg_tww2_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww2_0_50_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_tww3_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_tww3_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww2_0_50_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (at-segment ?a seg_tww2_0_50)
			 (not_occupied seg_tww1_0_200)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww2_0_50_south_medium ?ocurrent ?a))
	:effect (and			
			 (is-moving ?a)
			 (blocked seg_tww1_0_200 ?a)			
			 (not (not_blocked seg_tww1_0_200 ?a))
			 (not (is-pushing ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww3_0_50_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_tww4_0_50)
			 (is-pushing ?a)
			 (at-segment ?a seg_tww3_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww3_0_50_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_tww4_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_tww4_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww3_0_50_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_tww2_0_50)
			 (at-segment ?a seg_tww3_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww3_0_50_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_tww2_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_tww2_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww4_0_50_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_rww_0_50)
			 (is-pushing ?a)
			 (at-segment ?a seg_tww4_0_50)
			 (not_occupied seg_rwtw1_0_10)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww4_0_50_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_rww_0_50 ?a)
			 (blocked seg_rwtw1_0_10 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_rww_0_50 ?a))
			 (not (not_blocked seg_rwtw1_0_10 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_tww4_0_50_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_tww3_0_50)
			 (is-pushing ?a)
			 (at-segment ?a seg_tww4_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_tww4_0_50_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_tww3_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_tww3_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe4_0_50_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (at-segment ?a seg_twe4_0_50)
			 (not_occupied seg_rwe_0_50)
			 (not_occupied seg_rwte1_0_10)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe4_0_50_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_rwe_0_50 ?a)
			 (blocked seg_rwte1_0_10 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_rwe_0_50 ?a))
			 (not (not_blocked seg_rwte1_0_10 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe4_0_50_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_twe3_0_50)
			 (at-segment ?a seg_twe4_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe4_0_50_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe3_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe3_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe3_0_50_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (not_occupied seg_twe4_0_50)
			 (is-pushing ?a)
			 (at-segment ?a seg_twe3_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe3_0_50_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe4_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe4_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe3_0_50_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_twe2_0_50)
			 (at-segment ?a seg_twe3_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe3_0_50_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe2_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe2_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe2_0_50_north_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_twe3_0_50)
			 (at-segment ?a seg_twe2_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe2_0_50_north_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe3_0_50 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe3_0_50 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)
(:action startup_seg_twe2_0_50_south_medium
	:parameters (?olast - order ?ocurrent - order ?a - airplane)
	:precondition (and			
			 (is-pushing ?a)
			 (not_occupied seg_twe1_0_200)
			 (at-segment ?a seg_twe2_0_50)
			 (last ?olast)
			 (before ?olast ?ocurrent)
			 (plan-action-startup_seg_twe2_0_50_south_medium ?ocurrent ?a))
	:effect (and			
			 (blocked seg_twe1_0_200 ?a)
			 (is-moving ?a)			
			 (not (is-pushing ?a))
			 (not (not_blocked seg_twe1_0_200 ?a))
			 (not (last ?olast))
			 (last ?ocurrent))
)

)