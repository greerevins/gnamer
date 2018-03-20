(in-package :namer)

;;; GENERIC FUNCTION any ((seq sequence))
;;; ---------------------------------------------------------------------
;;; returns a randomly-chosen element of SEQ

(defmethod any ((seq sequence))
  (elt seq
       (random (length seq))))



