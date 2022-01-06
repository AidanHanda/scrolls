open Base

type t =
  { name : string
  ; content : string list
  ; bullets : string list
  ; all_content : string list list
  ; all_bullets : string list list
  }
[@@deriving sexp_of]

let add_name t n = { t with name = n }
let add_content t s = { t with content = s :: t.content }
let add_bullet t s = { t with bullets = s :: t.bullets }

let commit t =
  { t with
    all_content = t.content :: t.all_content
  ; all_bullets = t.bullets :: t.all_bullets
  ; content = []
  ; bullets = []
  }
;;

let empty () =
  { name = ""; content = []; bullets = []; all_content = []; all_bullets = [] }
;;
