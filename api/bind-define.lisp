(in-package :oci8)

(defcenum bind-define-options
  (:sb2-ind-ptr #x00000001) ;  unused 
  (:data-at-exec #x00000002) ;  data at execute time 
  (:dynamic-fetch #x00000002) ;  fetch dynamically 
  (:piecewise #x00000004) ;  piecewise dmls or fetch 
  (:define-reserved-1 #x00000008) ;  reserved 
  (:bind-reserved-2 #x00000010) ;  reserved 
  (:define-reserved-2 #x00000020) ;  reserved 
  (:bind-soft #x00000040) ;  soft bind or define 
  (:define-soft #x00000080) ;  soft bind or define 
  (:bind-reserved-3 #x00000100) ;  reserved 
  (:iov #x00000200) ;  for scatter gather bind/define 
  (:default #x00000000) ;  
  )

(defcenum sqlt
  (:sqlt-chr 1) ;  (oranet type) character string 
  (:sqlt-num 2) ;  (oranet type) oracle numeric 
  (:sqlt-int 3) ;  (oranet type) integer 
  (:sqlt-flt 4) ;  (oranet type) floating point number 
  (:sqlt-str 5) ;  zero terminated string 
  (:sqlt-vnu 6) ;  num with preceding length byte 
  (:sqlt-pdn 7) ;  (oranet type) packed decimal numeric 
  (:sqlt-lng 8) ;  long 
  (:sqlt-vcs 9) ;  variable character string 
  (:sqlt-non 10) ;  null/empty pcc descriptor entry 
  (:sqlt-rid 11) ;  rowid 
  (:sqlt-dat 12) ;  date in oracle format 
  (:sqlt-vbi 15) ;  binary in vcs format 
  (:sqlt-bfloat 21) ;  native binary float
  (:sqlt-bdouble 22) ;  native binary double 
  (:sqlt-bin 23) ;  binary data(dtybin) 
  (:sqlt-lbi 24) ;  long binary 
  (:sqlt-uin 68) ;  unsigned integer 
  (:sqlt-sls 91) ;  display sign leading separate 
  (:sqlt-lvc 94) ;  longer longs (char) 
  (:sqlt-lvb 95) ;  longer long binary 
  (:sqlt-afc 96) ;  ansi fixed char 
  (:sqlt-avc 97) ;  ansi var char 
  (:sqlt-ibfloat 100) ;  binary float canonical 
  (:sqlt-ibdouble 101) ;  binary double canonical 
  (:sqlt-cur 102) ;  cursor  type 
  (:sqlt-rdd 104) ;  rowid descriptor 
  (:sqlt-lab 105) ;  label type 
  (:sqlt-osl 106) ;  oslabel type 
  (:sqlt-nty 108) ;  named object type 
  (:sqlt-ref 110) ;  ref type 
  (:sqlt-clob 112) ;  character lob 
  (:sqlt-blob 113) ;  binary lob 
  (:sqlt-bfilee 114) ;  binary file lob 
  (:sqlt-cfilee 115) ;  character file lob 
  (:sqlt-rset 116) ;  result set type 
  (:sqlt-nco 122) ;  named collection type (varray or nested table) 
  (:sqlt-vst 155) ;  ocistring type 
  (:sqlt-odt 156) ;  ocidate type 
  (:sqlt-date 184) ;  ansi date 
  (:sqlt-time 185) ;  time 
  (:sqlt-time-tz 186) ;  time with time zone 
  (:sqlt-timestamp 187) ;  timestamp 
  (:sqlt-timestamp-tz 188) ;  timestamp with time zone 
  (:sqlt-interval-ym 189) ;  interval year to month 
  (:sqlt-interval-ds 190) ;  interval day to second 
  (:sqlt-timestamp-ltz 232) ;  timestamp with local tz 
  (:sqlt-pnty 241) ;  pl/sql representation of named types 
  )

(defcenum typecodes
  (:typecode-ref 110) ;  sql/ots object reference 
  (:typecode-date 12) ;  sql date  ots date 
  (:typecode-signed8 27) ;  sql signed integer(8)  ots sint8 
  (:typecode-signed16 28) ;  sql signed integer(16)  ots sint16 
  (:typecode-signed32 29) ;  sql signed integer(32)  ots sint32 
  (:typecode-real 21) ;  sql real  ots sql-real 
  (:typecode-double 22) ;  sql double precision  ots sql-double 
  (:typecode-bfloat 100) ;  binary float  
  (:typecode-bdouble 101) ;  binary double 
  (:typecode-float 4) ;  sql float(p)  ots float(p) 
  (:typecode-number 2) ;  sql number(p s)  ots number(p s) 
  (:typecode-decimal 7) ;  sql decimal(p s)  ots decimal(p s) 
  (:typecode-unsigned8 23) ;  sql unsigned integer(8)  ots uint8 
  (:typecode-unsigned16 25) ;  sql unsigned integer(16)  ots uint16 
  (:typecode-unsigned32 26) ;  sql unsigned integer(32)  ots uint32 
  (:typecode-octet 245) ;  sql ???  ots octet 
  (:typecode-smallint 246) ;  sql smallint  ots smallint 
  (:typecode-integer 3) ;  sql integer  ots integer 
  (:typecode-raw 95) ;  sql raw(n)  ots raw(n) 
  (:typecode-ptr 32) ;  sql pointer  ots pointer 
  (:typecode-varchar2 9) ;  sql varchar2(n)  ots sql-varchar2(n) 
  (:typecode-char 96) ;  sql char(n)  ots sql-char(n) 
  (:typecode-varchar 1) ;  sql varchar(n)  ots sql-varchar(n) 
  (:typecode-mlslabel 105) ;  ots mlslabel 
  (:typecode-varray 247) ;  sql varray  ots paged varray 
  (:typecode-table 248) ;  sql table  ots multiset 
  (:typecode-object 108) ;  sql/ots named object type 
  (:typecode-opaque 58) ;   sql/ots opaque types 
  (:typecode-namedcollection 122) ; 
  (:typecode-blob 112) ;  sql/ots binary large object 
  (:typecode-bfile 114) ;  sql/ots binary file object 
  (:typecode-clob 113) ;  sql/ots character large object 
  (:typecode-cfile 115) ;  sql/ots character file object 
  (:typecode-time 185) ;  sql/ots time 
  (:typecode-time-tz 186) ;  sql/ots time-tz 
  (:typecode-timestamp 187) ;  sql/ots timestamp 
  (:typecode-timestamp-tz 188) ;  sql/ots timestamp-tz 
  (:typecode-timestamp-ltz 232) ;  timestamp-ltz 
  (:typecode-interval-ym 189) ;  sql/ots intrvl yr-mon 
  (:typecode-interval-ds 190) ;  sql/ots intrvl day-sec 
  (:typecode-urowid 104) ;  urowid type 
  (:typecode-otmfirst 228) ;  first open type manager typecode 
  (:typecode-otmlast 320) ;  last otm typecode 
  (:typecode-sysfirst 228) ;  first otm system type (internal) 
  (:typecode-syslast 235) ;  last otm system type (internal) 
  (:typecode-pls-integer 266) ;  type code for pls-integer 
  (:typecode-itable 255) ;  !!!todo!!plsql indexed table 
  (:typecode-nchar 286) ; 
  (:typecode-nvarchar2 287) ; 
  (:typecode-nclob 288) ; 
  (:typecode-none 0) ; 
  (:typecode-errhp 283) ; 
  )

(defcfun ("OCIDefineByPos" define-by-pos%) result
  (stmthp handle)
  (defnpp handle-pointer)
  (errhp handle)
  (position ub4)
  (valuep :pointer)
  (valuesz sb4)
  (dty sqlt)
  (indp :pointer)
  (rlenp :pointer)
  (rcodep :pointer)
  (mode bind-define-options))

(defcenum (ind sb2)
  (:ind-notnull 0) ;  not null 
  (:ind-null -1) ;  null 
  (:ind-badnull -2) ;  bad null 
  (:ind-notnullable -3) ;  not nullable 
  )

(defclass defined-resource ()
  ((datap :reader datap)
   (indp :reader indp)
   (type :initarg :type
         :reader data-type
         :initform (error "Type required"))
   (size :initarg :size
         :reader size)
   (count :initarg :count
          :reader elt-count
          :initform 1)
   (sqlt :initarg :sqlt
         :reader sqlt)
   (rcodep :reader rcodep)
   (rlenp :reader rlenp)))

(defgeneric rcode (res &optional index)
  (:method ((res defined-resource) &optional index)
    (mem-aref (rcodep res) 'ub2 index)))

(defgeneric rlen (res &optional index)
  (:method ((res defined-resource) &optional index)
    (mem-aref (rlenp res) 'ub2 index)))

(defgeneric ind (res &optional index)
  (:method ((res defined-resource) &optional (index 0))
    (mem-ref (indp res) 'ind index)))

(defgeneric data (res &optional index)
  (:method ((res defined-resource) &optional (index 0))
    (mem-ref (datap res) 'ub2 index)))

(defgeneric pretty-data (res &optional index)
  (:method ((res defined-resource) &optional (index 0))
    (unless (eql (ind res index) :ind-null)
      (convert-from (sqlt res) (data-type res) (size res) index (datap res)))))

(defsetf pretty-data (res) (data)
  `(if ,data
       (progn
         (setf (mem-ref (indp ,res) 'ind) :ind-notnull)
         (convert-to (sqlt ,res) (data-type ,res) (size ,res) ,data (datap ,res)))
       (setf (mem-ref (indp ,res) 'ind) :ind-null)))

(defmethod initialize-instance :after ((self defined-resource)
                                       &key
                                       &allow-other-keys)
  (let ((data-ptr (foreign-alloc (data-type self)
                                 :count
                                 (*
                                  (or (size self)
                                      (foreign-type-size (data-type self)))
                                  (elt-count self))))
        (ind-ptr (foreign-alloc 'ind :count (elt-count self)))
        (rcodep (foreign-alloc 'ub2 :count (elt-count self)))
        (rlenp (foreign-alloc 'ub2 :count (elt-count self))))
    (loop for i from 0 to (1- (elt-count self))
         do
         (setf (mem-ref ind-ptr 'ind i) :ind-notnull))
    (setf (slot-value self 'datap)
          data-ptr)
    (setf (slot-value self 'indp)
          ind-ptr)
    (setf (slot-value self 'rcodep)
          rcodep)
    (setf (slot-value self 'rlenp)
          rlenp)
    (tg:finalize self (lambda ()
                        (foreign-free data-ptr)
                        (foreign-free ind-ptr)
                        (foreign-free rcodep)
                        (foreign-free rlenp)))))

(defun define-by-pos (stmthp position type sqlt &key (count 1) (mode :default) size (error-handle *error*))
  (let ((defnpp (make-instance 'handle :handle-type :define)))
    (let ((def-res (make-instance 'defined-resource :count count :size size :type type :sqlt sqlt)))
      (define-by-pos% stmthp defnpp error-handle
                      position
                      (datap def-res)
                      (or
                       size
                       (foreign-type-size type))
                      sqlt
                      (indp def-res)
                      (rcodep def-res)
                      (rlenp def-res)
                      mode)
      def-res)))

(defcfun ("OCIBindByPos" bind-by-pos%) result
  (stmthp handle)
  (bindpp handle-pointer)
  (errhp handle)
  (position ub4)
  (valuep :pointer)
  (valuesz sb4)
  (dty sqlt)
  (indp :pointer)
  (alenp :pointer)
  (rcodep :pointer)
  (maxarr_len ub4)
  (curelep :pointer)
  (mode bind-define-options))

(defun bind-by-pos (stmthp position type sqlt
                    &key
                    (count 1)
                    size
                    (mode :default)
                    (error-handle *error*))
  (let ((resource (make-instance 'defined-resource
                                 :count count
                                 :size size
                                 :sqlt sqlt
                                 :type type))
        (bindhpp (make-instance 'handle :handle-type :bind)))
    (bind-by-pos% stmthp bindhpp error-handle position 
                  (datap resource)
                  (or
                   (size resource)
                   (foreign-type-size type))
                  sqlt
                  (indp resource)
                  (null-pointer) ;; (rlenp resource)
                  (null-pointer) ;; (rcodep resource)
                  0
                  (null-pointer)
                  mode)
    resource))
