(in-package :namer)

(defparameter $vowels '(#\a #\e #\i #\o #\u))

(defparameter $consonants '(#\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z))

(defun consonant? (a-letter)
  (if (member a-letter $consonants)
      t
    nil))

(defun vowel? (a-letter)
  (if (member a-letter $vowels)
      t
    nil))
