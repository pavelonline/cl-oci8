(asdf:defsystem :oci8
  :depends-on ("trivial-garbage" "cffi")
  :components
  ((:file "package")
   (:file "handle" :depends-on ("package"))
   (:file "types" :depends-on ("package"))
   (:module "api" :depends-on ("handle" "types")
            :components
            ((:file "main")
             (:file "connection" :depends-on ("main"))
             (:file "statement" :depends-on ("main"))
             (:file "bind-define" :depends-on ("main"))))))
                                 
  
                 