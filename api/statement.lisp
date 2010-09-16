(in-package :oci8)

(defcenum language
  (:v7-syntax 2) ;  v815 language - for backwards compatibility 
  (:v8-syntax 3) ;  v815 language - for backwards compatibility 
  (:ntv-syntax 1) ;  use what so ever is the native lang of server these values must match the values defined in kpul.h 
  )

(defcenum statement-prepare-options
  (:default 0))

(defcfun ("OCIStmtPrepare" statement-prepare%) result
  (stmthp handle)
  (errhp handle)
  (statement :string)
  (statement-len ub4)
  (language language)
  (mode statement-prepare-options))

(defun create-statement (statement
                         &key
                         (error-handle *error*)
                         (language :ntv-syntax)
                         (mode :default)
                         (environment *environment*))
  (let ((statement-handle (make-instance 'common-handle
                                         :handle-type :statement
                                         :parent-handle environment)))
    (statement-prepare% statement-handle
                        error-handle
                        statement (length statement)
                        language mode)
    statement-handle))

(defcenum statement-execute-options
  (:default 0)
  (:batch-mode #x00000001) ;  batch the oci stmt for exec 
  (:exact-fetch #x00000002) ;  fetch exact rows specified 
  (:stmt-scrollable-readonly #x00000008) ;  if result set is scrollable 
  (:describe-only #x00000010) ;  only describe the statement 
  (:commit-on-success #x00000020) ;  commit, if successful exec 
  (:non-blocking #x00000040) ;  non-blocking 
  (:batch-errors #x00000080) ;  batch errors in array dmls 
  (:parse-only #x00000100) ;  only parse the statement 
  (:exact-fetch-reserved-1 #x00000200) ;  reserved 
  (:show-dml-warnings #x00000400) ;  return oci-success-with-info for delete/update w/no where clause 
  (:exec-reserved-2 #x00000800) ;  reserved 
  (:desc-reserved-1 #x00001000) ;  reserved 
  (:exec-reserved-3 #x00002000) ;  reserved 
  (:exec-reserved-4 #x00004000) ;  reserved 
  (:exec-reserved-5 #x00008000) ;  reserved 
  (:exec-reserved-6 #x00010000) ;  reserved 
  (:result-cache #x00020000) ;  hint to use query caching 
  (:no-result-cache #x00040000) ; hint to bypass query caching
  (:exec-reserved-7 #x00080000) ;  reserved 
  )

(defcfun ("OCIStmtExecute" statement-execute%) result
  (svchp handle)
  (stmthp handle)
  (errhp handle)
  (iters ub4)
  (rowoff ub4)
  (snap-in :pointer)
  (snap-out :pointer)
  (mode statement-execute-options))

(defun statement-execute (statement-handle
                          service-context
                          &key
                          (error-handle *error*)
                          (iters 0) (rowoff 0)
                          (snap-in (null-pointer)) (snap-out (null-pointer))
                          (mode :default))
  (statement-execute% service-context statement-handle
                      error-handle
                      iters rowoff
                      snap-in snap-out
                      mode))

(defcenum fetch-modes
  (:default 0))

(defcenum fetch-directions
  (:fetch-current #x00000001) ;  refetching current position  
  (:fetch-next #x00000002) ;  next row 
  (:fetch-first #x00000004) ;  first row of the result set 
  (:fetch-last #x00000008) ;  the last row of the result set 
  (:fetch-prior #x00000010) ;  previous row relative to current 
  (:fetch-absolute #x00000020) ;  absolute offset from first 
  (:fetch-relative #x00000040) ;  offset relative to current 
  )
                           
(defcfun ("OCIStmtFetch" statement-fetch%) result
  (stmthp handle)
  (errhp handle)
  (nrows ub4)
  (orientation fetch-directions)
  (mode fetch-modes))

(defun statement-fetch (statement &key (nrows 1) (orientation :fetch-next) (error-handle *error*) (mode :default))
  (statement-fetch% statement error-handle nrows orientation mode))

