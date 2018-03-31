(in-package :namer)

;;; FUNCTION make-name (name-list)
;;; ---------------------------------------------------------------------
;;; Given a list of reference names, NAME-LIST, construct and return a
;;; new name

(defun make-name (name-list)
  (let* ((left (any name-list))
         (left-half (firsthalf left))
         (left-consonant-count (count-end-consonants left-half))
         (right (any name-list))
         (right-half (secondhalf right))
         (right-consonant-count (count-start-consonants right-half)))
    (if (>= (+ left-consonant-count right-consonant-count) 3)
        (concatenate 'string left-half (string (any $vowels)) right-half)
        (concatenate 'string left-half right-half))))

;;; (defparameter $names (lines "/Users/mikel/Workshop/src/gnamer/us.names"))
;;; (make-name $names)

;;; FUNCTION make-name2 (name-start-list name-end-list)
;;; ---------------------------------------------------------------------
;;; Given two lists of reference names, NAME-START-LIST and
;;; NAME-END-LIST, derive the start of a new name from NAME-START-LIST
;;; and the end of the new name from NAME-END-LIST, combine the start
;;; and end to make a new name, and return it


(defun make-name2 (name-start-list name-end-list)
  (let* ((left (any name-start-list))
         (left-half (firsthalf left))
         (left-consonant-count (count-end-consonants left-half))
         (right (any name-end-list))
         (right-half (secondhalf right))
         (right-consonant-count (count-start-consonants right-half)))
    (if (>= (+ left-consonant-count right-consonant-count) 3)
        (concatenate 'string left-half (string (any $vowels)) right-half)
        (concatenate 'string left-half right-half))))

;;; (defparameter $name-starts (lines "/Users/mikel/Workshop/src/gnamer/us.names"))
;;; (defparameter $name-ends (lines "/Users/mikel/Workshop/src/gnamer/latin.names"))
;;; (make-name2 $name-starts $name-ends)

;;; FUNCTION make-names (name-list count)
;;; ---------------------------------------------------------------------
;;; Given a list of name starts, NAME-START-LIST and a count of how
;;; many new names to make, COUNT, construct and return COUNT new
;;; names using make-name

(defun make-names (name-list count)
  (loop for i from 0 below count
        collect (make-name name-list)))

;;; (defparameter $names (lines "/Users/mikel/Workshop/src/gnamer/us.names"))
;;; (make-names $names 20)

;;; FUNCTION make-names2 (name-start-list name-end-list count)
;;; ---------------------------------------------------------------------
;;; Given a list of name starts, NAME-START-LIST, and a list of name
;;; ends, NAME-END-LIST, and a count of how many new names to make,
;;; COUNT, construct and return COUNT new names using make-name2


(defun make-names2 (name-start-list name-end-list count)
  (loop for i from 0 below count
        collect (make-name2 name-start-list name-end-list)))

;;; (defparameter $name-starts (lines "/Users/mikel/Workshop/src/gnamer/us.names"))
;;; (defparameter $name-ends (lines "/Users/mikel/Workshop/src/gnamer/latin.names"))
;;; (make-names2 $name-starts $name-ends 20)
