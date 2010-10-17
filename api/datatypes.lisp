(in-package :oci8)

(defgeneric convert-from (sqlt type size index data))

(defmethod convert-from ((sqlt (eql :sqlt-dat)) type size index data)
  (macrolet ((d[] (i)
               `(mem-aref data :char (+ (* index size) ,i))))
    (encode-universal-time
     (1- (d[] 6))
     (1- (d[] 5))
     (1- (d[] 4))
     (d[] 3)
     (d[] 2)
     (+ (* 100 (- (d[] 0) 100))
        (- (d[] 1) 100)))))

(defmethod convert-from ((sqlt (eql :sqlt-str)) type size index data)
  (foreign-string-to-lisp data :offset (* index size) :max-chars size))

(defmethod convert-from ((sqlt (eql :sqlt-int)) type size index data)
  (mem-aref data type index))

(defmethod convert-from ((sqlt (eql :sqlt-flt))
                         type
                         size index data)
  (mem-aref data type index))

(defun crop-string (string size)
  (loop for i = (length string) then (1- i)
     while (< size (length (flexi-streams:string-to-octets string
                                                           :external-format *default-foreign-encoding*
                                                           :end i)))
     while (plusp i)
     finally (return (subseq string 0 i))))


(defgeneric convert-to (sqlt type size data pointer))

(defmethod convert-to ((sqlt (eql :sqlt-int)) type (size null) (data integer) pointer)
  (setf (mem-ref pointer type) data))

(defmethod convert-to ((sqlt (eql :sqlt-str)) type size (data string) pointer)
  (with-foreign-string (tmp-str (crop-string data (1- size)))
    (loop for i from 0 to (1- size)
       for ch = (mem-aref tmp-str :char i)
       do (setf (mem-aref pointer :char i) ch)
       while (not (zerop ch)))))

(defmethod convert-to ((sqlt (eql :sqlt-dat)) type size (data integer) pointer)
  (multiple-value-bind (sec min hour day month year)
      (decode-universal-time data)
    (macrolet (([] (i val)
                 `(setf (mem-aref pointer :char ,i) ,val)))
      ([] 0 (+ 100 (floor year 100)))
      ([] 1 (+ 100 (mod year 100)))
      ([] 2 month)
      ([] 3 day)
      ([] 4 (1+ hour))
      ([] 5 (1+ min))
      ([] 6 (1+ sec)))))
               

