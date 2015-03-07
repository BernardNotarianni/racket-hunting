#lang racket

;;
;; Lancer le jeu avec la commande suivante
;; > (joue-snake)
;;
;; Amusez vous :-)
;;


(require 2htdp/image 2htdp/universe)

(define (fond-ecran)
  (square 300 50 "black"))


(define (etat-de-depart)
  0)

(define (nouvel-etat etat-precedent)
  0)

(define (dessine-scene etat)
  (fond-ecran))

(define (joue-snake)
  (big-bang (etat-de-depart)
            (on-tick nouvel-etat)
            (to-draw dessine-scene)))
            
