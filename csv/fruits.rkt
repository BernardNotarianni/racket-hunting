#lang racket

;; voir http://www.neilvandyke.org/racket-csv/

(require (planet neil/csv:2:0))

(define make-food-csv-reader
  (make-csv-reader-maker
   '((separator-chars            #\;)
     (strip-leading-whitespace?  . #t)
     (strip-trailing-whitespace? . #t))))

(define next-row
  (make-food-csv-reader (open-input-file "fruits.csv")))



(struct fruit (nom quantite prix) #:transparent)

(define fruits-csv
  (csv->list  (make-food-csv-reader (open-input-file "fruits.csv"))))

(define fruits-struct
  (map (lambda (f) (apply fruit f)) fruits-csv))

(define (virgule->point str)
  (string-replace str "," "."))

(define (converti-numeric ce-fruit)
  (fruit (fruit-nom ce-fruit)
         (string->number (fruit-quantite ce-fruit))
         (string->number (virgule->point (fruit-prix ce-fruit)))))

(define fruits
  (map converti-numeric fruits-struct))




(define (banane? f)
  (equal? (fruit-nom f) "Banane"))

(define bananes
  (filter banane? fruits))

(define total-prix
  (foldl (lambda (f acc)
         (+ acc (* (fruit-quantite f) (fruit-prix f))))
        0 fruits))

