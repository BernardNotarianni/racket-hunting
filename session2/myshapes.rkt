#lang racket
(provide carre)
(provide rond-rouge)

(require 2htdp/image)

(define (carre)
  (rectangle 200 200 50 "black"))

(define (rond-rouge)
  (circle 10 "solid" "red"))
