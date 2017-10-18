(in-package :namer)

(defun readfile (the-path)
  (with-open-file (in the-path)
    (loop for line = (read-line in nil nil nil)
        then (read-line in nil nil nil)
        while line
        collect line)))

(defun any (a-sequence)
  (elt a-sequence
       (random (length a-sequence))))


