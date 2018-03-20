(in-package :namer)

(defmethod any ((seq sequence))
  (elt seq
       (random (length seq))))


