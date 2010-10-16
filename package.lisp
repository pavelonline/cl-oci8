(defpackage :oci8
  (:use :cffi :cl)
  (:export :no-data)
  (:export :create-statement
           :bind-by-pos
           :define-by-pos
           :pretty-data
           :statement-execute
           :statement-fetch
           )
  (:export :pretty-data)
  (:export :create-environment
           :make-error-handle)
  (:export :getmode-session-pool-values
           :session-pool-create
           :session-pool-destroy
           :logon2
           :logoff)
  (:export :attr-get
           :attr-set
           :param-get)
  (:export :*service-context*
           :*error*
           :*environment*
           :*session-pool*
           :*session-pool-name*
           :*service-context*))

(in-package :oci8)

(define-foreign-library libclntsh
  (:unix "libclntsh.so"))

(use-foreign-library libclntsh)

(defvar *environment* nil)

(defvar *error* nil)

