#lang racket

;;
;; Lancer le jeu avec la commande suivante
;; > (joue-snake)
;;
;; Amusez vous :-)
;;

(struct position (x y))

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

  

(define (etat-de-depart)
  (position 10 10))

(define (nouvel-etat etat-precedent)
  etat-precedent)




(define (deplace-horizontalement etat deplacement)
  (define (x) (position-x etat))
  (define (y) (position-y etat))
  (define (nouveau-x) (+ (x) deplacement))
  (cond 
    [(< (nouveau-x) (limite-gauche)) (position (limite-droite) (y))]
    [(< (limite-droite) (nouveau-x)) (position (limite-gauche) (y))]
    [else (position (nouveau-x) (y))]))

(define (va-a-gauche etat)
  (deplace-horizontalement etat -10))

(define (va-a-droite etat)
  (deplace-horizontalement etat +10))



(define (deplace-verticalement etat deplacement)
  (define (x) (position-x etat))
  (define (y) (position-y etat))
  (define (nouveau-y) (+ (y) deplacement))
  (cond 
    [(< (nouveau-y) (limite-en-haut)) (position (x) (limite-en-bas))]
    [(< (limite-en-bas) (nouveau-y)) (position (x) (limite-en-haut))]
    [else (position (x) (nouveau-y))]))

(define (va-en-haut etat)
  (deplace-verticalement etat -10))

(define (va-en-bas etat)
  (deplace-verticalement etat +10))




(define (clavier-detecté etat a-key)
  (cond
    [(key=? a-key "left")  (va-a-gauche etat)]
    [(key=? a-key "right") (va-a-droite etat)]
    [(key=? a-key "up")    (va-en-haut etat)]
    [(key=? a-key "down")  (va-en-bas etat)]
    [else etat]))

  
(define (dessine-scene etat)
  (underlay/xy (fond-ecran)
               (position-x etat)
               (position-y etat)
               (tete-du-serpent)))

(define (joue-snake)
  (big-bang (etat-de-depart)
            (on-tick nouvel-etat)
            (on-key clavier-detecté)
            (to-draw dessine-scene)))
            
