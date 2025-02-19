(defun partition (unprocessed processed1 processed2) 
    "recursively partition a list into two lists"
    (if (= (mod (length unprocessed) 2) 1) ; determine if unprocessed length is odd using modulo and list length
        (if (< 0 (length unprocessed)) ; if unprocessed is not empty
                (push (car unprocessed) processed1) ; push the car of the unprocessed list to processed1
        )

        ; else if unprocessed length is even
        (if (< 0 (length unprocessed)) ; if unprocessed is not empty
            (push (car unprocessed) processed2) ; push the car of the unprocessed list to processed2
        )
    )
    (setq unprocessed (cdr unprocessed)) ; remove the first element of the unprocessed list
    (if (> (length unprocessed) 0) ; if there unprocessed items
        (partition unprocessed processed1 processed2) ; then do another recursion over them
        (list processed1 processed2)
    )
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
                    (setq result (append result (list (car processed1)))) 
                    (pop processed1)
                    (merge-lists processed1 processed2 result)
                )
                (
                    car (list result) ; return the result as a single list
                )
            )
        )
    )
)


(defvar partitions) ; define global variable partitions for mergesort to store the list partitions

(defun mergeSort (unsorted) 
    "partitions a list into two halves, sorts each half, then merges the two halves"
    (setq partitions (partition unsorted (list) (list))) ; set partitions to the partition of the unsorted list
    (merge-lists (sort (car partitions) '<) (sort (cadr partitions) '<) nil) ; merge the two sorted halves
)
