#lang racket

;;
;; Lancer le jeu avec la commande suivante
;; > (joue-snake)
;;
;; Amusez vous :-)
;;

(struct position (x y) #:transparent)
(struct serpent (direction position) #:transparent)

(define (direction serpent)
  (serpent-direction serpent))

(require 2htdp/image 2htdp/universe)

(define (taille-du-jeu)
  300)

(define (fond-ecran)
  (square (taille-du-jeu) 50 "black"))

(define (tete-du-serpent)
  (square 10 "solid" "red"))


(define (limite-gauche)
  0)  

(define (limite-droite)
  (- (taille-du-jeu) (image-width (tete-du-serpent))))

(define (limite-en-haut)
  0)  

(define (limite-en-bas)
  (- (taille-du-jeu) (image-height (tete-du-serpent))))



(define (deplace-horizontalement cette-position deplacement)
  (define (x) (position-x cette-position))
  (define (y) (position-y cette-position))
  (define (nouveau-x) (+ (x) deplacement))
  (cond 
    [(< (nouveau-x) (limite-gauche)) (position (limite-droite) (y))]
    [(< (limite-droite) (nouveau-x)) (position (limite-gauche) (y))]
    [else (position (nouveau-x) (y))]))

(define (deplace-verticalement cette-position deplacement)
  (define (x) (position-x cette-position))
  (define (y) (position-y cette-position))
  (define (nouveau-y) (+ (y) deplacement))
  (cond 
    [(< (nouveau-y) (limite-en-haut)) (position (x) (limite-en-bas))]
    [(< (limite-en-bas) (nouveau-y)) (position (x) (limite-en-haut))]
    [else (position (x) (nouveau-y))]))


(define (etat-de-depart)
  (serpent 'vers-la-droite (position 10 10)))

(define (nouvel-etat etat-precedent)
  etat-precedent)


(define (part-a-droite ce-serpent)
  (serpent 'vers-la-droite (serpent-position ce-serpent)))

(define (part-a-gauche ce-serpent)
  (serpent 'vers-la-gauche (serpent-position ce-serpent)))

(define (part-en-bas ce-serpent)
  (serpent 'vers-le-bas (serpent-position ce-serpent)))

(define (part-en-haut ce-serpent)
  (serpent 'vers-le-haut (serpent-position ce-serpent)))

(define (deplace direction position)
 (cond 
    [(eq? direction 'vers-la-gauche) (deplace-horizontalement position -10)]
    [(eq? direction 'vers-la-droite) (deplace-horizontalement position +10)]
    [(eq? direction 'vers-le-haut)   (deplace-verticalement position -10)]
    [(eq? direction 'vers-le-bas)    (deplace-verticalement position +10)]))
     

(define (avance ce-serpent)
  (serpent (direction ce-serpent)
           (deplace (direction ce-serpent) (serpent-position ce-serpent))))



(define (clavier-detecté ce-serpent a-key)
  (cond
    [(key=? a-key "left")  (part-a-gauche ce-serpent)]
    [(key=? a-key "right") (part-a-droite ce-serpent)]
    [(key=? a-key "up")    (part-en-haut ce-serpent)]
    [(key=? a-key "down")  (part-en-bas ce-serpent)]
    [else ce-serpent]))

  
(define (dessine-scene ce-serpent)
  (define (p) (serpent-position ce-serpent))
  (underlay/xy (fond-ecran)
               (position-x (p))
               (position-y (p))
               (tete-du-serpent)))

(define (joue-snake)
  (big-bang (etat-de-depart)
            (on-tick avance)
            (on-key clavier-detecté)
            (to-draw dessine-scene)))
            

;; ===================================================================

(module+ test
  
  (require rackunit rackunit/text-ui)  
    
  (define (p x y)
    (position x y))
    
  (define (a-droite) (part-a-droite (etat-de-depart)))
  (define (a-gauche) (part-a-gauche (etat-de-depart)))
  (define (en-bas)   (part-en-bas   (etat-de-depart)))
  (define (en-haut)  (part-en-haut  (etat-de-depart)))
  
  (check-equal? (serpent-position (avance (a-droite))) (p 20 10))
  (check-equal? (serpent-position (avance (a-gauche))) (p 0 10) )
  (check-equal? (serpent-position (avance (en-haut))) (p 10 0))
  (check-equal? (serpent-position (avance (en-bas))) (p 10 20))

 
  "Tous les tests ont été executés.")
