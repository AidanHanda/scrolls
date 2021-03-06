open Core
open Lexing

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
;;

let parse_with_error lexbuf =
  try Sll.Parser.prog Sll.Lexer.read lexbuf with
  | Sll.Lexer.SyntaxError msg ->
    fprintf stderr "%a: %s\n" print_position lexbuf msg;
    None
  | Sll.Parser.Error ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)
;;

let rec parse_and_print lexbuf =
  match parse_with_error lexbuf with
  | Some v ->
    Sll.Resume_ast.show v;
    parse_and_print lexbuf
  | None -> ()
;;

let loop filename () =
  let inx = In_channel.create filename in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_and_print lexbuf;
  In_channel.close inx
;;

let () =
  Command.basic_spec
    ~summary:"Parse and display Resume"
    Command.Spec.(empty +> anon ("filename" %: string))
    loop
  |> Command.run
;;
