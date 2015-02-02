#lang racket
(require 2htdp/image 2htdp/universe)
(require "../session2/myshapes.rkt")


(define (scenarise-xy trajectoire-x trajectoire-y)
  (lambda (tick)
      (overlay/xy (carre) 
                  (trajectoire-x tick)
                  (trajectoire-y tick)
                  (rond-rouge))))


(define (trajectoire-cercle-x tick)
  (+ 100 (* (cos (/ tick 10)) 50)))

(define (trajectoire-cercle-y tick)
  (+ 100 (* (sin (/ tick 10)) 50)))


(animate (scenarise-xy trajectoire-cercle-x trajectoire-cercle-y))

