open Base

type t [@@deriving sexp_of]

(** [empty ()] builds an education section that has no content in it. It simply
    instantiates a type that can then be used to iteratively add information to
    the section. *)
val empty : unit -> t

(** [add_content t "some content here"] accepts some metadata information about the education that
    should be displayed in the resume. It adds this to the working copy of the
    type. *)
val add_content : t -> string -> t

(** [add_name t "Education"] names the education section on the resume. The usual parameter
    for this would be "Education" as this will be how it displays on the Resume. *)
val add_name : t -> string -> t

(** [commit t] denotes the end of a chunk of education. Consider if one recieved
    their BS from Georgia Tech as one complete degree and then returned to do
    their MS. These two chunks of education are tracked by commiting BS and then
    adding content for MS. *)
val commit : t -> t
