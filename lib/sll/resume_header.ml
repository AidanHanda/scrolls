open Base

type t = string list [@@deriving sexp_of]

let make s = s
