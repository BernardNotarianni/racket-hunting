#lang racket
(require 2htdp/image 2htdp/universe)
(require "session2/myshapes.rkt")


(overlay/xy (carre) 10 10 (rond-rouge))

(define (scene y)
  (overlay/xy (carre) 10 y (rond-rouge)))

(animate scene)

;;;
;;;
;;;


(define (scenarise trajectoire)
  (lambda (x)
    (overlay/xy (carre) 10 (trajectoire x) (rond-rouge))))

(define (trajectoire-tout-droit x)
  x)


(define (trajectoire-rebondie x)
  (cond
    [(> x 250) (- 300 x)]
    [(> x 200) (- x 200)]
    [(> x 150) (- 200 x)]
    [(> x 100) (- x 100)]
    [(> x 50)  (- 100 x)]
    [else x]))


;;;;

(define (ca-monte? x)
  (cond
    [(> 50 (remainder x 100)) #t]
    [else #f]))

(define (arrondi100-inferieur x)
  (* (quotient x 100) 100))

(define (arrondi100-superieur x)
  (* (+ (quotient x 100) 1) 100))


(define (trajectoire-rebondie2 x)
  (cond
    [(ca-monte? x) (- x (arrondi100-inferieur x))]
    [else (- (arrondi100-superieur x) x)]))