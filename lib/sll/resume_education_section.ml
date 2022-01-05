open Base

type t = { name : string; content : string list; all : string list list }
[@@deriving sexp_of, equal]

let commit t = { t with all = t.content :: t.all; content = [] }

let add_name t n = { t with name = n }

let add_content t s = { t with content = s :: t.content }

let empty () = { name = ""; content = []; all = [] }
