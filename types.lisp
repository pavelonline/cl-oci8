(in-package :oci8)

(defgeneric to-ora-type (data))

(defmacro define-foreign-types ((&rest types-and-actuals))
  `(progn
     ,@(mapcar
        (lambda (type-and-actual)
          (destructuring-bind (type actual)
              type-and-actual
            `(defctype ,type ,actual)))
        types-and-actuals)))

(define-foreign-types
     ((sb1 :int8)
      (ub1 :uint8)
      (sb2 :int16)
      (ub2 :uint16)
      (sword :int16)
      (uword :uint16)
      (sb4 :int32)
      (ub4 :uint32)
      (sb8 :int64)
      (size_t :unsigned-long)
      (ub8 :uint64)))


(defgeneric free-ora-resource (data type)
  (:method (data type)
    (foreign-free data))
  (:method (data (type (eql :char)))
    (foreign-string-free data)))

(defmethod to-ora-type ((data integer))
  (values
   (make-instance 'foreign-resource
                  :pointer (foreign-alloc :int64 :initial-element data))
   (foreign-type-size :int64)
   :integer))

(defmethod to-ora-type ((data float))
  (values
   (make-instance 'foreign-resource
                  :pointer (foreign-alloc :double :initial-element data))
   (foreign-type-size :double)
   :float))

(defmethod to-ora-type ((data string))
  (multiple-value-bind (data size)
      (foreign-string-alloc data :null-terminated-p nil)
    (values
     (make-instance 'foreign-resource :pointer data :deallocator #'foreign-string-free)
     size
     :char)))

