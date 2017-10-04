(in-package :cl-user)

(defpackage :namer
  (:use :cl :capi))

(in-package :namer)

(defparameter $path "/Users/greer/Desktop/greersnamer/us.names")

(defun readfile (the-path)
  (with-open-file (in the-path)
    (loop for line = (read-line in nil nil nil)
        then (read-line in nil nil nil)
        while line
        collect line)))

(defun any (a-sequence)
  (elt a-sequence
       (random (length a-sequence))))

(defparameter $vowels '(#\a #\e #\i #\o #\u))

(defparameter $consonants '(#\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z))

(defun consonant? (a-letter)
  (if (member a-letter $consonants)
      t
    nil))

(defun vowel? (a-letter)
  (if (member a-letter $vowels)
      t
    nil))


(defun firsthalf (a-name)
  (subseq a-name 0 
          (truncate (length a-name) 
                    2)))

(defun secondhalf (a-name)
  (subseq a-name  
          (truncate (length a-name) 
                    2)
          (length a-name)))

;;; old make-name that was replaced by the new version below
;;; the new version adds code to break up joins with too many consonants in a row
(defun old-make-name (name-list)
  (let* ((left (any name-list))
         (start (firsthalf left))
         (right (any name-list))
         (end (secondhalf right)))
    (concatenate 'string start end)))

(defun count-start-consonants (a-string)
  (or (position-if 'vowel? a-string)
      (length a-string)))

(defun count-end-consonants (a-string)
  (let ((the-position (position-if 'vowel? a-string :from-end t)))
    (if the-position
        (1- (- (length a-string)
               the-position))
      (length a-string))))

(defparameter $names (readfile $path))

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

(defun old-make-names (name-list count)
  (loop for i from 0 below count
        collect (old-make-name name-list)))

(defun make-names (name-list count)
  (loop for i from 0 below count
        collect (make-name name-list)))

(defun button-selection-callback (the-interface)
  (let* ((the-names-layout (get-names-layout the-interface))
         (new-names (make-names $names 3))
         (name-panes (loop for name in new-names
                           collect (make-instance 'title-pane :text name))))
    (setf (layout-description the-names-layout)
          name-panes)))


(defun choose-count-callback (the-data)
  (display-message "~S" the-data))

(define-interface name-generator-window ()
  ;; slots
  ()
  ;; panes
  (:panes
   (count-menu-button popup-menu-button
                      :text "Count"
                      :menu count-menu)
   (generate-name-button push-button 
                         :text "generate"
                         :data :ignore-this-data
                         :callback-type :interface
                         :selection-callback 'button-selection-callback))
  ;; menus
  (:menus   
   (count-menu
    :menu ; title is ignored  
    ("1" "2" "3" "4" "5")
    :callback 'choose-count-callback
    :callback-type :data)) 
  ;; layouts
  (:layouts
   (input-layout row-layout '(generate-name-button count-menu-button))
   (names-layout column-layout '() :reader get-names-layout)
   (main-layout column-layout '(input-layout names-layout)
                :adjust :center))
  ;; defaults
  (:default-initargs :layout 'main-layout
   :title "Generate names"))

;;; (defparameter $window (contain (make-instance 'name-generator-window)))
