#lang racket
(require 2htdp/image 2htdp/universe)
(require "../session2/myshapes.rkt")

(define (rond-bleu)
  (circle 10 "solid" "blue"))

(define (supperpose x y forme)
  (overlay/xy (carre) x y forme))


(define (trajectoire-oblique tick)
  (cons tick tick))


(define (trajectoire-cercle-x tick)
  (+ 100 (* (cos (/ tick 10)) 50)))

(define (trajectoire-cercle-y tick)
  (+ 100 (* (sin (/ tick 10)) 50)))

(define (trajectoire-cercle tick)
  (cons (trajectoire-cercle-x tick)
        (trajectoire-cercle-y tick)))


(define (place scene forme trajectoire tick)
  (let* ([position (trajectoire tick)]
         [x (car position)]
         [y (cdr position)])
  (overlay/xy scene x y forme)))



(define (place-rond-rouge scene tick)
  (place scene (rond-rouge) trajectoire-oblique tick))

(define (place-rond-bleu scene tick)
  (place scene (rond-bleu) trajectoire-cercle tick))


(define (place-les-ronds tick)  
  (place-rond-rouge (place-rond-bleu (carre) tick) tick))
;(animate (scenarise-xy trajectoire-cercle-x trajectoire-cercle-y))

