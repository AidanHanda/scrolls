{
open Lexing
open Parser

exception SyntaxError of string

let show_it lexbuf =
  Printf.printf "BOL: %d | CNUM: %d | LNUM: %d | FNAME: %s\n" lexbuf.lex_curr_p.pos_bol lexbuf.lex_curr_p.pos_cnum lexbuf.lex_curr_p.pos_lnum lexbuf.lex_curr_p.pos_fname

let illegal lexbuf =
  raise (SyntaxError (Printf.sprintf "At offset %d: unexpected character (%s).\n" (Lexing.lexeme_start lexbuf) (Lexing.lexeme lexbuf)))

  let sanitize s =
    let r = Str.regexp "[\n\t ]+" in
  let cleaned = Str.global_replace r " " s in
  String.trim cleaned
}


let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let colon = (whitespace)?':'(whitespace)?
let star = (whitespace)?'*'(whitespace)?
let bullet = (whitespace)?'-'(whitespace)?
let caret = (whitespace)?'>'(whitespace)?
let content_sep = (whitespace)?'='(whitespace)?(newline)
let no_special = (newline)+(whitespace)?([^'~' ':' '=' '*' '-' '>'] # [' ' '\t'])
let header_sep = (whitespace)?"~"(whitespace)?(newline)

rule read = parse
  | eof { EOF }
  | colon { let c = (read_line "" lexbuf) in CONTENT c}
  | star { let c = (read_line "" lexbuf) in TITLE c}
  | bullet { let c = (read_line "" lexbuf) in BULLET c}
  | caret { let c = (read_line "" lexbuf) in EDUCATION c}
  | content_sep {new_line lexbuf; CONTENT_SEP}
  | whitespace { read lexbuf }
  | newline { read lexbuf }
  | header_sep {new_line lexbuf; HEADER_SEP}
  | _ { illegal lexbuf }
and read_line prev = parse
  | ([^ '\n' '\r'])* { read_line (prev ^ (Lexing.lexeme lexbuf)) lexbuf }
  | no_special { new_line lexbuf; read_line (prev ^ Lexing.lexeme lexbuf) lexbuf }
  | _ { sanitize prev }
