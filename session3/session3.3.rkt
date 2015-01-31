#lang racket
(require 2htdp/image 2htdp/universe)
(require "../session2/myshapes.rkt")


(define (scenarise trajectoire)
  (lambda (x)
    (overlay/xy (carre) 10 (trajectoire x) (rond-rouge))))



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

(animate (scenarise trajectoire-rebondie2))