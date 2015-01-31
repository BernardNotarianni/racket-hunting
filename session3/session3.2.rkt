#lang racket
(require 2htdp/image 2htdp/universe)
(require "../session2/myshapes.rkt")



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

(animate (scenarise trajectoire-rebondie))
