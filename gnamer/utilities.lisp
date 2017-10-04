(in-package :namer)


(defun any (a-sequence)
  (elt a-sequence
       (random (length a-sequence))))
