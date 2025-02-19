(defun merge-lists (processed1 processed2 result)

    (if (and (not (null processed1)) (not (null processed2))) ( ; if both lists are not empty
            if (< (car processed1) (car processed2)) ( ; add processed1 to result
                progn

                (setq result (append result (list (car processed1))))
                (pop processed1)

                (merge-lists processed1 processed2 result)
            )
            ( ; add processed2 to result
                progn

                (setq result (append result (list (car processed2))))
                (pop processed2)

                (merge-lists processed1 processed2 result)
            )
        )

        ( ; one of the lists empty
            if (and (null processed1) (not (null processed2))) ( ; if processed1 is empty
                progn
                (setq result (append result (list (car processed2))))
                (pop processed2)
                (merge-lists processed1 processed2 result)
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

;(merge-lists (list 1 3) (list 2 4) (list))

(write (merge-lists (list 1 3) (list 2 4) (list)))

