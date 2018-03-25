(in-package :namer)

;;; GENERIC FUNCTION any ((seq sequence))
;;; ---------------------------------------------------------------------
;;; returns a randomly-chosen element of SEQ

(defmethod any ((seq sequence))
  (elt seq
       (random (length seq))))

;;; GENERIC FUNCTION lines (path)
;;; ---------------------------------------------------------------------
;;; reads the contents of the file at PATH line-by-line, returning
;;; a list of the resulting lines

(defmethod lines ((path pathname))
  (with-open-file (in path)
    (loop for line = (read-line in nil nil nil)
       then (read-line in nil nil nil)
       while line
       collect line)))

(defmethod lines ((path string))
  (lines (pathname path)))

;;; GENERIC FUNCTION characters (path)
;;; ---------------------------------------------------------------------
;;; copies the contents of the file at PATH into a string and returns
;;; the string

(defmethod characters ((path pathname))
  (with-open-file (in path)
    (let* ((char-count (file-length in))
           (buffer (make-array char-count :element-type 'character :initial-element #\null)))
      (read-sequence buffer in)
      buffer)))

(defmethod characters ((path string))
  (characters (pathname path)))

