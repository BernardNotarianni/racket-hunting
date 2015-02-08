#lang racket
(require 2htdp/image 2htdp/universe)

;; creating trajectories


;; our basic vocabulary

(define (carre-noir)
  (square 200 "solid" "black"))

(define (rond-rouge)
  (circle 10 "solid" "red"))

(define (place-rond-rouge x y)
  (underlay/xy (carre-noir) x y (rond-rouge)))


;; tranform tick into (x . y)


; data structures

(define (position x y)
  (cons x y))

(define (position-x position)
  (car position))

(define (position-y position)
  (cdr position))




; trajectories

(define (oblique tick)
  (position tick tick))

(define (horizontal tick)
  (position tick 10))

(define (vertical tick)
  (position 10 tick))

(define (anime-trajectoire trajectoire)
  (lambda (tick)
    (place-rond-rouge (position-x (trajectoire tick))
                      (position-y (trajectoire tick)))))


; (animate (anime-trajectoire oblique))

(define (anime trajectoire)
  (animate (anime-trajectoire trajectoire)))

; (anime oblique)

(define (vers-la-droite tick)
  (position tick 10))

(define (vers-la-gauche tick)
  (position (- 180 tick) 10))

(define (ca-monte? x)
  (< x 180))

(define (rebondi tick)
  (if (ca-monte? tick) (vers-la-droite tick)
      (vers-la-gauche (- tick 180))))
    
(define (modulo360 f)
  (lambda (x)
    ( f (remainder x 360))))

(define (accelere f)
  (lambda (x)
    (f (* 2 x))))

; (anime (modulo360 rebondi))
