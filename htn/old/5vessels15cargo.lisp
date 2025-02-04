(in-package :shop2-user)

(defproblem teste petrobras
	(
		(port p1 100000)
		(port p2 100000)
		(platform f1 100000)
		(platform f2 100000)
		(platform f3 100000)
		(platform f4 100000)
		(platform f5 100000)
		(platform f6 100000)
		(platform g1 100000)
		(platform g2 100000)
		(platform g3 100000)
		(platform g4 100000)
		(location p1)
		(location p2)
		(location f1)
		(location f2)
		(location f3)
		(location f4)
		(location f5)
		(location f6)
		(location g1)
		(location g2)
		(location g3)
		(location g4)
		(location a1)
		(location a2)
		(is-waiting-area a1)
		(is-waiting-area a2)
		(vessel v1 100000 600)
		(vessel v2 100000 600)
		(vessel v3 100000 600)
		(vessel v4 100000 600)
		(vessel v5 100000 600)
		(vessel-at v1 a1)
		(vessel-at v2 a1)
		(vessel-at v3 a1)
		(vessel-at v4 a2)
		(vessel-at v5 a2)
		(is-empty v1)
		(is-empty v2)
		(is-empty v3)
		(is-empty v4)
		(is-empty v5)
		(can-refuel p1)
		(can-refuel p2)
		(can-refuel f1)
		(can-refuel g1)
		;;; p1 and F1-F6
		(distance p1 f1 300)
		(distance f1 p1 300)
		(distance p1 f2 160)
		(distance f2 p1 160)
		(distance p1 f3 280)
		(distance f3 p1 280)
		(distance p1 f4 200)
		(distance f4 p1 200)
		(distance p1 f5 160)
		(distance f5 p1 160)
		(distance p1 f6 130)
		(distance f6 p1 130)
		;;; p1 and G1-G4
		(distance p1 g1 350)
		(distance g1 p1 350)
		(distance p1 g2 400)
		(distance g2 p1 400)
		(distance p1 g3 450)
		(distance g3 p1 450)
		(distance p1 g4 420)
		(distance g4 p1 420)
		;;; p1 and P2, A1, A2
		(distance p1 p2 200)
		(distance p2 p1 200)
		(distance p1 a1 120)
		(distance a1 p1 120)
		(distance p1 a2 270)
		(distance a2 p1 270)
		;;; p2 and F1-F6
		(distance p2 f1 380)
		(distance f1 p2 380)
		(distance p2 f2 290)
		(distance f2 p2 290)
		(distance p2 f3 320)
		(distance f3 p2 320)
		(distance p2 f4 340)
		(distance f4 p2 340)
		(distance p2 f5 270)
		(distance f5 p2 270)
		(distance p2 f6 300)
		(distance f6 p2 300)
		;;; p2 and G1-G4
		(distance p2 g1 300)
		(distance g1 p2 300)
		(distance p2 g2 180)
		(distance g2 p2 180)
		(distance p2 g3 280)
		(distance g3 p2 280)
		(distance p2 g4 140)
		(distance g4 p2 140)
		;;; p2 and a1, a2
		(distance p2 a1 270)
		(distance a1 p2 270)
		(distance p2 a2 100)
		(distance a2 p2 100)
		;;; a1 and F1-F6
		(distance a1 f1 200)
		(distance f1 a1 200)
		(distance a1 f2 40)
		(distance f2 a1 40)
		(distance a1 f3 320)
		(distance f3 a1 320)
		(distance a1 f4 280)
		(distance f4 a1 280)
		(distance a1 f5 180)
		(distance f5 a1 180)
		(distance a1 f6 80)
		(distance f6 a1 80)
		;;; a1 and G1-G4
		(distance a1 g1 540)
		(distance g1 a1 540)
		(distance a1 g2 540)
		(distance g2 a1 540)
		(distance a1 g3 580)
		(distance g3 a1 580)
		(distance a1 g4 570)
		(distance g4 a1 570)
		;;; a1 and a2
		(distance a1 a2 340)
		(distance a2 a1 340)
		;;; a2 and F1-F6
		(distance a2 f1 340)
		(distance f1 a2 340)
		(distance a2 f2 380)
		(distance f2 a2 380)
		(distance a2 f3 370)
		(distance f3 a2 370)
		(distance a2 f4 340)
		(distance f4 a2 340)
		(distance a2 f5 280)
		(distance f5 a2 280)
		(distance a2 f6 300)
		(distance f6 a2 300)
		;;; a2 and G1-G4
		(distance a2 g1 320)
		(distance g1 a2 320)
		(distance a2 g2 110)
		(distance g2 a2 110)
		(distance a2 g3 400)
		(distance g3 a2 400)
		(distance a2 g4 180)
		(distance g4 a2 180)
		;;; f1 and F2-F6
		(distance f1 f2 168)
		(distance f2 f1 168)
		(distance f1 f3 168)
		(distance f3 f1 168)
		(distance f1 f4 120)
		(distance f4 f1 120)
		(distance f1 f5 260)
		(distance f5 f1 260)
		(distance f1 f6 240)
		(distance f6 f1 240)
		;;; f2 and F3-F6
		(distance f2 f3 240)
		(distance f3 f2 240)
		(distance f2 f4 120)
		(distance f4 f2 120)
		(distance f2 f5 168)
		(distance f5 f2 168)
		(distance f2 f6 120)
		(distance f6 f2 120)
		;;; f3 and F4-F6
		(distance f3 f4 120)
		(distance f4 f3 120)
		(distance f3 f5 168)
		(distance f5 f3 168)
		(distance f3 f6 260)
		(distance f6 f3 260)
		;;; f4 and F5-F6
		(distance f4 f5 120)
		(distance f5 f4 120)
		(distance f4 f6 168)
		(distance f6 f3 168)
		;;; f5 and f6
		(distance f5 f6 120)
		(distance f6 f5 120)
		;;; g1 and g2-g4
		(distance g1 g2 200)
		(distance g2 g1 200)
		(distance g1 g3 120)
		(distance g3 g1 120)
		(distance g1 g4 260)
		(distance g4 g1 260)
		;;; g2 and g3-g4
		(distance g2 g3 260)
		(distance g3 g2 260)
		(distance g2 g4 120)
		(distance g4 g2 120)
		;;; g3 and g4
		(distance g3 g4 200)
		(distance g4 g3 200)
		;;; f1 and G1-G4
		(distance f1 g1 468)
		(distance g1 f1 468)
		(distance f1 g2 580)
		(distance g2 f1 580)
		(distance f1 g3 588)
		(distance g3 f1 588)
		(distance f1 g4 600)
		(distance g4 f1 600)
		;;; f2 and G1-G4
		(distance f2 g1 580)
		(distance g1 f2 580)
		(distance f2 g2 468)
		(distance g2 f2 468)
		(distance f2 g3 600)
		(distance g3 f2 600)
		(distance f2 g4 588)
		(distance g4 f2 588)
		;;; f3 and G1-G4
		(distance f3 g1 420)
		(distance g1 f3 420)
		(distance f3 g2 380)
		(distance g2 f3 380)
		(distance f3 g3 420)
		(distance g3 f3 420)
		(distance f3 g4 580)
		(distance g4 f3 580)
		;;; f4 and G1-G4
		(distance f4 g1 500)
		(distance g1 f4 500)
		(distance f4 g2 520)
		(distance g2 f4 520)
		(distance f4 g3 560)
		(distance g3 f4 560)
		(distance f4 g4 580)
		(distance g4 f4 580)
		;;; f5 and G1-G4
		(distance f5 g1 380)
		(distance g1 f5 380)
		(distance f5 g2 300)
		(distance g2 f5 300)
		(distance f5 g3 580)
		(distance g3 f5 580)
		(distance f5 g4 420)
		(distance g4 f5 420)
		;;; f6 and G1-G4
		(distance f6 g1 520)
		(distance g1 f6 520)
		(distance f6 g2 500)
		(distance g2 f6 500)
		(distance f6 g3 580)
		(distance g3 f6 580)
		(distance f6 g4 580)
		(distance g4 f6 580)
		;;; Cargos 
		(cargo c1 20000)
		(cargo c2 5000)
		(cargo c3 15000)
		(cargo c4 8000)
		(cargo c5 15000)
		(cargo c6 10000)
		(cargo c7 25000)
		(cargo c8 30000)
		(cargo c9 30000)
		(cargo c10 15000)
		(cargo c11 20000)
		(cargo c12 20000)
		(cargo c13 20000)
		(cargo c14 30000)
		(cargo c15 40000)
		;;; Loading Ports
		(cargo-at c1 p1)
		(cargo-at c2 p1)
		(cargo-at c3 p1)
		(cargo-at c4 p2)
		(cargo-at c5 p1)
		(cargo-at c6 p1)
		(cargo-at c7 p1)
		(cargo-at c8 p1)
		(cargo-at c9 p2)
		(cargo-at c10 p2)
		(cargo-at c11 p2)
		(cargo-at c12 p2)
		(cargo-at c13 p2)
		(cargo-at c14 p2)
		(cargo-at c15 p2)
	)

	( 
		(cargo-at c1 f1)
		(cargo-at c2 f6)
		(cargo-at c3 f4)
		(cargo-at c4 g4)
		(cargo-at c5 f2)
		(cargo-at c6 f3)
		(cargo-at c7 f5)
		(cargo-at c8 f2)
		(cargo-at c9 g2)
		(cargo-at c10 g1)
		(cargo-at c11 g2)
		(cargo-at c12 g1)
		(cargo-at c13 f3)
		(cargo-at c14 f2)
		(cargo-at c15 f1)
	)

)

(find-plans 'teste :verbose :plans)