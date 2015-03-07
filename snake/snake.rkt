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

(define (limite-droite)
  (- (taille-du-jeu) (image-width (tete-du-serpent))))

(define (limite-gauche)
  0)  
  
  
(define (etat-de-depart)
  (position 10 10))

(define (nouvel-etat etat-precedent)
  etat-precedent)

(define (va-a-gauche etat)
  (define (x) (position-x etat))
  (define (y) (position-y etat))
  (cond 
    [(= (limite-gauche) (x)) (position (limite-droite) (y))]
    [else (position (- (x) 10) (y))]))


(define (va-a-droite etat)
  (define (x) (position-x etat))
  (define (y) (position-y etat))
  (cond 
    [(= (limite-droite) (x)) (position (limite-gauche) (y))]
    [else (position (+ (x) 10) (y))]))


(define (clavier-detecté etat a-key)
  (cond
    [(key=? a-key "left")  (va-a-gauche etat)]
    [(key=? a-key "right") (va-a-droite etat)]
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
            
