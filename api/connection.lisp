(in-package :oci8)

(defvar *session-pool* nil)
(defvar *session-pool-name* nil)

(defcenum session-pool-modes
  (:default 0)
  (:reinitialize #x0001)
  (:homogenous #x0002)
  (:statement-cache #x0004))

(defcfun ("OCISessionPoolCreate" session-pool-create%) result
  (envhp handle)
  (errhp handle)
  (spoolhp handle)
  (poolName (:pointer :string))
  (poolNameLen (:pointer ub4))
  (connStr :string)
  (connStrLen ub4)
  (sessMin ub4)
  (sessMax ub4)
  (sessIncr ub4)
  (userid :string)
  (useridLen ub4)
  (password :string)
  (passwordLen ub4)
  (mode session-pool-modes))

(defun session-pool-create (connstr userid password
                            sessmin sessmax sessp-increment
                            &key
                            (environment *environment*)
                            (error-handle *error*)
                            (mode :homogenous))
  (let ((session-pool-handle (make-instance 'common-handle :handle-type :session-pool :parent-handle environment)))
    (with-foreign-objects ((pool-name '(:pointer :string))
                           (pool-name-len 'sb4))
      (session-pool-create% environment error-handle session-pool-handle
                          pool-name pool-name-len
                          connstr (length connstr)
                          sessmin sessmax sessp-increment
                          userid (length userid)
                          password (length password)
                          mode)
      (values
       session-pool-handle
       (foreign-string-to-lisp (mem-ref pool-name '(:pointer :string)) :max-chars (mem-ref pool-name-len 'sb4))))))


(defcenum spd-options
  (:default #x0000)
  (:oci-spd-force #x0001) ;; force the sessions to terminate. even if there are some busy sessions close them
  )

(defcfun ("OCISessionPoolDestroy" session-pool-destroy%) result
  (spool handle)
  (errhp handle)
  (mode spd-options))

(defun session-pool-destroy (spool &key (mode :default) (error-handle *error*))
  (session-pool-destroy% spool error-handle mode))

(defcenum logon2-options
  (:default #x0000)
  (:session-pool #x0001)
  (:connection-pool #x0200)
  (:statement-cache #x0004)
  (:proxy #x0008))


(defcfun ("OCILogon2" logon2%) result
  (envhp handle)
  (errhp handle)
  (svcctx handle-pointer)
  (username :string)
  (username-len ub4)
  (password :string)
  (password-len ub4)
  (db-name :string)
  (db-name-len ub4)
  (mode logon2-options))

(defun logon2 (&key
               (username "") (password "")
               (db-name *session-pool-name*)
               (mode :session-pool)
               (environment *environment*)
               (error-handle *error*))
  (let ((service-context (make-instance 'common-handle
                                        :handle-type :service-context
                                        :parent-handle environment)))
    (logon2% environment error-handle service-context 
             username (length username)
             password (length password)
             db-name (length db-name)
             mode)
    service-context))
             
(defcfun ("OCILogoff" logoff%) result
  (svchp handle)
  (errhp handle))

(defun logoff (service-context
               &key
               (error-handle *error*))
  (logoff% service-context error-handle))

