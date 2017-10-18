(in-package :namer)

;;; ---------------------------------------------------------
;;; CLASS name-generator-window
;;; ---------------------------------------------------------

(defun open-button-selection-callback (the-interface)
  (let* ((names-path (prompt-for-file "Choose a names file" 
                                      :pathname (find-gnamer-home-pathname)
                                      :filter "*.names"))
         (the-names (readfile names-path))
         (path-label (path-label the-interface)))
    (setf (names-file the-interface)
          names-path)
    (setf (current-names the-interface)
          the-names)
    (setf (title-pane-text path-label) 
          (pathname-name names-path))
    (setf (sample-names the-interface)
          the-names)))

(defun generate-button-selection-callback (the-interface)
  (let* ((how-many (name-count the-interface))
         (the-names-layout (get-names-layout the-interface))
         (new-names (make-names (sample-names the-interface) how-many))
         (name-panes (loop for name in new-names
                           collect (make-instance 'title-pane :text name))))
    (setf (layout-description the-names-layout)
          name-panes)))

(defun choose-count-callback (the-data the-interface)
  (let* ((how-many (parse-integer the-data))
         (how-many-text (format nil "~a" how-many))
         (the-button (count-menu-button the-interface)))
    (setf (name-count the-interface)
          how-many)
    (setf (item-text the-button)
          how-many-text)))

(define-interface name-generator-window ()
  ;; slots
  ((names-file :accessor names-file :initform nil)
   (current-names :accessor current-names :initform nil)
   (sample-names :accessor sample-names :initform nil)
   (name-count :accessor name-count :initform 1))
  ;; panes
  (:panes
   (open-file-button push-button 
                     :text "Open..."
                     :callback-type :interface
                     :selection-callback 'open-button-selection-callback)
   (path-label title-pane :text "" :accessor path-label)
   (count-menu-button popup-menu-button
                      :text "1"
                      :menu count-menu
                      :accessor count-menu-button)
   (generate-name-button push-button 
                         :text "generate"
                         :data :ignore-this-data
                         :callback-type :interface
                         :selection-callback 'generate-button-selection-callback))
  ;; menus
  (:menus   
   (count-menu
    :menu ; title is ignored  
    ("1" "2" "3" "4" "5")
    :callback 'choose-count-callback
    :callback-type :data-interface)) 
  ;; layouts
  (:layouts
   (files-layout row-layout '(open-file-button path-label))
   (input-layout row-layout '(generate-name-button count-menu-button))
   (names-layout column-layout '() :reader get-names-layout)
   (main-layout column-layout '(files-layout input-layout names-layout)
                :adjust :center))
  ;; defaults
  (:default-initargs :layout 'main-layout
   :title "Generate names"))

;;; (defparameter $window (contain (make-instance 'name-generator-window)))

;;; ---------------------------------------------------------
;;; CLASS names-directory-window
;;; ---------------------------------------------------------

(defun name-file-selection-callback (a-names-directory-window)
  (let* ((a-file-list (get-file-list a-names-directory-window))
         (selected-index (choice-selection a-file-list))
         (files (collection-items a-file-list))
         (selected-file (elt files selected-index))
         (my-name-generator-window (get-name-generator-window a-names-directory-window)))
    (when my-name-generator-window
      (setf (current-names my-name-generator-window)
            (readfile selected-file)))))

(define-interface names-directory-window ()
  ;; slots
  ((the-name-generator-window :accessor get-name-generator-window 
                              :initarg :name-generator-window)
   (names-directory-path :accessor names-directory-path :initform nil :initarg :names-directory-path))
  ;; panes
  (:panes
   (path-title title-pane :text "name files:")
   (path-label title-pane :text (namestring names-directory-path) :accessor path-label)
   (file-list list-panel :items (directory (merge-pathnames "*.names"
                                                            (find-gnamer-home-pathname))) 
              :alternating-background t
              :accessor get-file-list )
   (cancel-button push-button 
                  :text "Cancel")
   (okay-button  push-button 
                  :text "Okay"
                  :selection-callback 'name-file-selection-callback
                  :callback-type :interface))
  ;; layouts
  (:layouts
   (path-layout row-layout '(path-title path-label))
   (buttons-layout row-layout '(cancel-button okay-button))
   (main-layout column-layout '(path-layout file-list buttons-layout)
                :adjust :center))
  ;; defaults
  (:default-initargs :layout 'main-layout
   :title "Name files"
   :name-generator-window nil))

(defun open-name-files-directory-ui (gnamer-home)
  (contain (make-instance 'names-directory-window :names-directory-path gnamer-home)))

;;; (defparameter $window (open-name-files-directory-ui (find-gnamer-home-pathname)))


;;;; Evangeline Walton
;;;; https://www.amazon.com/Mabinogion-Tetralogy-Evangeline-Walton/dp/1585675040
