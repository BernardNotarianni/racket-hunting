#lang racket
(require 2htdp/image 2htdp/universe)
(require "../session2/myshapes.rkt")

(define (rond-bleu)
  (circle 10 "solid" "blue"))

(define (supperpose x y forme)
  (overlay/xy (carre) x y forme))


;;; rond rouge qui rebondi

(define (ca-monte? x)
  (cond
    [(> 50 (remainder x 100)) #t]
    [else #f]))

(define (arrondi100-inferieur x)
  (* (quotient x 100) 100))

(define (arrondi100-superieur x)
  (* (+ (quotient x 100) 1) 100))


(define (trajectoire-rebondie x)
  (cond
    [(ca-monte? x) (- x (arrondi100-inferieur x))]
    [else (- (arrondi100-superieur x) x)]))

(define (place-rond-rouge scene tick)
  (place scene (rond-rouge) trajectoire-rebondie tick))

;;; rond bleu qui tourne en cercle

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


(define (place-rond-bleu scene tick)
  (place scene (rond-bleu) trajectoire-cercle tick))


;;; les deux ronds ensembles

(define (place-les-ronds tick)  
  (place-rond-rouge (place-rond-bleu (carre) tick) tick))


;(animate placce-les-ronds)

