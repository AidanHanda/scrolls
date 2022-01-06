open Base

type t =
  | Header of Resume_header.t
  | Content_section of Resume_content_section.t
  | Education_section of Resume_education_section.t

val show : t list -> unit
