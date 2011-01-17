(in-package :oci8)

;; OCI result handling

(defcenum oci-result
  (:success 0)
  (:success-with-info 1)
  (:reserved-for-int-use 200)
  (:no-data 100)
  (:error -1)
  (:invalid-handle -2)
  (:need-data 99)
  (:still-executing -3123))

(defcenum htype
  (:environment 1)
  (:error 2)
  (:service-context 3)
  (:statement 4)
  (:bind 5)
  (:define 6)
  (:describe 7)
  (:server 8)
  (:session 9)
  (:transaction 10)
  (:complexobject 11)
  (:security 12)
  (:subscription 13)
  (:connection-pool 26)
  (:session-pool 27)
  (:parameter 53))


(defcenum dtype
  (:timestamp 68))


(define-foreign-type result-type ()
  ()
  (:actual-type sword)
  (:simple-parser result))

(defcfun ("OCIErrorGet" error-get%) sword
  (errhp handle)
  (seekno ub4)
  (sqlstate :pointer)
  (errcodep (:pointer sb4))
  (bufp :string)
  (bufsz ub4)
  (type htype))

(defun error-get (handle type)
  (with-foreign-pointer-as-string (errbuf 1024)
    (with-foreign-object (errcode 'sb4)
      (error-get% handle 1 (null-pointer)
                  errcode
                  errbuf
                  1024
                  type)
      (foreign-string-to-lisp errbuf :max-chars (1- 1024)))))


(define-condition oci-error (error)
  (($code :initarg :result :reader result))
  (:report (lambda (c stream)
             (format stream "oci returned error ~A"
                     (or (when (and *error*
                                    (eql (result c) :error))
                           (error-get *error* :error))
                         (result c))))))

(define-condition no-data (oci-error)
  ()
  (:default-initargs :result :no-data))

(defmethod translate-from-foreign (value (type result-type))
  (let ((kwd-code (foreign-enum-keyword 'oci-result value)))
    (case kwd-code
      (:success
       :success)
      (:no-data
       (error 'no-data))
      (t
       (error 'oci-error :result (foreign-enum-keyword 'oci-result value))))))

(defcfun ("OCIHandleFree" handle-free-ptr) result
  (hndl :pointer)
  (type htype))

(defcfun ("OCIHandleAlloc" handle-alloc) result
    (parent handle)
    (target handle-pointer)
    (type htype)
    (xtramem_sz size_t)
    (usrmempp :pointer))

(defcfun ("OCIDescriptorAlloc" descriptor-alloc) result
  (parent handle)
  (target handle-pointer)
  (type dtype)
  (xtramem_sz size_t)
  (usrmempp :pointer))

(defcfun ("OCIDescriptorFree" descriptor-free-ptr) result
  (target :pointer)
  (type dtype))

(defcenum env-create-options
  (:threaded #x00000001) ;  appl. in threaded environment 
  (:object #x00000002) ;  application in object environment 
  (:events #x00000004) ;  application is enabled for events 
  (:reserved1 #x00000008) ;  reserved 
  (:shared #x00000010) ;  the application is in shared mode 
  (:reserved2 #x00000020) ;  reserved 
  (:no-ucb #x00000040) ;  no user callback called during ini 
  (:no-mutex #x00000080) ;  the environment handle will not be protected by a mutex internally 
  (:shared-ext #x00000100) ;  used for shared forms 
  )

(defcfun ("OCIEnvCreate" env-create) result
  (envhpp handle-pointer)
  (mode env-create-options)
  (ctxp :pointer)
  (malocfp :pointer)
  (ralocfp :pointer)
  (mfreefp :pointer)
  (xtramemsz size_t)
  (usermempp :pointer))

(defun create-environment ()
  (make-instance 'environment-handle))

(defun make-error-handle ()
  (make-instance 'common-handle :handle-type :error))
