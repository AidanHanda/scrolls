open Base
open Core


module Resume_header : sig
  type t
  val make : string list -> t
end = struct
  type t = string list
  let make s = s
end

module Resume_education_section : sig
  type t
  val empty : unit -> t
  val add_content : t -> string -> t
  val add_name : t -> string -> t
  val commit : t -> t
  val display_name : t -> string
  val get_content : t -> string list list
end = struct
  type t = {
    name : string;
    content: string list;
    all : string list list;
  }

  let commit t =
    {t with all = t.content :: t.all; content = [] }

  let add_name t n =
    {t with name = n}

  let add_content t s =
    {t with content = s :: t.content}

  let get_content t = t.all

  let empty () = {
    name = "";
    content = [];
    all = [];
  }

  let display_name t = t.name

end

module Resume_content_section : sig
  type t
  val empty : unit -> t
  val add_content : t -> string -> t
  val add_bullet : t -> string -> t
  val add_name : t -> string -> t
  val commit : t -> t
  val display_name : t -> string
  val get_content : t -> string list list
  val get_bullets : t -> string list list

end = struct
  type t =  {
    name : string;
    content : string list;
    bullets : string list;
    all_content : string list list;
    all_bullets : string list list;
  }
  let add_name t n =
    {t with name = n}
  let add_content t s =
    { t with content = s :: t.content }
  let add_bullet t s =
    { t with bullets = s :: t.bullets }
  let display_name t = t.name

  let commit t =
    {t with all_content = t.content  :: t.all_content;
            all_bullets = t.bullets :: t.all_bullets;
            content = [];
            bullets = [];
    }

  let get_content t = t.all_content

  let get_bullets t = t.all_bullets

  let empty () = {
    name = "";
    content = [];
    bullets = [];
    all_content = [];
    all_bullets = [];
  }
end

type t =
  | Header of Resume_header.t
  | Content_section of Resume_content_section.t
  | Education_section of Resume_education_section.t


let print_edu es =
  printf "Education Section (%s) of (%d)\n" (Resume_education_section.display_name es) (List.length (Resume_education_section.get_content es))

let print_cs cs =
  printf "Content Section (%s) of (%d)\n" (Resume_content_section.display_name cs) (List.length (Resume_content_section.get_content cs))

let out t =
  match t with
  | Header _ -> printf "Header\n"
  | Education_section e -> print_edu e
  | Content_section c ->  print_cs c

let rec show ts =
  match ts with
  | [] -> ()
  | [one] -> out one
  | s :: rest -> out s; show rest;
