(defpackage :oci8
  (:use :cffi :cl)
  (:export :create-statement
           :bind-by-pos
           :pretty-data
           :statement-execute
           )
  (:export :create-environment
           :make-error-handle)
  (:export :session-pool-create
           :logon2
           :logoff)
  (:export :attr-get
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

