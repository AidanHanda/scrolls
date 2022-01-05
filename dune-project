(lang dune 2.0)

(name scrolls)





(license ISC)

(authors
  "aidanhanda")

(maintainers
  "aidanhanda")

(generate_opam_files true)

(package
 (name scrolls)
 (synopsis "Content reigns supreme!")
 (description "Content reigns supreme!")
 (depends
  (ocaml (>= 4.08.0))
  dune
  (odoc :with-doc)))
(using menhir 2.0)
