;;; -*- Mode: Common-Lisp; Author: greer -*-
;;; added to a git repo

(in-package :cl-user)

(require :asdf)

(asdf:defsystem :namer
  :version "0.2"
  :serial t
  :components
  ((:file "package")
   (:file "read-names")
   (:file "utilities")
   (:file "letters")
   (:file "analyze-names")
   (:file "make-names")
   ;;(:file "namer-ui")
   ))

;;; (asdf:load-system :namer)
