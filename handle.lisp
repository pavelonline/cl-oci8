(in-package :oci8)

(defclass handle-base ()
  ((handlpp :reader p-pointer)
   (handle-type
    :initarg :handle-type
    :reader handle-type)))

(defclass handle (handle-base) ())

(defclass parameter (handle-base)
  ()
  (:default-initargs :handle-type :parameter))

(defmethod initialize-instance :after ((handle handle-base) &key &allow-other-keys) ())
  ;; (let ((pointer (slot-value handle 'handlpp)))
  ;;   (tg:finalize handle
  ;;                (lambda ()
  ;;                  (foreign-free pointer)
  ;;                  (format t "Finalized ~a~%" pointer)))))

(defmethod initialize-instance :after ((handle handle) &key &allow-other-keys)
  (let* ((pointer (foreign-alloc :pointer)))
     (setf (slot-value handle 'handlpp) pointer)))

(define-foreign-type handle-type ()
  ()
  (:actual-type :pointer)
  (:simple-parser handle))

(define-foreign-type handle-pointer-type ()
  ()
  (:actual-type :pointer)
  (:simple-parser handle-pointer))

(defmethod translate-to-foreign (handle (type handle-type))
  (mem-ref (p-pointer handle) :pointer))

(defmethod translate-to-foreign (handle (type handle-pointer-type))
  (p-pointer handle))

(defclass environment-handle (handle) ()
  (:default-initargs :handle-type :environment))

(defmethod initialize-instance :after ((self environment-handle) &key &allow-other-keys)
  (env-create self :threaded
              (null-pointer)
              (null-pointer)
              (null-pointer)
              (null-pointer)
              0
              (null-pointer)))

(defvar *environment* nil)

(defvar *error* nil)

(defvar *connection-pool* nil)

(defvar *service-context* nil)

(defvar *session-pool* nil)

(defclass common-handle (handle) ())

(defmethod initialize-instance :after ((handle common-handle) &key (parent-handle *environment*)
                                       &allow-other-keys)
  (let ((type (handle-type handle))
        (pointer-data (mem-ref (p-pointer handle) :pointer)))
    (handle-alloc parent-handle handle type 0 (null-pointer))
    (tg:finalize handle
                 (lambda ()
                   (ignore-errors
                     (handle-free-ptr pointer-data
                                      type))))))

