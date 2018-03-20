(in-package :namer)

;;; ---------------------------------------------------------
;;; CLASS name-generator-window
;;; ---------------------------------------------------------


(defun open-button-selection-callback (the-interface)
  (let ((names-path (prompt-for-file "Choose a names file" 
                                     :pathname (user-homedir-pathname)
                                     :filter "*.names")))
    (if names-path
        ;; they selected something
        (let* ((the-names (readfile names-path))
               (path-label (path-label the-interface)))
          (setf (names-file the-interface)
                names-path)
          (setf (current-names the-interface)
                the-names)
          (setf (title-pane-text path-label) 
                (pathname-name names-path))
          (setf (sample-names the-interface)
                the-names))
      ;; they canceled
      nil)))



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

