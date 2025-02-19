(defun partition (unprocessed processed)
    "partitions the list into lists"
    (if (< 1 (length unprocessed)) ( ; if there is more than one unprocessed
        progn
        (setq processed (append processed (list (sort ( list (pop unprocessed) (pop unprocessed)) '<)))) ; put the two sorted list items into processed
        (partition unprocessed processed) ; recursive call
    )
    ( ; if there is one or less items
        progn
        (if (= 1 (length unprocessed)) (
            setq processed (append processed (list (list (pop unprocessed)))) ; append the first item of the list to processed
        ))
        ;(setq processed (append processed (list (list (pop unprocessed))))) ; append the first item of the list to processed
        (car (list processed)) ; return the list
    ))
)

(defun merge-lists (processed1 processed2 result)
    "recursively merge two sorted lists"
    (if (and (not (null processed1)) (not (null processed2))) ( ; if both lists are not empty
            if (< (car processed1) (car processed2)) ( ; add processed1 to result
                progn
                (setq result (append result (list (car processed1)))) ; append the car of processed1 to result
                (pop processed1) ; remove the first element of processed1
                (merge-lists processed1 processed2 result) ; recursive call to self
            )
            ( ; add processed2 to result
                progn
                (setq result (append result (list (car processed2)))) ; append car of processed2 to result
                (pop processed2) ; remove the first element of processed2
                (merge-lists processed1 processed2 result) ; recursive call to self
            )
        )

        ( ; one of the lists empty
            if (and (null processed1) (not (null processed2))) ( ; if processed1 is empty
                progn
                (setq result (append result (list (car processed2)))) ; append the car of processed2 to result
                (pop processed2) ; remove the first element of processed2
                (merge-lists processed1 processed2 result) ; recursive call to self
            )
            ( 
                if (and (null processed2) (not (null processed1))) ( ; if processed2 is empty
                    progn
                    (setq result (append result (list (car processed1)))) ; append the car of processed1 to result
                    (pop processed1) ; pop from processed1
                    (merge-lists processed1 processed2 result) ; recursive call to self
                )
                (
                    car (list result) ; return the result as a single list
                )
            )
        )
    )
)


(defvar combined) ; global variable for combining the next to element

(defun adjacent-merge (merged unmerged)
    (if (< 1 (length unmerged)) (
        progn
        (setq merged (append merged (list (merge-lists (pop unmerged) (pop unmerged) ()))))
        (adjacent-merge merged unmerged)
    )
    (
        if (= 1 (length unmerged)) ( ; if only one item
            if (null merged) (    
                progn
                (car (list unmerged))
            )
            (
                progn
                (setq merged (merge-lists merged (pop unmerged) ()))
                (if (null unmerged) (
                    progn
                    (car (list merged))
                ))
            )
        )
        ( ; unmerged empty
            progn 
            (if (< 1 (length merged)) (
                progn
                (merge-lists (pop merged) (pop merged) ())
            ))
        )

    ))
)

(defvar partlist) ; global vari

(defun mergeSort (unsorted)
    (adjacent-merge () (partition unsorted ()))
)


;(defvar partlist (partition (list 1 2 4 5 6) ()))

;(terpri)
;(write (mergeSort (list 1 2 4 3 6 10 11 12)))