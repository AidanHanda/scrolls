open Base

type t [@@deriving sexp_of]

(** [empty ()] creates an empty content section that is ready for information to be added
    to it. This is purely for obtaining a [Resume_content_section.t] variable. *)
val empty : unit -> t

(** [add_content t "some content"] adds some metadata about the job experience in the
    resume. Consider the company name, job title, etc. This is tracked for the running
    chunk that has not been commited yet. *)
val add_content : t -> string -> t

(** [add_bullet t "description"] adds information about the actual experience in a bullet
    format. This is not metadata but actual description of the experience. *)
val add_bullet : t -> string -> t

(** [add_name t "Professional Experience"] adds the name of the section and can be
    customized to anything that would like to be displayed on the actual resume to denote
    the section. *)
val add_name : t -> string -> t

(** Commit ends the chunk that is currently being tracked. Consider having multiple
    professional experienes such as working at a company in New York, one in Atlanta, and
    one in Chicago. Calling commit between adding these experiences will denote that they
    are different and as such independently track bullets and content. *)
val commit : t -> t
