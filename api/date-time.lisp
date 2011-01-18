(in-package :oci8)

(defcfun ("OCIDateTimeConstruct" dt-construct) result
  (parent handle)
  (err handle)
  (target handle)
  (year sb2)
  (month sb1)
  (day sb1)
  (hour sb1)
  (min sb1)
  (sec sb1)
  (fsec ub4)
  (timezone :pointer)
  (timezone-len size_t))

(defun dt-set-datetime (localtime descriptor &key (environment *environment*) (err *error*))
  (local-time:with-decoded-timestamp (:year year :month month :day day :hour hour :minute min :sec sec :nsec nsec)
      localtime
    (dt-construct environment err descriptor
                  year
                  month
                  day
                  hour
                  min
                  sec nsec (null-pointer) 0))
  descriptor)

(defcfun ("OCIDateTimeGetTime" dt-get-time%) result
  (parent handle)
  (err handle)
  (target handle)
  (hourp (:pointer ub1))
  (minp (:pointer ub1))
  (secp (:pointer ub1))
  (fsecp (:pointer ub4)))

(defcfun ("OCIDateTimeGetDate" dt-get-date%) result
  (parent handle)
  (err handle)
  (target handle)
  (year (:pointer sb2))
  (month (:pointer ub1))
  (day (:pointer ub1)))

(defun dt-to-local-time (dt-handle &key (environment *environment*) (err *error*))
  (with-foreign-objects ((yearp 'sb2)
                         (monthp 'ub1)
                         (dayp 'ub1)
                         (hourp 'ub1)
                         (minp 'ub1)
                         (secp 'ub1)
                         (fsecp 'ub4))
    (dt-get-time% environment err dt-handle hourp minp secp fsecp)
    (dt-get-date% environment err dt-handle yearp monthp dayp)
    (local-time:encode-timestamp
     (mem-aref fsecp 'ub4)
     (mem-aref secp 'ub1)
     (mem-aref minp 'ub1)
     (mem-aref hourp 'ub1)
     (mem-aref dayp 'ub1)
     (mem-aref monthp 'ub1)
     (mem-aref yearp 'sb2))))
