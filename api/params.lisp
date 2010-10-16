(in-package :oci8)

(defcenum common-attr
  (:attr-fncode 1) ;  the oci function code 
  (:attr-object 2) ;  is the environment initialized in object mode 
  (:attr-nonblocking-mode 3) ;  non blocking mode 
  (:attr-sqlcode 4) ;  the sql verb 
  (:attr-env 5) ;  the environment handle 
  (:attr-server 6) ;  the server handle 
  (:attr-session 7) ;  the user session handle 
  (:attr-trans 8) ;  the transaction handle 
  (:attr-row-count 9) ;  the rows processed so far 
  (:attr-sqlfncode 10) ;  the sql verb of the statement 
  (:attr-prefetch-rows 11) ;  sets the number of rows to prefetch 
  (:attr-nested-prefetch-rows 12) ;  the prefetch rows of nested table
  (:attr-prefetch-memory 13) ;  memory limit for rows fetched 
  (:attr-nested-prefetch-memory 14) ;  memory limit for nested rows 
  (:attr-char-count 15) ;  this specifies the bind and define size in characters 
  (:attr-pdscl 16) ;  packed decimal scale 
  (:attr-pdprc 17) ;  packed decimal format 
  (:attr-param-count 18) ;  number of column in the select list 
  (:attr-rowid 19) ;  the rowid 
  (:attr-charset 20) ;  the character set value 
  (:attr-nchar 21) ;  nchar type 
  (:attr-username 22) ;  username attribute 
  (:attr-password 23) ;  password attribute 
  (:attr-stmt-type 24) ;  statement type 
  (:attr-internal-name 25) ;  user friendly global name 
  (:attr-external-name 26) ;  the internal name for global txn 
  (:attr-xid 27) ;  xopen defined global transaction id 
  (:attr-trans-lock 28) ;  
  (:attr-trans-name 29) ;  string to identify a global transaction 
  (:attr-heapalloc 30) ;  memory allocated on the heap 
  (:attr-charset-id 31) ;  character set id 
  (:attr-charset-form 32) ;  character set form 
  (:attr-maxdata-size 33) ;  maximumsize of data on the server  
  (:attr-cache-opt-size 34) ;  object cache optimal size 
  (:attr-cache-max-size 35) ;  object cache maximum size percentage 
  (:attr-pinoption 36) ;  object cache default pin option 
  (:attr-alloc-duration 37) ;  object cache default allocation duration 
  (:attr-pin-duration 38) ;  object cache default pin duration 
  (:attr-fdo 39) ;  format descriptor object attribute 
  (:attr-postprocessing-callback 40) ;  callback to process outbind data 
  (:attr-postprocessing-context 41) ;  callback context to process outbind data 
  (:attr-rows-returned 42) ;  number of rows returned in current iter - for bind handles 
  (:attr-focbk 43) ;  failover callback attribute 
  (:attr-in-v8-mode 44) ;  is the server/service context in v8 mode 
  (:attr-lobempty 45) ;  empty lob ? 
  (:attr-sesslang 46) ;  session language handle 
  (:attr-visibility 47) ;  visibility 
  (:attr-relative-msgid 48) ;  relative message id 
  (:attr-sequence-deviation 49) ;  sequence deviation 
  (:attr-consumer-name 50) ;  consumer name 
  (:attr-deq-mode 51) ;  dequeue mode 
  (:attr-navigation 52) ;  navigation 
  (:attr-wait 53) ;  wait 
  (:attr-deq-msgid 54) ;  dequeue message id 
  (:attr-priority 55) ;  priority 
  (:attr-delay 56) ;  delay 
  (:attr-expiration 57) ;  expiration 
  (:attr-correlation 58) ;  correlation id 
  (:attr-attempts 59) ;  # of attempts 
  (:attr-recipient-list 60) ;  recipient list 
  (:attr-exception-queue 61) ;  exception queue name 
  (:attr-enq-time 62) ;  enqueue time (only ociattrget) 
  (:attr-msg-state 63) ;  message state (only ociattrget) 
  (:attr-agent-name 64) ;  agent name 
  (:attr-agent-address 65) ;  agent address 
  (:attr-agent-protocol 66) ;  agent protocol 
  (:attr-user-property 67) ;  user property 
  (:attr-sender-id 68) ;  sender id 
  (:attr-original-msgid 69) ;  original message id 
  (:attr-queue-name 70) ;  queue name 
  (:attr-nfy-msgid 71) ;  message id 
  (:attr-msg-prop 72) ;  message properties 
  (:attr-num-dml-errors 73) ;  num of errs in array dml 
  (:attr-dml-row-offset 74) ;  row offset in the array 
  (:attr-dateformat 75) ;  default date format string 
  (:attr-buf-addr 76) ;  buffer address 
  (:attr-buf-size 77) ;  buffer size 
  (:attr-data-size 1) ;  maximum size of the data 
  (:attr-data-type 2) ;  the sql type of the column/argument 
  (:attr-disp-size 3) ;  the display size 
  (:attr-name 4) ;  the name of the column/argument 
  (:attr-precision 5) ;  precision if number type 
  (:attr-scale 6) ;  scale if number type 
  (:attr-is-null 7) ;  is it null ? 
  (:attr-type-name 8) ; 
  (:attr-schema-name 9) ;  the schema name 
  (:attr-sub-name 10) ;  type name if package private type 
  (:attr-position 11) ;  relative position of col/arg in the list of cols/args complex object retrieval parameter attributes 
  (:attr-complexobjectcomp-type 50) ;  
  (:attr-complexobjectcomp-type-level 51) ; 
  (:attr-complexobject-level 52) ; 
  (:attr-complexobject-coll-outofline 53) ; 
  (:attr-disp-name 100) ;  the display name 
  (:attr-encc-size 101) ;  encrypted data size 
  (:attr-col-enc 102) ;  column is encrypted ? 
  (:attr-col-enc-salt 103) ;  is encrypted column salted ? 
  (:attr-conn-nowait 178) ; 
  (:attr-conn-busy-count 179) ; 
  (:attr-conn-open-count 180) ; 
  (:attr-conn-timeout 181) ; 
  (:attr-stmt-state 182) ; 
  (:attr-conn-min 183) ; 
  (:attr-conn-max 184) ; 
  (:attr-conn-incr 185) ; 
  (:attr-num-open-stmts 188) ;  open stmts in session 
  (:attr-describe-native 189) ;  get native info via desc 
  (:attr-bind-count 190) ;  number of bind postions 
  (:attr-handle-position 191) ;  pos of bind/define handle 
  (:attr-reserved-5 192) ;  reserverd 
  (:attr-server-busy 193) ;  call in progress on server
  (:attr-subscr-recptpres 195) ; 
  (:attr-transformation 196) ;  aq message transformation 
  (:attr-rows-fetched 197) ;  rows fetched in last call 
  (:attr-overload 210) ;  is this position overloaded 
  (:attr-level 211) ;  level for structured types 
  (:attr-has-default 212) ;  has a default value 
  (:attr-iomode 213) ;  in, out inout 
  (:attr-radix 214) ;  returns a radix 
  (:attr-num-args 215) ;  total number of arguments 
  (:attr-typecode 216) ;  object or collection 
  (:attr-collection-typecode 217) ;  varray or nested table 
  (:attr-version 218) ;  user assigned version 
  (:attr-is-incomplete-type 219) ;  is this an incomplete type 
  (:attr-is-system-type 220) ;  a system type 
  (:attr-is-predefined-type 221) ;  a predefined type 
  (:attr-is-transient-type 222) ;  a transient type 
  (:attr-is-system-generated-type 223) ;  system generated type 
  (:attr-has-nested-table 224) ;  contains nested table attr 
  (:attr-has-lob 225) ;  has a lob attribute 
  (:attr-has-file 226) ;  has a file attribute 
  (:attr-collection-element 227) ;  has a collection attribute 
  (:attr-num-type-attrs 228) ;  number of attribute types 
  (:attr-list-type-attrs 229) ;  list of type attributes 
  (:attr-num-type-methods 230) ;  number of type methods 
  (:attr-list-type-methods 231) ;  list of type methods 
  (:attr-map-method 232) ;  map method of type 
  (:attr-order-method 233) ;  order method of type 
  (:attr-num-elems 234) ;  number of elements 
  (:attr-encapsulation 235) ;  encapsulation level 
  (:attr-is-selfish 236) ;  method selfish 
  (:attr-is-virtual 237) ;  virtual 
  (:attr-is-inline 238) ;  inline 
  (:attr-is-constant 239) ;  constant 
  (:attr-has-result 240) ;  has result 
  (:attr-is-constructor 241) ;  constructor 
  (:attr-is-destructor 242) ;  destructor 
  (:attr-is-operator 243) ;  operator 
  (:attr-is-map 244) ;  a map method 
  (:attr-is-order 245) ;  order method 
  (:attr-is-rnds 246) ;  read no data state method 
  (:attr-is-rnps 247) ;  read no process state 
  (:attr-is-wnds 248) ;  write no data state method 
  (:attr-is-wnps 249) ;  write no process state 
  (:attr-desc-public 250) ;  public object 
  (:attr-cache-client-context 251) ; 
  (:attr-uci-construct 252) ; 
  (:attr-uci-destruct 253) ; 
  (:attr-uci-copy 254) ; 
  (:attr-uci-pickle 255) ; 
  (:attr-uci-unpickle 256) ; 
  (:attr-uci-refresh 257) ; 
  (:attr-is-subtype 258) ; 
  (:attr-supertype-schema-name 259) ; 
  (:attr-supertype-name 260) ; 
  (:attr-list-objects 261) ;  list of objects in schema 
  (:attr-ncharset-id 262) ;  char set id 
  (:attr-list-schemas 263) ;  list of schemas 
  (:attr-max-proc-len 264) ;  max procedure length 
  (:attr-max-column-len 265) ;  max column name length 
  (:attr-cursor-commit-behavior 266) ;  cursor commit behavior 
  (:attr-max-catalog-namelen 267) ;  catalog namelength 
  (:attr-catalog-location 268) ;  catalog location 
  (:attr-savepoint-support 269) ;  savepoint support 
  (:attr-nowait-support 270) ;  nowait support 
  (:attr-autocommit-ddl 271) ;  autocommit ddl 
  (:attr-locking-mode 272) ;  locking mode 
  (:attr-appctx-size 273) ;  count of context to be init
  (:attr-appctx-list 274) ;  count of context to be init
  (:attr-appctx-name 275) ;  name  of context to be init
  (:attr-appctx-attr 276) ;  attr  of context to be init
  (:attr-appctx-value 277) ;  value of context to be init
  (:attr-client-identifier 278) ;  value of client id to set
  (:attr-is-final-type 279) ;  is final type ? 
  (:attr-is-instantiable-type 280) ;  is instantiable type ? 
  (:attr-is-final-method 281) ;  is final method ? 
  (:attr-is-instantiable-method 282) ;  is instantiable method ? 
  (:attr-is-overriding-method 283) ;  is overriding method ? 
  (:attr-desc-synbase 284) ;  describe the base object 
  (:attr-char-used 285) ;  char length semantics 
  (:attr-char-size 286) ;  char length 
  (:attr-is-java-type 287) ;  is java implemented type ? 
  (:attr-distinguished-name 300) ;  use dn as user name 
  (:attr-kerberos-ticket 301) ;  kerberos ticket as cred. 
  (:attr-ora-debug-jdwp 302) ;  ora-debug-jdwp attribute 
  (:attr-edition 288) ;  ora-edition 
  (:attr-reserved-14 303) ;  reserved 
  (:attr-spool-timeout 308) ;  session timeout 
  (:attr-spool-getmode 309) ;  session get mode 
  (:attr-spool-busy-count 310) ;  busy session count 
  (:attr-spool-open-count 311) ;  open session count 
  (:attr-spool-min 312) ;  min session count 
  (:attr-spool-max 313) ;  max session count 
  (:attr-spool-incr 314) ;  session increment count 
  (:attr-spool-stmtcachesize 208) ; stmt cache size of pool  
  (:attr-spool-auth 460) ;  auth handle on pool handle
  )

(defcfun ("OCIAttrGet" attr-get%) result
  (handle handle)
  (htype htype)
  (pointer :pointer)
  (sizep :pointer)
  (attrtype common-attr)
  (errhp handle))

(defun attr-get (handle oci-attrtype attrtype &key (error-handle *error*))
  (with-foreign-objects ((retval attrtype)
                         (countp 'ub4))
    (setf (mem-ref countp 'ub4) 0)
    (attr-get% handle (handle-type handle) retval countp oci-attrtype error-handle)
    (cond
      ((eql :pointer attrtype)
       (values
        (foreign-string-to-lisp (mem-ref retval :pointer) :count (mem-ref countp 'ub4))))
      (t (mem-aref retval attrtype)))))

(defcfun ("OCIAttrSet" attr-set%) result
  (handle handle)
  (htype htype)
  (pointer :pointer)
  (size ub4)
  (attrtype common-attr)
  (errhp handle))

(defun attr-set (handle oci-attrtype attrtype data &key (error-handle *error*))
  (with-foreign-object (var attrtype)
    (setf (mem-ref var attrtype) data)
    (attr-set% handle (handle-type handle) var (foreign-type-size attrtype) oci-attrtype error-handle)))
      
(defcfun ("OCIParamGet" param-get%) result
  (handle handle)
  (handle-type htype)
  (errhp handle)
  (paramptr handle-pointer)
  (index ub4))

(defun param-get (handle index &key (error-handle *error*))
  (let ((param (make-instance 'handle :handle-type :parameter)))
    (param-get% handle (handle-type handle)
                error-handle
                param
                index)
    param))

