open Core

type t =
  | Header of Resume_header.t
  | Content_section of Resume_content_section.t
  | Education_section of Resume_education_section.t
[@@deriving sexp_of]

let out o = Sexp.pp_hum Caml.Format.std_formatter ([%sexp_of: t] o)

let rec show ts =
  match ts with
  | [] -> ()
  | [ one ] -> out one
  | s :: rest ->
      out s;
      show rest
