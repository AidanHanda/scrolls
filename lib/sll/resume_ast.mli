open Base

module Resume_header : sig
  type t
  val make : string list -> t
end

module Resume_education_section : sig
  type t
  val empty : unit -> t
  val add_content : t -> string -> t
  val add_name : t -> string -> t
  val commit : t -> t
  val display_name : t -> string
  val get_content : t -> string list list
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

end

type t =
  | Header of Resume_header.t
  | Content_section of Resume_content_section.t
  | Education_section of Resume_education_section.t

val show : t list -> unit
