(defpackage :oci8
  (:use :cffi :cl))

(in-package :oci8)

(define-foreign-library libclntsh
  (:unix "libclntsh.so"))

(use-foreign-library libclntsh)

(defvar *environment* nil)

(defvar *error* nil)

