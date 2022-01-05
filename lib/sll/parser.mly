%{
  [@@@coverage exclude_file]
%}

%token HEADER_SEP
%token CONTENT_SEP
%token <string> CONTENT
%token <string> TITLE
%token <string> BULLET
%token <string> EDUCATION
%token EOF

%start <Resume_ast.t list option> prog

%%
prog:
  | EOF { None }
  | v = resume { Some v }

resume:
  | h = header EOF { [h] }
  | h = header r = resume { h :: r}
  | s = section r = resume { s :: r }
  | EOF { [] }


header:
  | HEADER_SEP c = header_content { Resume_ast.Header (Resume_ast.Resume_header.make c) }

header_content:
  | HEADER_SEP { [] }
  | c = CONTENT hc = header_content { c :: hc }

section:
  | n = TITLE cs = content_section
    { Resume_ast.Content_section
        (Resume_ast.Resume_content_section.add_name
           (Resume_ast.Resume_content_section.commit cs) n
         )
    }
  | n = EDUCATION es = education_section
    { Resume_ast.Education_section
        (Resume_ast.Resume_education_section.add_name
           (Resume_ast.Resume_education_section.commit es) n
        )
    }

content_section:
  | c = CONTENT cs = content_section { Resume_ast.Resume_content_section.add_content cs c }
  | b = BULLET cs = content_section { Resume_ast.Resume_content_section.add_bullet cs b }
  | CONTENT_SEP cs = content_section { Resume_ast.Resume_content_section.commit cs }
  | CONTENT_SEP { Resume_ast.Resume_content_section.empty () }

education_section:
  | c = CONTENT es = education_section { Resume_ast.Resume_education_section.add_content es c }
  | CONTENT_SEP es = education_section { Resume_ast.Resume_education_section.commit es }
  | CONTENT_SEP { Resume_ast.Resume_education_section.empty () }
