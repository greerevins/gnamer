(in-package :namer)

(defun firsthalf (a-name)
  (subseq a-name 0 
          (truncate (length a-name) 
                    2)))

(defun secondhalf (a-name)
  (subseq a-name  
          (truncate (length a-name) 
                    2)
          (length a-name)))

(defun count-start-consonants (a-string)
  (or (position-if 'vowel? a-string)
      (length a-string)))

(defun count-end-consonants (a-string)
  (let ((the-position (position-if 'vowel? a-string :from-end t)))
    (if the-position
        (1- (- (length a-string)
               the-position))
      (length a-string))))
