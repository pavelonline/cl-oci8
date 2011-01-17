(asdf:defsystem :oci8
  :depends-on ("trivial-garbage" "cffi" "flexi-streams" "local-time")
  :components
  ((:file "package")
   (:file "handle" :depends-on ("package"))
   (:file "types" :depends-on ("package"))
   (:module "api" :depends-on ("handle" "types")
            :components
            ((:file "main")
             (:file "connection" :depends-on ("main"))
             (:file "statement" :depends-on ("main"))
             (:file "bind-define" :depends-on ("main" "datatypes" "date-time"))
             (:file "date-time" :depends-on ("main"))
             (:file "datatypes" :depends-on ("main"))
             (:file "params" :depends-on ("main"))))))
                                 
  
                 