(define (if-program condition if-true if-false)
  `(if ,condition ,if-true ,if-false))

(define (square n) (* n n))

(define (pow-expr base exp) 
(cond ((= exp 0) 1)
  ((= exp 1) (list '* base 1))
  ((odd? exp) (list '* base (pow-expr base (- exp 1))))
  (else (list 'square (pow-expr base (/ exp 2))))
  )
)


(define-macro (repeat n expr)
  `(repeated-call ,n ',expr))

; Call zero-argument procedure f n times and return the final result.
(define (repeated-call n f)
  (if (= n 1)
      (eval f)
      (begin (eval f) (repeated-call (- n 1) f))))
