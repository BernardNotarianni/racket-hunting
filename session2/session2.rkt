#lang racket

(require 2htdp/image 2htdp/universe)
(require "session2/myshapes.rkt")

;;
;;

(rond-rouge)

(carre)

(overlay/xy (carre) 10 10 (rond-rouge))

(define (scene)
  (overlay/xy (carre) 10 10 (rond-rouge)))

(define (scene2 tick)
  (overlay/xy (carre) tick tick (rond-rouge)))

(animate scene2)

;;;
;;;

((lambda (a b) (+ a b)) 2 3)

(define (additionneur)
  (lambda (a b) (+ a b)))

(additionneur)

((additionneur) 2 3)

(define (incrementeur a)
  (lambda (x) (+ x a)))

((incrementeur 3) 5)

(define (incr)
  (incrementeur 1))

((incr) 3)



(define (scene3)
  (animate (lambda (tick)
             (overlay/xy (carre) (cos tick) (sin tick) (rond-rouge)))))


(scene3)

;;;
;;;
;;;

(cons 1 2)

(cons '1 '2)

(car (cons 1 2))
(cdr (cons 1 2))

;;;
;;;

(define (trajectoire x)
  (cons (cos x) (sin x)))

(trajectoire 1)

(trajectoire 2)

;;;

(define (scene4)
  (animate (lambda (tick)
             (overlay/xy (carre) (car (trajectoire tick)) (cdr (trajectoire tick)) (rond-rouge)))))

(scene4)


(define (trajectoire tick)
  (let ((x (cos tick))
        (y (sin tick)))
  (cons x y)))

(scene4)


(define (trajectoire tick)
  (let ((x (cos (* 10 tick)))
        (y (sin (* 10 tick))))
  (cons x y)))


(define (trajectoire tick)
  (let ((x (cos (* 10 tick)))
        (y (sin (* 10 tick))))
  (cons (+ 20 x) (+ 20 y))))


(define (trajectoire tick)
  (let ((x (cos (/ tick 10)))
        (y (sin (/ tick 10))))
  (cons (+ 20 (* 20 x)) (+ 20 (* 20 y)))))

(define (trajectoire tick)
  (let ((x (cos (/ tick 10)))
        (y (sin (/ tick 10))))
  (cons (+ 50 (* 40 x)) (+ 50 (* 40 y)))))




