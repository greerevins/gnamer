(in-package :namer)


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

(defun make-names (name-list count)
  (loop for i from 0 below count
        collect (make-name name-list)))
