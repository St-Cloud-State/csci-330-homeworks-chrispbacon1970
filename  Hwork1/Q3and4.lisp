; 3.
; a.
(write (caddr '(a b x d) ))
(terpri)
; b.
(write (car (cadadr '(a (b (x d))) ) )   )
(terpri)
; c.
(write (caadar (cdaar '((( a (b (x) d))))) ) )
(terpri)
; 4.
; a.
(write (cons 'a (cons 'b (cons 'x (cons 'd NIL)))))
(terpri)
; b.
(write (cons 'a (cons 'b (cons 'x 'd))))
(terpri)
; c.
(write (cons (cons (cons 'a (cons 'b (cons (cons 'x NIL) (cons 'd NIL)))) NIL) NIL))
(terpri)