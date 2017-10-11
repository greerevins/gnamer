(in-package :namer)


(defun any (a-sequence)
  (elt a-sequence
       (random (length a-sequence))))

(defun find-gnamer-home-pathname ()
  (merge-pathnames "gnamer/" 
                   (user-homedir-pathname)))