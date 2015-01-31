#lang racket
(require 2htdp/image 2htdp/universe)
(require "../session2/myshapes.rkt")

(overlay/xy (carre) 10 10 (rond-rouge))

(define (scene y)
  (overlay/xy (carre) 10 y (rond-rouge)))

(animate scene)
