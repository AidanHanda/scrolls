open Base

type t [@@deriving sexp_of]

(** [make] generates a complete resume header when passed in all the resume header data at
    once. This would be things such as name, phone number, address, etc. *)
val make : string list -> t
