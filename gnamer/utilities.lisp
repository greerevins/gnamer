(in-package :namer)


(defun any (a-sequence)
  (elt a-sequence
       (random (length a-sequence))))

(defun ensure-gnamer-home-directory ()
  (let* ((gnamer-home (find-gnamer-home-pathname)))
    (if (probe-file gnamer-home)
        (open-name-files-directory-ui gnamer-home)
      (ensure-directories-exist gnamer-home))))

