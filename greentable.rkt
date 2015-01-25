#lang racket

;; green table

(require 2htdp/image 2htdp/universe)
(require "session2/myshapes.rkt")

(define (incrementeur a)
  (lambda (x) (+ x a)))

(define (incr)
  (incrementeur 1))

