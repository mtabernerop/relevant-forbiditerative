(define (problem intrusion-detection-10-hosts)
	(:domain intrusiondetection)
	(:objects
		perseus cassiopea andromeda sagittarius scorpio
		virgo aries leo libra taurus - host )
	(:init
		(dummy)
	)
	(:goal
		(and
(vandalized virgo) (data-stolen-from aries) (data-stolen-from sagittarius)
		)
	)
)