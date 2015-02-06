#lang racket
(require 2htdp/image 2htdp/universe)

(define (carre)
  (rectangle 200 200 50 "black"))

(define (rond-bleu)
  (circle 10 "solid" "blue"))

(define (rond-rouge)
  (circle 10 "solid" "red"))

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

(define (rebondi-verticalement tick)
  (cons 10 (trajectoire-rebondie tick)))

;;; rond bleu qui tourne en cercle

(define (tourne-en-cercle-x tick)
  (+ 100 (* (cos (/ tick 10)) 50)))

(define (tourne-en-cercle-y tick)
  (+ 100 (* (sin (/ tick 10)) 50)))

(define (tourne-en-cercle tick)
  (cons (tourne-en-cercle-x tick)
        (tourne-en-cercle-y tick)))


;;; les deux ronds ensembles


(define (place-position scene forme position)
  (overlay/xy scene (car position) (cdr position) forme))

(define (deplace-selon-trajectoire forme trajectoire)
  (lambda (scene tick)
    (place-position scene forme (trajectoire tick))))

  
(define (place-rond-bleu)
  (deplace-selon-trajectoire (rond-bleu) tourne-en-cercle))

(define (place-rond-rouge)
  (deplace-selon-trajectoire (rond-rouge) rebondi-verticalement))

(define (place-les-ronds tick)  
  ((place-rond-rouge) ((place-rond-bleu) (carre) tick) tick))


;(animate place-les-ronds)

