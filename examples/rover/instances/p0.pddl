(define (problem roversProblem) 
(:domain rover)
(:objects
	general colour high_res low_res rover0 rover1 rover0store rover1store waypoint0 waypoint1 waypoint2 waypoint3 camera0 camera1 camera2 objective0 objective1 objective2 )
(:init
	(visible waypoint1 waypoint0)
	(visible waypoint0 waypoint1)
	(visible waypoint2 waypoint1)
	(visible waypoint1 waypoint2)
	(visible waypoint2 waypoint3)
	(visible waypoint3 waypoint2)
	(visible waypoint3 waypoint1)
	(visible waypoint1 waypoint3)
	(lander general)
	(mode colour)
	(mode high_res)
	(mode low_res)
	(waypoint waypoint0)
	(waypoint waypoint1)
	(at_rock_sample waypoint1)
	(waypoint waypoint2)
	(at_soil_sample waypoint2)
	(waypoint waypoint3)
	(at_soil_sample waypoint3)
	(at_rock_sample waypoint3)
	(at_lander general waypoint2)
	(channel_free general)
	(rover rover0)
	(store rover0store)
	(at rover0 waypoint3)
	(available rover0)
	(store_of rover0store rover0)
	(empty rover0store)
	(equipped_for_soil_analysis rover0)
	(equipped_for_imaging rover0)
	(can_traverse rover0 waypoint3 waypoint1)
	(can_traverse rover0 waypoint1 waypoint3)
	(rover rover1)
	(store rover1store)
	(at rover1 waypoint2)
	(available rover1)
	(store_of rover1store rover1)
	(empty rover1store)
	(equipped_for_soil_analysis rover1)
	(equipped_for_rock_analysis rover1)
	(equipped_for_imaging rover1)
	(can_traverse rover1 waypoint2 waypoint1)
	(can_traverse rover1 waypoint1 waypoint2)
	(can_traverse rover1 waypoint2 waypoint3)
	(can_traverse rover1 waypoint3 waypoint2)
	(can_traverse rover1 waypoint1 waypoint0)
	(can_traverse rover1 waypoint0 waypoint1)
	(camera camera0)
	(on_board camera0 rover1)
	(calibration_target camera0 objective0)
	(supports camera0 colour)
	(supports camera0 high_res)
	(camera camera1)
	(on_board camera1 rover0)
	(calibration_target camera1 objective0)
	(supports camera1 colour)
	(supports camera1 low_res)
	(camera camera2)
	(on_board camera2 rover0)
	(calibration_target camera2 objective1)
	(supports camera2 low_res)
	(objective objective0)
	(visible_from objective0 waypoint0)
	(visible_from objective0 waypoint1)
	(visible_from objective0 waypoint2)
	(visible_from objective0 waypoint3)
	(objective objective1)
	(visible_from objective1 waypoint0)
	(visible_from objective1 waypoint1)
	(objective objective2)
	(visible_from objective2 waypoint0)
	(visible_from objective2 waypoint1)
	(visible_from objective2 waypoint2)
)

(:goal (and
(communicated_soil_data waypoint3) (communicated_rock_data waypoint1) (communicated_image_data objective0 high_res)
))
)