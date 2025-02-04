;;;  Petrobras domain
;;;
;;;  BASIC ATOMS needed to make the problem
;;;
;;;  (cargo-at ?cargo ?loc)
;;;  (vessel-at ?vessel ?loc)
;;;	
;;; 
;;;  (in-vessel ?cargo ?vessel)
;;;  (in-port ?cargo ?port)
;;;  (in-platform ?cargo ?platform)
;;;  (is-docked ?vessel ?loc)
;;;	 (is-empty ?vessel)
;;;
;;;  (port ?port ?actual-capacity)
;;;  (platform ?platform ?actual-capacity)
;;;  (vessel ?vessel ?actual-capacity ?fuel)
;;;  (cargo ?cargo ?weight)
;;;  (is-waiting-area ?loc)
;;;  (can-refuel ?platform)
;;;  (location ?loc ?x ?y)
;;;  
;;;
;;;  Basic operators
;;;
;;;  (:operator (!load-vessel ?cargo ?vessel ?loc))
;;;  (:operator (!unload-vessel ?cargo ?vessel ?loc))
;;;  (:operator (!move-vessel ?vessel ?loc-from ?loc-to ?modifier))
;;;

;;;-------------problem set 2----------------------------------------
(in-package :shop2-user)
    (defdomain petrobras 
       (
        ;; basic operators

        (:operator (!load-vessel ?cargo ?vessel ?loc)
				   (
				   (cargo ?cargo ?weight)
				   (vessel ?vessel ?capacity ?fuel)
				   (assign ?new-capacity (call - ?capacity ?weight))
				   )
				   
                   ((cargo-at ?cargo ?loc)  
				    (vessel ?vessel ?capacity ?fuel)
					(is-empty ?vessel)
				   )
				   
                   ((in-vessel ?cargo ?vessel)
				    (vessel ?vessel ?new-capacity ?fuel)
					)
				   )

        (:operator (!unload-vessel ?cargo ?vessel ?loc)
				   (
				   (cargo ?cargo ?weight)
				   (vessel ?vessel ?capacity ?fuel)
				   (assign ?new-capacity (call + ?capacity ?weight))
				   )
                   ((in-vessel ?cargo ?vessel)
					(vessel ?vessel ?capacity ?fuel)
                    )
                   ((cargo-at ?cargo ?loc)
				    (vessel ?vessel ?new-capacity ?fuel)
					(is-empty ?vessel)
					)
		)

        (:operator (!move-vessel ?vessel ?loc-from ?loc-to ?modifier)
				   (
					(location ?loc-from)
					(location ?loc-to)
					(vessel ?vessel ?capacity ?fuel)
					(distance ?loc-from ?loc-to ?dist)
					(assign ?actual-fuel (- ?fuel (/ ?dist ?modifier)))
					)
                   ((vessel-at ?vessel ?loc-from)
					(vessel ?vessel ?capacity ?fuel))
                   ((vessel-at ?vessel ?loc-to)
					(vessel ?vessel ?capacity ?actual-fuel)
                   )
        )

        (:operator (!refuel-vessel ?vessel ?amount ?loc)
        	(
        	 (location ?loc)
        	 (can-refuel ?loc)
        	 (vessel-at ?vessel ?loc)
        	 (vessel ?vessel ?capacity ?fuel)
        	 (eval (<= (+ ?fuel ?amount) 600))
        	)
        	((vessel ?vessel ?capacity ?fuel))
        	((vessel ?vessel ?capacity 600))
        )


        ;; book-keeping methods & ops, to keep track of what needs to be done
        ;; !add-protection and !delete-protection are two special operators
        ;; that deal with the protection list instead of current state.
        (:operator (!add-protection ?g)
                   ()
                   ((:protection ?g))
                   0)

        (:operator (!delete-protection ?g)
                   ((:protection ?g))
                   ()
                   0)

    ;;;------------------------------------------------------------

        ;; actual AI planning methods
	
	
	
		;; deliver
        (:method (cargo-at ?cargo ?loc-goal)

			already-there
			(
				(cargo-at ?cargo ?loc-now)
				(same ?loc-goal ?loc-now)
			)
			((:task !add-protection (cargo-at ?cargo ?loc-goal)))
			
			 vessel-needs-refueling-on-current-location
			(	
				(vessel-at ?vessel ?loc-now)
				(can-refuel ?loc-now)
				(vessel ?vessel ?actual-capacity ?fuel)
				(eval (<= ?fuel 300))
				(assign ?necessary-fuel (- 600 ?fuel))
            )
            ((:task !refuel-vessel ?vessel ?necessary-fuel ?loc-now))

            vessel-needs-refueling-on-another-location
			(	
				(vessel-at ?vessel ?loc-now)
				(can-refuel ?loc-fuel)
				(vessel ?vessel ?actual-capacity ?fuel)
				(eval (<= ?fuel 300))
            )
            (:ordered
			   (:task vessel-at ?vessel ?loc-fuel)
			)

			vessel-carrying-cargo
			((in-vessel ?vessel ?cargo)
			 (is-waiting-area ?loc))
			(:ordered
				(:task vessel-at ?vessel ?loc-goal)
				(:task !unload-vessel ?cargo ?vessel ?loc-goal)
				(:task vessel-at ?vessel ?loc)
			)
			
            vessel-in-same-location
           (
				(cargo-at ?cargo ?loc-now)
				(vessel-at ?vessel ?loc-now)
				(is-waiting-area ?loc)
				(cargo ?cargo ?weight)
				(vessel ?vessel ?actual-capacity ?fuel)
				(eval (<= 0(- ?actual-capacity ?weight)))
				(location ?loc-goal)
				(location ?loc-now)
				(distance ?loc-from ?loc-to ?dist)
				(assign ?necessary-fuel (/ ?dist 3))
				(eval (<= ?necessary-fuel ?fuel))
			)
            (:ordered
				(:task !load-vessel ?cargo ?vessel ?loc-now)
				(:task vessel-at ?vessel ?loc-goal)
				(:task !unload-vessel ?cargo ?vessel ?loc-goal)
				(:task vessel-at ?vessel ?loc)
			)
			
			 vessel-in-another-location
			(	
				(cargo-at ?cargo ?loc-now)
				(vessel-at ?vessel ?loc)
				(different ?loc-now ?loc)
				(is-waiting-area ?waiting-area)
				(vessel ?vessel ?actual-capacity ?fuel)
				(cargo ?cargo ?weight)
				(eval (<= 0 (- ?actual-capacity ?weight)))
				(location ?loc-goal)
				(location ?loc-now)
				(distance ?loc-from ?loc-to ?dist)
				(assign ?necessary-fuel (/ ?dist 3))
				(eval (<= ?necessary-fuel ?fuel))
            )
            (:ordered
			   (:task vessel-at ?vessel ?loc-now)
			   (:task !load-vessel ?cargo ?vessel ?loc-now)
               (:task vessel-at ?vessel ?loc-goal)
               (:task !unload-vessel ?cargo ?vessel ?loc-goal)
			   (:task vessel-at ?vessel ?waiting-area)
			)
			
		)

    
    ;;;-------------------------------------------------

        (:method (vessel-at ?vessel ?loc-to)
		
			vessel-in-right-location
           ((vessel-at ?vessel ?loc-from)
            (same ?loc-from ?loc-to))
           ((:task !add-protection (vessel-at ?vessel ?loc-to)))
		   
		   
           vessel-not-in-right-location-empty
           ((vessel-at ?vessel ?loc-from)
            (different ?loc-from ?loc-to)
			(is-empty ?vessel))
           ((:task !move-vessel ?vessel ?loc-from ?loc-to 5))

           vessel-not-in-right-location-full
           ((vessel-at ?vessel ?loc-from)
            (different ?loc-from ?loc-to))
           ((:task !move-vessel ?vessel ?loc-from ?loc-to 3))
		   
		)

    

        ;; state axioms

        (:- (same ?x ?x) nil)
        (:- (different ?x ?y) ((not (same ?x ?y))))

        ))

(eval-when (:load-toplevel)
  (petrobras-domain))

;;;--------------------------------------------------------------
