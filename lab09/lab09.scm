(define (over-or-under num1 num2) 
    (
    cond ((< num1 num2) -1)
         ((> num1 num2) 1)
         (else 0)
    )
)

(define (make-adder num) (lambda (x) (+ x num)))

(define (composed f g) (lambda (x) (f (g x))))

(define (repeat f n) 
  (cond
    ((= n 1) (lambda (x) (f x)))
    ((= n 0) (lambda (x) x))
    ((even? n) (composed (repeat f (/ n 2)) (repeat f (/ n 2))))
    (else (composed (repeat f (- n 1)) f))
  )
)


(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b) 
(cond ((= (modulo a b) 0) b)
      (else (gcd b (modulo a b))))
)
