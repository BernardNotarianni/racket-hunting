#lang racket
(require 2htdp/image)

;;
;; drawing simple shapes
;; we use provided words

(circle 10 "solid" "red")

(rectangle 200 200 "solid" "black")

;;
;; creating our own words
;;

(+ 1 3)

(define (add a b)
  (+ a b))

(add 3 4)

;;
;; our words for shapes
;;

(define (point-rouge)
  (circle 10 "solid" "red"))

(define (carre)
  (rectangle 200 200 "solid" "black"))

(define (carre-largeur largeur)
  (rectangle largeur largeur "solid" "black"))

;;
;; merging shapes
;;

(underlay/xy (carre) 10 10 (point-rouge))

(underlay/xy (carre) 5 10 (point-rouge))

(underlay/xy (carre) 10 30 (point-rouge))


