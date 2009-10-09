--  Files YYPARSE.ADB, YYLEX.ADB, are automatically generated from this file.

-------------------------------------------------
--  (s): "standard" Pascal, general feature    --
--  (B): Borland Pascal and compatibles only   --
--  (C): CodeWarrior Pascal only               --
--  (F): FreePascal only                       --
--  (I): ISO Extended Pascal only              --
--  (PO): Pascal Object only                   --
-------------------------------------------------

-- 18-Aug-2008 [GdM]
-- Adapted to ayacc/aflex with "syntax error _at line ..._": added with/use Pascal_IO

--  7-Jan-2007 [GdM]
-- (B) TRY ... FINALLY ... END translated

-- 15-Nov-2006 [GdM]
-- (F) external clause: linker name (see link_name_directive)
-- (F) variables with initialization (see assign_part)

-- 17-June-2006 [PP]
-- (B) add p2ada with list also in interface part
-- (C) add comma separator for record aggregate
-- (s) extra brackets when adding attributes are suppressed
-- (B) add newline when tranlating @ operator to avoid too long line

-- 18-May-2006 [PP]
-- (s) translate operator set "in" by "and", the overloading of proper "and" body is let to user
--     example :
--     type TChar is array (Character) of Boolean;
--     function "and" (Item : Character; Of_Set : TChar) return Boolean is
--     begin
--     return Of_Set(Item);
--     end;
-- (s) when translating readln(f); and writeln(f); additionnal put or get are suppressed

-- 14-May-2006 [PP]
-- (PO) Take advantage of Ada 2005 object.methode notation (with gnat add -gnat05 switch)

-- 31-Dec-2003 [PP]
-- (PO-B) Added constructor, destructor, virtual, private, public, protected tokens
-- (PO-C) Added inherited, override tokens

-- 28-Dec-2003 / 20-Dec-2003 / 01-Oct-2003 [PP - GdM]
-- (PO) Added Pascal Object syntax, methods, inheritance, ...
--      To do: 1/ Add methods as fields (see MethProc, MethFunc)
--             2/ non-prefixed translation of methods
--             3/ nicer "with self"

-- 14-Dec-2003 [GdM]
-- (B) modified assignment_statement to accept also prefixed procedure
--     calls (unit.proc, variable.proc) -> (65/77)
--     NB: simple_procedure_call & pointed_procedure_call become
--     superfluous, but kept because of a nicer ';' placement...

--  9-Nov-2003 [CC - GdM]
-- (s) removed empty choice (wrong!) in
--     any_declaration (104/78) -> (74/71)
--     and any_heading_declaration (74/71) -> (64/67)

-- 27-Apr-2003 [GdM - PP]
-- (s) MOD translated by MOD (ISO Pascal) or REM (Think Pascal)

-- 11-Feb-2003 [GdM]
-- (s) Bug for a..b as inner type denoter (e.g. record field) fixed:
--     inner_type_denoter has an identifier_dot_dot_expression choice,
--     like type_denoter.
-- (s) Better treatemnt of "reserved words" that are used as identifiers.
--     (see Put_masked_keyword).
-- (s) NEW with discriminants

-- 3,4..9-Feb-2003 [GdM]
-- (B) Accepts special array mem[a:b].
-- (s) When "alternative" bracketing used [a][b] <-> [a,b], corrects or
--     issues a comment to correct it.
-- (s) Read and Write to a file correctly translated (if file type defined).
-- (s) Typing of functions
-- (s) Identifier recording for enumerated types and constants to
--     avoid wrong name aliasing

-- 30-Jan-2003 [GdM]
-- (B) Alternative and directly working translation for SHL/SHR

-- 29-Jan-2003 [GdM]
-- (B) Removal of EXIT_t (-> into identifier table)

-- 28-Jan-2003 [GdM]
-- (s) Selectors followed on several levels, Adaliasing disabled
--     when record field selected (identifier could be taken as a visible
--     one of the same name!)

-- 27-Jan-2003 [GdM]
-- (s) Fixed: record fields can be empty.
-- (B) Tag field can be several fields (case a,b of 1:...) !
-- (s) Removal of CHR_t, ORD_t, EOF_t, EOLN_t, SQR_t, ODD_t
--      (-> into identifier table) (92/74)

-- 25-Jan-2003 [GdM]
-- (s) Correct translation of unmasked predefined Pascal
--     identifiers (incl. Borland/Delphi ones) when it has
--     another Ada name.
--     Removal of CHAR_t, REAL_t, DOUBLE_t
--       PARAMSTR_t, PARAMCOUNT_t, UPCASE_t, TRUE_t, FALSE_t, NIL_t
--     (99/86) <- (135/107)
-- (s/B) File [of a_type] correctly translated

-- 23,24-Jan-2003 [GdM]
-- (s) Partial identifier type recognition (aim: translate WITH and NEW)
-- (s) ".." was missing in case_constant
-- (s) [] -> (others=> False)
-- (s) no ad-hoc type for variable of an anonymous array type (Ada accepts it)

-- 21-Jan-2003 [GdM]
-- (s) Write([Boolean]) supported

-- 19,20-Jan-2003 [GdM]
-- (B) Str(123.0:3:5,s) supported
-- (s) fixed bug introduced 18-Dec-2002 along "type T is NEW T2":
--     type_denoter handles directly a subrange_type ("[type T=] m .. *")
--     with an identifier as left part
-- (B) case_constant: "constant" relaxed to "expression",
--     effect on both "case" statements and variant records
-- (s) fixed a bug (1997) for optional ';' in variant parts of records.
-- (s) translation of variants improved
--     (one just needs a cut-and-paste on variant selector)

-- 14-Jan-2003 [GdM]
-- (B) "var X: T absolute Y" translated by "X: T renames Y"
-- (s) a bit better translation of "X in Y"

-- 13-Jan-2003 [GdM]
-- (s) ordinal_type fixed ("array[a..b]" works again, bug introduced 9-Jan-2003)
-- (I) Extended Pascal ISO 10206:1990: and_then, or_else translated
-- (s) set_type now translates correcty to "array( ordinal_type ) of Boolean"
-- (B) 'assembler_compound_statement' and 'junk_asm' removed - support by BP2P

-- 2,7,8,9-Jan-2003 [GdM]
-- * str can be an identifier
-- * clauses with EXTERNAL
-- * ParamCount, ParamStr, UpCase translated by Argument_Count,
--    Argument, To_Upper
-- * bounds for subrange_type: constant relaxed to expression.
-- * Inc(x[,y]), Dec(x[,y]) translated
-- * Adds "range" to type definitions (type T is RANGE a .. b;)

-- 28-Dec-2002 [GdM]
-- * Support for passing options (CW Pascal): procedure P(x: univ integer);
-- * Translation of "EXTERNAL" (import) and export directives
-- * WITH improved

-- 21-Dec-2002 [GdM]
-- * A[i,j] translated by A(i,j) (commas were missing!)
-- * Support for Sqr, Odd, Eof, Eoln and type Double

-- 20-Dec-2002 [GdM]
-- * Turbo Pascal 7's CONST parameters translated
-- * Warning on translation of "Exit" that is a (maskable) procedure
--    in Turbo Pascal!
-- * Set expressions better translated (in form of array of Boolean).

-- 18-Dec-2002 [GdM]
-- * a procedure Dispose is created for each access type
-- * "type a=b" correctly translated by "type a is NEW b"

-- 17-Dec-2002 [GdM]
-- * For variables of a structured type, P2Ada creates
--    an ad-hoc type for them (a complete solution would
--    create a translation for structures of structures, too)
-- * Option to translate a "var" parameter (wrongly)
--    by "var" instead of "in out". See P2Ada_Options.
-- * New(pointer) is translated by pointer:= new ...

-- 15-Dec-2002 [GdM]
-- * Zero parameters for Writeln fixed.
-- * Support for Read, ReadLn, Ord, Chr
-- * Useless (and harmful in case of name conflict) extra
--   "declare..begin..end" removed in functions.
-- * Nested functions correclty translated.
-- * Name of procedures and functions put after "end".

-- 13-Dec-2002 [GdM]
--   Downto -> reverse bug fixed (interval must be reversed)
--   Treatement of empty statement sequences in fat_statement_part

-- 1-Dec-2002 [GdM]
--   Treatement of empty statement sequences

-------------------------------------------------------------------------------
--  30-November-2002 [GACC]
--
--  Problems Fixed:
--
--  * A file not containing both an interface part and and implementation
--     part, is accepted.
--  * Spaces added around all ".."s.
--  * 'statement_sequence_fat' appears. It reduces the trailing "null;" for
--     code: between BEGIN & END, between REPEAT & UNTIL.
--     The "Null;" was changed to "null;".
--  * A bug with appearance of goto labels was fixed.
--  * A general name with a value can now be a record field component that
--     itself is a component of an array or a call to function. I.e. A general
--     name (i.e. variable_access) can be: name "." name. E.g. A[2].B(3) := 1.
--  * A multiplied 'factor' can now be a general name.
--  * A space was removed before "ARRAY" & the "LOOP" of a WHILE loop and a
--     FOR loop.
--  * The variable naming the return value of a function, had an "_" added
--     to it.
--  * A space after "FUNCTION" & GOTO & EXIT WHEN & WHILE & FOR & labels,
--     was removed
--  * The buffer size in "PATEMFIL.ADB" was increased from 300 to 3000. That
--     allows parsing of larger "IF .. THEN ... ELSE IF ..." regions.
--  * File PASCAL.L was altered to allow "**" in comments: "(* ... ** ... *)".
--  * Multiple USES clauses now possible (facilitates using "Pascal" as an
--     intermediate language)
--
--  Notes: (1) NewP2Ada processed output from Mod2P (a Modula to Pascal
--   converter from  http://cs.ru.ac.za/homes/cspt/ ). (2) Prettifying was
--   done using code cut from Adagide. Parsers alternatives might be Adagoop,
--    ASF+SDF. This parser ports code well. Some defects that remain are:
--    (a) Newp2ada can't handle dots in calls to procedures but it can handle
--        dotted names in functions. E.g. (Pascal code)
--           DCGBopt : record
--                TraceLevel : INTEGER; UpdateProc : PROCP1V2;
--              end record;
--           DCGBopt.TraceLevel := 3;    <--  Parser accepts this
--           DCGBopt.UpdateProc (A,B);   <--  Not accepted by parser
--    (b) Nested (*...*) comments are not handled.
--
-------------------------------------------------------------------------------

-- 19-Nov-2002 [GdM]
-- otherwise/else part in case statement correctly processed:
--   any sequence of statements, not just 0 or 1

-- 19-Jan-2002 [GdM]
-- new_procedure_type and new_function_type correct - spotted by Craig Carey

-- 16-Jan-2002 [GdM]
-- Added casing of Ada keywords (upper/lower/neutral) - see P2Ada_options
-- EXIT_t exit statement (is Ada's return) - spotted by Craig Carey

-- 26.xi.1999 [GdM]
-- XOR operator

-- 26.viii.1999 [GdM]
--
-- Str translated ( bug: should be put(s,123) instead of put(123,s) )
-- ' character, written ''
-- arbitrary order of declaration kinds, instead of label-const-type-var-proc
-- typeless var parameters
-- DIV becomes /
-- SHL & SHR operators ( bug: translated by "a Shift_left( ; ) b" )
-- programs not beginning by 'Program' !
-- global initialized VARiables - in the CONSTant parts -
-- aggregates
-- strings with contraints
-- typeless files
-- else part in case..of
-- asm...end blocks (not complete)
-- special directives in proc/func decl. (like near/far/assembler)
-- characters with explicit ascii (#223)
--
-- begin/end simplified when safe (then/else/do/case)
-- outputs "Null;" for empty statement
-- outputs "WHEN others=> Null;" when no else part
--
-- $Id: Pascal.y,v 2.1 1997/08/23 18:59:33 nestor Rel $
-- $Locker:  $
-- $Log: Pascal.y,v $
-- Revision 2.1  1997/08/23 18:59:33  nestor
-- Laurent Gasser's correction for MacOS extended Pascal
-- added MacOS Pascal tokens: unit, interface, implementation, uses
-- allow module/units to become packages
-- transform Pascal uses list in Ada with list
-- accepts @ operator
-- corrected Pascal record statement (especially variant ones)
-- accepts hexadecimal constants
-- accepts procedures and functions as types
-- accepts procedure pointers as statements
-- reorder tokens in alphabetically
-- notify empty rules with comment
-- regroup rules with titles in comments
--
-- Revision 1.1  1997/08/22  21:06:07  nestor
-- Martin C. Carlisle's original version, standard Pascal
--
-- ayacc specification for Pascal
--
-- Martin C. Carlisle, US Air Force Academy
-- mcc@cs.usafa.af.mil
-- http://www.usafa.af.mil/dfcs/bios/carlisle.html
-- November 26, 1996
--
-- Laurent Gasser, Hirondelle Lumineuse
-- lga@sma.ch
-- June 21, 1997
--
-- Adaptation to extended MacOS Pascal
-- Based on the syntax diagrams of:
--   Language Reference chapter
--   in THINK Pascal, User Manual, Symantech 1991
--
--   CodeWarrior Pascal Language Reference CW10
--   Metrowerks 1996
--
-- added MacOS Pascal tokens: unit, interface, implementation, uses
-- allow module/units to become packages
-- transform Pascal uses list in Ada with list
-- accepts @ operator
-- corrected Pascal record statement (especially variant ones)
-- accepts hexadecimal constants
-- accepts procedures and functions as types
-- accepts procedure pointers as statements
--
-- usage: ayacc Pascal.y

-- Declarations
%token    ABSOLUTE_t
%token    AND_t
%token    AND_THEN_t
%token    AMPERSAND_t
%token    ARRAY_t
%token    ARROW_t
%token    ASCII_t
%token    ASSIGN_t
%token    AT_t
%token    BAR_t
%token    BEGIN_t
%token    CASE_t
%token    CHAR_CONST_t
%token    CHR_t
%token    COLON_t
%token    CONST_t
%token    CONSTANT_t
%token    CONSTRUCTOR_t
%token    COMMA_t
%token    DEC_t
%token    DESTRUCTOR_t
%token    DIV_t
%token    DIVIDE_t
%token    DO_t
%token    DOUBLEDOT_t
%token    DOUBLESTAR_t
%token    DOWNTO_t
%token    ELSE_t
%token    END_t
%token    EOF_t
%token    EOLN_t
%token    EQUAL_t
%token    EXTERNAL_t
%token    FILE_t
%token    FOR_t
%token    FORWARD_t
%token    FUNCTION_t
%token    GE_t
%token    GOTO_t
%token    GT_t
%token    HEXADECIMAL_t
%token    ID_t
%token    IF_t
%token    IMPLEMENTATION_t
%token    IN_t
%token    INC_t
%token    INHERITED_t
%token    INTERFACE_t
%token    LABEL_t
%token    LBRACK_t
%token    LE_t
%token    LPAREN_t
%token    LT_t
%token    MINUS_t
%token    MOD_t
%token    NE_t
%token    NEW_t
%token    NOT_t
%token    OBJECT_t
%token    OF_t
%token    OR_t
%token    OR_ELSE_t
%token    ORD_t
%token    OTHERWISE_t
%token    OVERRIDE_t
%token    PACKED_t
%token    PERIOD_t
%token    PLUS_t
%token    PRIVATE_t
%token    PROCEDURE_t
%token    PROGRAM_t
%token    PROTECTED_t
%token    PUBLIC_t
%token    RBRACK_t
%token    RECORD_t
%token    READ_t
%token    READLN_t
%token    REPEAT_t
%token    RPAREN_t
%token    SEMICOLON_t
%token    SET_t
%token    SHL_t
%token    SHR_t
%token    STR_t
%token    STRING_t
%token    THEN_t
%token    TIMES_t
%token    TO_t
%token    TYPE_t
%token    UNIT_t
%token    UNTIL_t
%token    UPARROW_t
%token    USES_t
%token    VAR_t
%token    VIRTUAL_t
%token    WHILE_t
%token    WITH_t
%token    WRITE_t
%token    WRITELN_t
%token    XOR_t
%token    TRY_t
%token    EXCEPT_t
%token    FINALLY_t

%start    entity

{
  type const_type is (string_type,character_type,boolean_type,other_type);
  type YYSType is record
     text    : String(1..80);
     length  : Natural := 0;
     vartype : const_type;
  end record;
}

%%
-- Rules

entity : unit | program ;

unit : unit_heading unit_contents unit_end_part;

unit_contents :
    implementation_part
  | interface_part
  | interface_and_implementation_part
   ;

unit_heading : UNIT_t
    mute_identifier {PascalHelp.package_name(1..$2.length) := $2.text(1..$2.length);
    PascalHelp.package_name_length := $2.length;}
    SEMICOLON_t
    ;

unit_end_part : END_t PERIOD_t
    { PascalHelp.put_keyword("END ");
      PascalHelp.put(PascalHelp.package_name(1..PascalHelp.package_name_length));
      PascalHelp.put_line(";");
      PascalHelp.put_line(PascalHelp.blurb);
    }
    ;

interface_and_implementation_part :
    interface_part
    { PascalHelp.put_keyword("END ");
      PascalHelp.put(PascalHelp.package_name(1..PascalHelp.package_name_length));
      PascalHelp.put_line(";");
      PascalHelp.put_line(PascalHelp.blurb);
    }
    implementation_part
    ;

interface_part : INTERFACE_t
    {PascalHelp.Default_withs;}
    uses_clause_part
    {
    PascalHelp.put_keyword("PACKAGE ");
    PascalHelp.put(PascalHelp.package_name(1..PascalHelp.package_name_length));
    PascalHelp.put_keyword(" IS");
    PascalHelp.put_line("");
    }
    heading_declaration_part
    {PascalHelp.Stop_Export;}
    ;

implementation_part : IMPLEMENTATION_t
    {PascalHelp.Default_withs;}
    uses_clause_part
    { PascalHelp.put_line("");
    PascalHelp.put_keyword("PACKAGE BODY ");
    PascalHelp.put(PascalHelp.package_name(1..PascalHelp.package_name_length));
    PascalHelp.put_keyword(" IS");
    PascalHelp.put_line("");
    PascalHelp.Default_instanciations;
    }
    declaration_part
    implementation_body_part
    ;

implementation_body_part : initialization_of_unit | ; -- EMPTY: no init.

initialization_of_unit:
    BEGIN_t {PascalHelp.put_keyword("BEGIN");}
      statement_sequence_fat
    ; -- END put with name

uses_clause_part : uses_clause_list
    | -- EMPTY
    ;

uses_clause_list : uses_clause_list uses_clause
    | uses_clause
    ;

uses_clause :
    USES_t {PascalHelp.put_keyword("WITH");PascalHelp.Clear_Selection;}
    identifier_list
    SEMICOLON_t
    {PascalHelp.put(';');
    PascalHelp.Put_translation_comment("place it before main procedure");}
    -- 28-Dec-2002: we can assume uses_clause non-empty since
    -- uses_clause_part can be empty. Conflicts: (86/89) <- (91/130)
    ;

mute_identifier : ID_t {$$.length := YYLength;
    $$.text(1..YYLength) := YYText;}
    ;

heading_declaration_part : heading_declaration_list
    | -- EMPTY
    ;

-- NB: at least one element in this list:
heading_declaration_list : heading_declaration_list any_heading_declaration
    | any_heading_declaration
    ;

any_heading_declaration :
      constant_declaration_part
    | type_definition_part
    | variable_declaration_part
    | procedure_and_function_heading_part
    ;

declaration_part : declaration_list
    | -- EMPTY
    ;

-- NB: at least one element in this list:
declaration_list : declaration_list any_declaration
    | any_declaration
    ;

any_declaration :
      label_declaration_part
    | constant_declaration_part
    | type_definition_part
    | variable_declaration_part
    | procedure_and_function_declaration_part
    ;

procedure_and_function_heading_part :
    procedure_heading_only | function_heading_only ;

procedure_heading_only : procedure_heading
    SEMICOLON_t {PascalHelp.put(';'); PascalHelp.De_stack;}
    ;

function_heading_only : function_heading
    SEMICOLON_t {PascalHelp.put(';'); PascalHelp.De_stack;}
    ;

program : correct_program | borland_program ;

correct_program : PROGRAM_t
    {PascalHelp.Default_withs;
     PascalHelp.put_keyword("PROCEDURE ");}
    new_identifier
    {PascalHelp.Stack_Ada_subprog( is_function=> False );
     PascalHelp.Put_keyword_line(" IS");
     PascalHelp.Default_instanciations;
    }
    file_list SEMICOLON_t
    program_tail
    ;

borland_program : -- <<-- Nothing!
    {PascalHelp.Default_withs;
     PascalHelp.put_keyword("PROCEDURE ");
     PascalHelp.Stack_Ada_subprog("I_love_Borland", is_function=> False);
     PascalHelp.Put_last_Ada_subprog_name;
     PascalHelp.put_keyword_line(" IS");
     PascalHelp.Default_instanciations;
    }
    program_tail
    ;

program_tail : -- 20-Dec-2002: less conflicts (79/126) <- (85/128)
    uses_clause_part
    block
    {PascalHelp.put_keyword("END ");
     PascalHelp.Put_last_Ada_subprog_name;
     PascalHelp.put(';');
     PascalHelp.Stop_Export; -- Export level 1 just before it is cleared
     PascalHelp.De_stack;
     PascalHelp.New_line;
     PascalHelp.put_line(PascalHelp.blurb);}
    PERIOD_t
    ;

file_list : LPAREN_t file_identifier_list RPAREN_t
    |  -- EMPTY
    ;

file_identifier_list : file_identifier_list COMMA_t
    identifier
    {PascalHelp.put_line(": Ada.Text_IO.File_Type;");}
    | identifier
    {PascalHelp.put_line(": Ada.Text_IO.File_Type;");}
    ;

identifier_list :
      identifier_list COMMA_t
      {PascalHelp.put(',');PascalHelp.Clear_Selection;}
      identifier
    | identifier
    ;

variable_identifier_list :
      variable_identifier_list COMMA_t
      {PascalHelp.put(',');}
      variable_identifier
    | variable_identifier
    ;

variable_identifier : new_identifier {PascalHelp.Enter_var_name;} ;

block :
    declaration_part
    compound_statement
    ;

label_declaration_part : LABEL_t label_list SEMICOLON_t
    ;

label_list : label_list comma label
    | label
    ;

label : CONSTANT_t
    ;

emitted_label : CONSTANT_t
    {PascalHelp.Put("<<LABEL_"); PascalHelp.put(YYText); PascalHelp.put(">>");}
    ;

emitted_goto_label : CONSTANT_t
    {PascalHelp.Put("LABEL_"); PascalHelp.put(YYText);}
    ;

-----------------------------------------------
--  C O N S T A N T   D E C L A R A T I O N  --
-----------------------------------------------

constant_declaration_part : CONST_t constant_declaration_list
    ;

constant_declaration_list : constant_declaration_list constant_declaration
    | constant_declaration
    ;

constant_declaration :
    {PascalHelp.DirectIO:= False;
     PascalHelp.Maybe_must_create_type:= True;
     PascalHelp.Set_variable_mark;}
    new_identifier
    {PascalHelp.Enter_var_name;} -- untyped !
    constant_declaration_ending
    {PascalHelp.put(';');}
    ;

constant_declaration_ending :
    -- Classic Pascal constant declaration: "CONST a=9" etc.
    EQUAL_t
    -- No risk of creating a type here
    { PascalHelp.Maybe_must_create_type:= False;
      PascalHelp.DirectIO:= True;
      PascalHelp.Flush;
      PascalHelp.Empty;
      PascalHelp.put_keyword(": CONSTANT");
      PascalHelp.DirectIO := False;
      PascalHelp.Clear_type_denoter;
      PascalHelp.Reset_selection;
      }
    cexpression SEMICOLON_t
    -- 17-Dec-2002: had to change $4.vartype to $3.vartype .
    {
     PascalHelp.Give_variables_a_type;
     PascalHelp.DirectIO := True;
     IF $3.vartype = boolean_type THEN
       PascalHelp.put(" Boolean := ");
     ELSIF $3.vartype = character_type THEN
       PascalHelp.put(" Character := ");
     ELSIF $3.vartype = string_type THEN
       PascalHelp.put(" String := ");
     ELSE
       PascalHelp.put(":= ");
     END IF;
     PascalHelp.flush;
     PascalHelp.empty;
    }
    |
    -- Borland's initialized variables, also in CONST part :-( !!
    COLON_t
    {PascalHelp.put(':');
     PascalHelp.Clear_type_denoter;
     PascalHelp.Reset_selection;}
    outer_type_denoter
    {PascalHelp.Give_variables_a_type;
     PascalHelp.Maybe_must_create_type:= False;}
    EQUAL_t
    {PascalHelp.put(":=");
     PascalHelp.Reset_selection;}
    expr_or_agg SEMICOLON_t
    ;

expr_or_agg : expression | aggregate;

aggregate : -- Turbo Pascal use them for initialized variables
    LPAREN_t
    {PascalHelp.put('(');PascalHelp.Clear_selection;}
    aggregate_contents
    RPAREN_t
    {PascalHelp.put(')');} ;

aggregate_contents : record_agg_both | array_agg ; -- this lowers r/r conflicts 123 <- 126

record_agg_both : record_agg | record_agg_with_comma;

array_agg : array_agg COMMA_t
            {PascalHelp.put(',');PascalHelp.Clear_selection;}
            expr_or_agg
          | expr_or_agg ;

record_agg : record_agg SEMICOLON_t
             {PascalHelp.put(',');PascalHelp.Clear_selection;}
             named_field
           | named_field ;

record_agg_with_comma : record_agg_with_comma COMMA_t
             {PascalHelp.put(',');PascalHelp.Clear_selection;}
             named_field
           | named_field ;

named_field : identifier COLON_t {PascalHelp.put("=>");PascalHelp.Clear_selection;}
              expr_or_agg;

cexpression : csimple_expression {$$.vartype := $1.vartype;}
    | csimple_expression relop csimple_expression
      {PascalHelp.Finish_Member_of; $$.vartype:=boolean_type;}
    ;

csimple_expression : unsigned_csimple_expression {$$.vartype := $1.vartype;}
    | sign unsigned_csimple_expression {$$.vartype := other_type;}
    ;

unsigned_csimple_expression :
      unsigned_csimple_expression_without_clear {PascalHelp.Clear_selection;} ;

unsigned_csimple_expression_without_clear :
      constant_term
    | unsigned_csimple_expression PLUS_t {PascalHelp.put('+');} constant_term
    | unsigned_csimple_expression MINUS_t {PascalHelp.put('-');} constant_term
    | unsigned_csimple_expression OR_t {PascalHelp.put_keyword("OR");} constant_term
    ;

constant_term : constant_term mulop constant_factor
      {$$.vartype := other_type; PascalHelp.Close_Eventual_Shift;}
    | constant_factor
    ;

-- remove "unsigned_constant : identifier" so explicit reduction to identifier
constant_factor : unsigned_constant
    | identifier
    | function_call
    | set_constructor
    | LPAREN_t
      {PascalHelp.put('(');
       PascalHelp.Clear_selection;}
      cexpression
      RPAREN_t {PascalHelp.put(')'); $$.vartype := $3.vartype;}
    | NOT_t {PascalHelp.put_keyword("NOT");} constant_factor
    ;

explicit_ascii : ASCII_t
        {DECLARE the_number : constant String := YYText;
         BEGIN
           PascalHelp.Put("Character'Val(" & the_number(2..
           the_number'last) & ")");
         END;}
    ;

borland_substring :
      STRING_t {PascalHelp.PrintString(YYText);}
      | explicit_ascii ;

borland_string :
      borland_substring |
      borland_string {PascalHelp.put('&');} borland_substring
      ;

unsigned_constant :
      unsigned_number {$$.vartype := other_type; PascalHelp.Select_litteral('N');}
    | CHAR_CONST_t {PascalHelp.Select_litteral('C');}
    {if YYText="''''" then
       PascalHelp.Put("'''"); -- 10-Jan-2003
     else
       PascalHelp.Put(YYText);
     end if;
     $$.vartype := character_type;
    }
    | explicit_ascii {$$.vartype := character_type;PascalHelp.Select_litteral('C');}
    | borland_string {$$.vartype := string_type;PascalHelp.Select_litteral('S');}
    ;

constant : non_string {$$.vartype := $1.vartype;}
    | sign non_string {$$.vartype := other_type;}
    | CHAR_CONST_t {PascalHelp.Select_litteral('C');}
    {if YYText="''''" then
       PascalHelp.Put("'''"); -- 10-Jan-2003
     else
       PascalHelp.Put(YYText);
     end if;
     $$.vartype := character_type;
    }
    | explicit_ascii {$$.vartype := character_type; PascalHelp.Select_litteral('C');}
    | borland_string {$$.vartype := string_type; PascalHelp.Select_litteral('S');}
    ;

sign : PLUS_t {PascalHelp.put('+');}
    | MINUS_t {PascalHelp.put('-');}
    ;

non_string :
      CONSTANT_t
      {PascalHelp.Put_Decimal(YYText);
       $$.vartype := other_type;
       PascalHelp.Select_litteral('N');}
    | HEXADECIMAL_t
      {PascalHelp.Put_Hexadecimal(YYText);
       PascalHelp.Select_litteral('N');}
    | identifier
    ;

---------------------------------------
--  T Y P E   D E C L A R A T I O N  --
---------------------------------------
type_definition_part :
      TYPE_t
      {PascalHelp.Open_type_definition_part;}
      type_definition_list
      {PascalHelp.Close_type_definition_part;}
    ;

type_definition_list : type_definition_list type_definition
    | type_definition
    ;

type_definition :
    {PascalHelp.put_keyword("TYPE ");
     PascalHelp.Maybe_must_add_NEW_to_type:= True; -- *only* here
    }
    new_identifier EQUAL_t
    {PascalHelp.Open_Type_declaration;
     PascalHelp.Reset_selection;}
    outer_type_denoter SEMICOLON_t
    {PascalHelp.Close_type_declaration;}
    ;

-- Denoter "type_identifier" is just the identifier of a known type.

type_identifier :
   identifier
   {PascalHelp.Type_identifier; PascalHelp.Clear_Selection;};

string_constraint : -- we know that the identifier is "string"...
    identifier LBRACK_t
    {PascalHelp.put("(1 ..");PascalHelp.Denoter_is_String;}
    constant {PascalHelp.put(")");} RBRACK_t ;

-- Type denoters, 24-Jan-2003: outer (top level), inner (other levels)

outer_type_denoter :
       -- 20-Jan-2003 : Special case of subrange_type ("m .. *").
       -- Added at this level, otherwise P2Ada believes this is
       -- a copied type ("[type T2 =] T1")
        identifier DOUBLEDOT_t
        {
         if PascalHelp.Maybe_must_add_NEW_to_type then
           PascalHelp.DirectIO:= True;
           PascalHelp.Put_keyword(" RANGE ");
           PascalHelp.Flush;
           PascalHelp.Empty;
         elsif PascalHelp.Maybe_must_create_type then
           PascalHelp.DirectIO:= True;
           PascalHelp.Add(PascalHelp.tzpe);
           -- But the buffer is kept.
           PascalHelp.Put_keyword("type ");
           PascalHelp.Put_last(PascalHelp.tzpe);
           PascalHelp.Put_keyword(" IS RANGE ");
           declare
             id: constant String:= PascalHelp.Recent_identifier(1);
           begin
             PascalHelp.Put(id);
             PascalHelp.Shorten_buffer( id'length );
           end;
           PascalHelp.Just_after_TYPE_X_IS:= True;
         end if;
         PascalHelp.Put(" .. ");
         PascalHelp.Reset_selection;
        }
        expression
        {if PascalHelp.Maybe_must_create_type then
           PascalHelp.Put(';');
           PascalHelp.Put_translation_comment("type definition needed in Ada");
           PascalHelp.Flush; -- The variable list comes now
           PascalHelp.Empty; -- ':' included
           PascalHelp.Put(' ');
           PascalHelp.Put_last(PascalHelp.tzpe);
         end if;}
    |
      type_identifier
      {-- Maybe must add NEW (ex: "type t is NEW Integer")
       if PascalHelp.Maybe_must_add_NEW_to_type then
         PascalHelp.DirectIO:= True;
         PascalHelp.Put_keyword(" NEW ");
         PascalHelp.Flush;
         PascalHelp.Empty;
       -- No worry about creating a type here (VAR or CONST)
       elsif PascalHelp.Maybe_must_create_type then
         PascalHelp.DirectIO:= True;
         PascalHelp.Flush;
         PascalHelp.Empty;
       end if;}
    | string_constraint
      {-- "type t is NEW String(1..200)"
       if PascalHelp.Maybe_must_add_NEW_to_type then
         PascalHelp.DirectIO:= True;
         PascalHelp.Put_keyword(" NEW ");
         PascalHelp.Flush;
         PascalHelp.Empty;
       -- No worry about creating a type here (VAR or CONST)
       else
         PascalHelp.No_need_of_type_creation;
       end if;}
    |
      {if PascalHelp.Maybe_must_add_NEW_to_type then
         PascalHelp.DirectIO:= True;
         PascalHelp.Flush;
         PascalHelp.Empty;
       end if;
      }
      outer_new_type
    ;

new_non_structured_type :
      new_ordinal_type
    | new_pointer_type
    | new_procedure_type
    | new_function_type
    ;

outer_new_type :
     -- Certainly not an array: for a VAR we must create type
      {PascalHelp.Open_eventual_type_creation;}
      new_non_structured_type
      {PascalHelp.Close_eventual_type_creation;}
    | outer_new_structured_type ;

inner_type_denoter :
      identifier_dot_dot_expression |
      type_identifier | string_constraint | inner_new_type ;

identifier_dot_dot_expression :
      -- Case of an inner range denoter with a lonely identifier before ".."
      -- that could be taken as a type_identifier! 11-Feb-2003
      identifier
      DOUBLEDOT_t
        {PascalHelp.Put(" .. "); PascalHelp.Reset_selection;}
      expression
        {PascalHelp.Put_translation_comment("A subtype should be created for that.");}
    ;

inner_new_type : inner_new_structured_type | new_non_structured_type ;

new_ordinal_type : enumerated_type
    | {if PascalHelp.Just_after_TYPE_X_IS then
         PascalHelp.put_keyword(" range ");
       end if;
       PascalHelp.Reset_selection;} -- Only for "type T is RANGE a..b;" !! (172/99) <- (100/112) !!
      subrange_type
    ;

enumerated_type : LPAREN_t {PascalHelp.put('(');PascalHelp.Clear_selection;}
    variable_identifier_list --  <-- a bit weak but enters the identifiers.
    RPAREN_t {PascalHelp.put(')');}
    ;

subrange_type : expression DOUBLEDOT_t
                {PascalHelp.put(" .. ");PascalHelp.Reset_selection;} expression
    ; -- 8-Jan-2003, was: constant .. constant (92/105) <- (90/98)

outer_new_structured_type : outer_structured_type
    | PACKED_t outer_structured_type
    ;

inner_new_structured_type : inner_structured_type
    | PACKED_t inner_structured_type
    ;

-- 24-Jan-2003: Ada tolerates anonymous arrays, so we keep them.

outer_structured_type :
      {PascalHelp.No_need_of_type_creation;} array_type
    | {PascalHelp.Open_eventual_type_creation;}
      record_type
      {PascalHelp.Close_eventual_type_creation;}
    | {PascalHelp.No_need_of_type_creation;} set_type
    | {PascalHelp.No_need_of_type_creation;} file_type
    | object_type
    ;

inner_structured_type : array_type
    | record_type
    | set_type
    | file_type
    ;

array_type : ARRAY_t
    {PascalHelp.put_keyword("ARRAY (");
     PascalHelp.Just_after_TYPE_X_IS:= False;
     PascalHelp.Open_array_dim( True );
    }
    LBRACK_t index_list RBRACK_t OF_t
    {PascalHelp.put_keyword(") OF ");PascalHelp.Clear_selection;}
    component_type
    {PascalHelp.Close_array_def;}
    ;

index_list :
      index_list comma
      {PascalHelp.put(',');
       PascalHelp.Open_array_dim( False );
       PascalHelp.Clear_Selection;}
      index_type
    | index_type
    ;

index_type : ordinal_type;

ordinal_type :
      enumerated_type | subrange_type
      -- Was: new_ordinal_type which is {enumerated_type | subrange_type}
      -- (136/111) <- (172/99) and "array[a..b]" works again
    | identifier
    ;

component_type : inner_type_denoter ;

-- The SEMICOLON_t after record_section_list is raising a shift/reduce
-- conflict: within record_section_list or transition to variant_part?
-- So regroup the two rules
--   record_section_list SEMICOLON_t record_section
--   record_section_list SEMICOLON_t variant_part
-- in record_section_list, eliminate left recursion, and left factor the
-- resulting rule.
--
-- The persistent shift/reduce conflict is correctly resolved in favor
-- of the shift: consume a SEMICOLON_t and iterate on record_section_list.
-- But this very SEMICOLON_t could be interprated as the optional_semicolon
-- in record_type.  This conflict was raising a syntax error exception on legal
-- Pascal source.  It has been solve by removing optional_semicolon after
-- field_list in the rule record_type, and using a boolean for closing
-- the last statement of the record with a semicolon.

record_type : RECORD_t
    {PascalHelp.put_keyword(" RECORD ");
     PascalHelp.Open_record_def;
    }

    field_list

    {if not PascalHelp.has_optional_semicolon then
       PascalHelp.put(';');
     end if;
     PascalHelp.has_optional_semicolon := FALSE;
     PascalHelp.Close_record_def;
    }
    END_t {PascalHelp.put_keyword("END RECORD");}
    ;

method_directive :
   VIRTUAL_t SEMICOLON_t
 | OVERRIDE_t SEMICOLON_t
 | -- none
    ;

object_directive :
   PRIVATE_t
  | PROTECTED_t
  | PUBLIC_t
  | -- none
    ;

proc_or_func_object : object_directive procedure_and_function_heading_part method_directive
    ;

proc_or_func_object_list :
      proc_or_func_object_list      proc_or_func_object
    | proc_or_func_object
    | -- EMPTY
    ;

inheritance :
     { PascalHelp.put_keyword("TAGGED RECORD "); }
      -- EMPTY : object is a root one
    |
      LPAREN_t
     { PascalHelp.put_keyword("NEW ");
       PascalHelp.Reset_selection;}
       variable_access
     { PascalHelp.put_keyword(" WITH RECORD ");
       PascalHelp.Link_parent_of_object;}
      RPAREN_t
    ;

object_type : OBJECT_t
    {PascalHelp.Remember_name_of_object(age => 0);
     PascalHelp.EnterObjectStruct;
     PascalHelp.Open_record_def;
    }

    inheritance

    field_list

    {if not PascalHelp.has_optional_semicolon then
       PascalHelp.put(';');
     end if;
     PascalHelp.put_keyword("END RECORD");
     PascalHelp.has_optional_semicolon := FALSE;
     PascalHelp.Close_type_declaration;
     -- ^ OBJECT closes the declaration prematurely, before methods
     PascalHelp.Give_variables_a_type;
     PascalHelp.Close_record_def;
     PascalHelp.new_line;
    }

    proc_or_func_object_list

    END_t
    {PascalHelp.LeaveObjectStruct;
    }
    ;

field_list : record_section_list
    | variant_part
    | {PascalHelp.put_keyword(" NULL");} -- EMPTY (added 27-Jan-2003)
    ;

record_section_list : record_section_list SEMICOLON_t {PascalHelp.put(';');}
    tail_record_section_list
    | object_directive record_section
    ;

tail_record_section_list : object_directive record_section
    | variant_part
    | {PascalHelp.has_optional_semicolon := TRUE;}
    ;

field_identifier_list : field_identifier_list COMMA_t
      {PascalHelp.put(',');} field_identifier
    | field_identifier
    ;

field_identifier : new_identifier {PascalHelp.Enter_field_name;} ;

record_section :
    {PascalHelp.Set_field_mark(1);}
    field_identifier_list
    COLON_t
    {PascalHelp.Set_field_mark(2);
     PascalHelp.put(':');
     PascalHelp.Just_after_TYPE_X_IS:= False;
     PascalHelp.Reset_selection;}
    inner_type_denoter
    {PascalHelp.Give_variables_a_type;}
    ;

variant_part :
    CASE_t
    {PascalHelp.put_keyword("CASE");
     PascalHelp.Set_field_mark(1);
     PascalHelp.Reset_selection;}
    variant_selector
    OF_t {PascalHelp.put_keyword_line("IS");}
    {PascalHelp.put_keyword("WHEN ");} variant_list
    optional_semicolon
    {PascalHelp.Put_empty_otherwise; PascalHelp.put_keyword("END CASE");}
    ;

variant_selector :
      tag_field_identifier_list COLON_t
      {PascalHelp.Set_field_mark(2);
       PascalHelp.Put('(' & PascalHelp.Recent_identifier(0) & ": ");
       PascalHelp.Reset_selection;}
      tag_type
      {PascalHelp.Give_variables_a_type;
       PascalHelp.Put(')');}
    | tag_type
    ;

variant_list : variant_list SEMICOLON_t
     {PascalHelp.put_keyword("WHEN ");
      PascalHelp.Reset_selection;}
      variant
    | variant
    ;

variant : case_constant_list COLON_t {PascalHelp.put(" => ");}
    LPAREN_t
    {PascalHelp.Stack_optional_semicolon;}
    field_list optional_semicolon
    {
    if not PascalHelp.has_optional_semicolon then
      PascalHelp.put(';');
    end if;
    PascalHelp.Recall_optional_semicolon;
    }
    RPAREN_t
    ;

case_constant_list : case_constant_list
      comma
      {PascalHelp.put(" | ");
       PascalHelp.Reset_selection;}
      case_constant
    | case_constant
    ;

case_constant :
      -- 20-Jan-2003 "expression" was "constant". (135/107) <- (135/110)
      -- 24-Jan-2003 ".." was missing!
      expression |
      expression DOUBLEDOT_t
      {PascalHelp.put("..");
       PascalHelp.Reset_selection;}
      expression ;

-- tag_field : identifier ;
      -- 27-Jan-2003: Borland admits several variables for the CASE !
      -- field_

tag_field_identifier_list : tag_field_identifier_list COMMA_t
      {PascalHelp.put(',');PascalHelp.Reset_selection;}
      tag_field_identifier
    | tag_field_identifier
    ;

tag_field_identifier : identifier {PascalHelp.Enter_field_name;} ;
    -- new_identifier messes Ayacc!

tag_type : identifier ;

set_type : SET_t OF_t {PascalHelp.put_keyword("array(");} base_type
    {PascalHelp.put_keyword(") of "); PascalHelp.put("Boolean");}
    ;

base_type : ordinal_type ;

file_type :
      FILE_t
      {if PascalHelp.Maybe_must_add_NEW_to_type then
         PascalHelp.Put_keyword("NEW ");
       end if;
       PascalHelp.Open_file_def;}
      file_type_tail
    ;

file_type_tail :
      OF_t {PascalHelp.Just_after_TYPE_X_IS:= False;}
      component_type
      {PascalHelp.Close_file_def;
       PascalHelp.Create_Direct_IO(anonymous => False);}
    | {PascalHelp.Clear_type_denoter; -- File of no type!
       PascalHelp.Close_file_def;
       PascalHelp.Create_Direct_IO(anonymous => True);}
    ;

new_pointer_type :
      UPARROW_t
      {PascalHelp.put_keyword("ACCESS ");
       PascalHelp.Open_pointer_def;
       PascalHelp.Reset_selection;}
      domain_type
      {PascalHelp.Close_pointer_def;
       PascalHelp.Put_Line(";");
       PascalHelp.Put( "procedure Dispose is new Ada.Unchecked_Deallocation(" &
         PascalHelp.Recent_identifier(0) & ", " &
         PascalHelp.Recent_identifier(1) & ')');
      }
    ;

domain_type : type_identifier ;

new_procedure_type :
      PROCEDURE_t {PascalHelp.put_keyword("ACCESS PROCEDURE");}
      possible_formals;

new_function_type :
      FUNCTION_t {PascalHelp.put_keyword("ACCESS FUNCTION");}
      possible_formals
      COLON_t {PascalHelp.put_keyword(" RETURN");PascalHelp.Clear_selection;}
      identifier
    ;

-----------------------------------------------
--  V A R I A B L E   D E C L A R A T I O N  --
-----------------------------------------------
variable_declaration_part : VAR_t
    variable_declaration_list
    ;

variable_declaration_list :
      variable_declaration_list variable_declaration
    | variable_declaration
    ;

variable_declaration :
    -- We retain the list in case we have to create an ad-hoc type
    {PascalHelp.DirectIO:= False;
     PascalHelp.Maybe_must_create_type:= True;
     PascalHelp.Set_variable_mark;}
    variable_identifier_list
    COLON_t
    {PascalHelp.put(':');
     PascalHelp.Clear_type_denoter;
     PascalHelp.Reset_selection;}
    outer_type_denoter
    absolute_part
    assign_part -- FreePascal (15-Nov-2006)
    SEMICOLON_t
    {PascalHelp.Give_variables_a_type;
     PascalHelp.Maybe_must_create_type:= False;
     PascalHelp.put(';');}
    ;

absolute_part : | -- EMPTY
    ABSOLUTE_t {PascalHelp.put_keyword(" renames ");} identifier
    ;

assign_part : | -- EMPTY
    EQUAL_t {PascalHelp.Put(":=");} expression
    ;

---------------------------------------------------
--  S U B R O U T I N E   D E C L A R A T I O N  --
---------------------------------------------------
procedure_and_function_declaration_part :
        proc_or_func_declaration_list SEMICOLON_t
    ;

proc_or_func_declaration_list :
      proc_or_func_declaration_list SEMICOLON_t
      proc_or_func_declaration
    | proc_or_func_declaration
    ;

proc_or_func_declaration : procedure_declaration
    | function_declaration
    ;

procedure_declaration : procedure_heading SEMICOLON_t
      {DECLARE
         tok : Token;
       BEGIN
         tok := YYLex;
         IF (tok = FORWARD_t) OR (tok=EXTERNAL_t) THEN
           PascalHelp.put_line(";");
         ELSE
           PascalHelp.put_keyword_line(" IS");
         END IF;
         UnYYLex(tok);
      END;}
      directive_or_block
      {PascalHelp.LeaveObjectStruct;}
    ;

procedure_heading :
    procedure_identification possible_formals
    ;

directive :
   FORWARD_t
 | code_format_directives
   EXTERNAL_t
   link_name_directive -- FreePascal (15-Nov-2006)
   {PascalHelp.Put_Import_directive("C");}
 ;

code_format_directives : code_format_directives_nonzero | ; -- EMPTY
code_format_directives_nonzero :
   code_format_directives code_format_directive | code_format_directive ;
code_format_directive :
   ID_t -- ID_t suffices (was identifier) Conflicts: (78/89) <- (86/89)
   {PascalHelp.Memorize_identifier( YYtext(1..YYLength), YYtext(1..YYLength) );
    PascalHelp.Put_Export_directive;}
   SEMICOLON_t ; -- near or far and/or assembler

link_name_directive :
   {PascalHelp.Memorize_identifier( PascalHelp.Last_Ada_subprog_name, PascalHelp.Last_Ada_subprog_name );}
   -- no directive, take subprog's name
   |
   ID_t -- is: name
   STRING_t
   { PascalHelp.Memorize_identifier( YYtext(2..YYLength-1), YYtext(2..YYLength-1) );}
   ;

formal_parameter_list : LPAREN_t
     {PascalHelp.put('(');
      PascalHelp.Var_Self_If_Object( other_params => True );
      PascalHelp.Set_variable_mark;
      PascalHelp.Clear_Selection;}
     formal_parameter_section_list RPAREN_t {PascalHelp.put(')');} ;

formal_parameter_section_list : formal_parameter_section_list SEMICOLON_t
      {PascalHelp.put(';'); PascalHelp.Set_variable_mark;PascalHelp.Clear_Selection;}
      formal_parameter_section
    | formal_parameter_section
    ;

formal_parameter_section : value_parameter_specification
    | variable_parameter_specification
    | constant_parameter_specification
    | procedural_parameter_specification
    | functional_parameter_specification
    ;

value_parameter_specification : variable_identifier_list COLON_t
    {PascalHelp.put(':');PascalHelp.Clear_Selection;}
    type_with_passing_option
    ;

variable_parameter_specification :
    VAR_t variable_identifier_list variable_parameter_specification_tail ;

-- GdM 28-Dec-2002 for CW Pascal: procedure P(x: univ integer);
type_with_passing_option : type_of_parameter | passing_option type_of_parameter;

type_of_parameter : type_identifier {PascalHelp.Give_variables_a_type;} ;


passing_option :
    identifier
    {PascalHelp.Put_translation_comment("passing option!");
     PascalHelp.Clear_Selection;}
    ;

variable_parameter_specification_tail :
      COLON_t
      {PascalHelp.Put_VAR_param;PascalHelp.Clear_Selection;}
      type_with_passing_option
    |
      {PascalHelp.Put_VAR_param; PascalHelp.put(" [Help! Typeless VAR!]");}
    ;

constant_parameter_specification :
    CONST_t variable_identifier_list constant_parameter_specification_tail ;

constant_parameter_specification_tail :
      COLON_t {PascalHelp.Put_CONST_param;} type_with_passing_option
    |
      {PascalHelp.Put_CONST_param; PascalHelp.put(" [Help! Typeless CONST!]");}
    ;
procedural_parameter_specification : procedure_heading {PascalHelp.De_stack;};

functional_parameter_specification : function_heading {PascalHelp.De_stack;};

object_or_proc_id_first_id :
     {PascalHelp.DirectIO:= False;}
      new_identifier
      -- ^ in the OO case this one is not new !
     {PascalHelp.DirectIO:= True;}
;

object_or_proc_id_method : -- object_name.method_name (OO)
     {PascalHelp.Empty;
      PascalHelp.Remember_name_of_object(age => 0);}
      PERIOD_T
     {PascalHelp.EnterObjectStruct;}
      new_identifier
;

object_or_proc_id_single : -- subprog_name (procedure)
     {PascalHelp.Flush;
      PascalHelp.Empty;}
;

object_or_proc_id_after_first :
      object_or_proc_id_method
    | object_or_proc_id_single
;

object_or_proc_id :
      object_or_proc_id_first_id
      object_or_proc_id_after_first
    ;

procedure_identification :
    PROCEDURE_t
    {PascalHelp.put_keyword("PROCEDURE");}
    object_or_proc_id
    {PascalHelp.Stack_Ada_subprog( is_function=> False );}
    | CONSTRUCTOR_t
    {PascalHelp.put_keyword("PROCEDURE");}
    object_or_proc_id
    {PascalHelp.Stack_Ada_subprog( is_function=> False );}
    | DESTRUCTOR_t
    {PascalHelp.put_keyword("PROCEDURE");}
    object_or_proc_id
    {PascalHelp.Stack_Ada_subprog( is_function=> False );}
    ;

function_declaration : function_heading SEMICOLON_t
      {DECLARE
         tok : Token;
       BEGIN
         tok := YYLex;
         IF (tok = FORWARD_t) OR (tok=EXTERNAL_t) THEN
           PascalHelp.put_line(";");
         ELSE
           PascalHelp.Open_function_body(type_ident => $1.text(1..$1.length));
         END IF;
         UnYYLex(tok);
      END;}
    func_directive_or_block
      {PascalHelp.LeaveObjectStruct;}
    ;

func_directive_or_block :
      directive {PascalHelp.De_stack;}
    | code_format_directives block {PascalHelp.Close_function_block;}
    ;

directive_or_block :
      directive {PascalHelp.De_stack;}
    | code_format_directives block {PascalHelp.Close_procedure_block;}
    ;

function_heading : FUNCTION_t {PascalHelp.put_keyword("FUNCTION");}
    object_or_proc_id
      {PascalHelp.Stack_Ada_subprog( is_function=> True );}
    possible_formals
    COLON_t {PascalHelp.put_keyword(" RETURN ");PascalHelp.Clear_selection;}
    result_type
    {$$.length := $8.length;
     $$.text := $8.text;
     PascalHelp.Give_last_function_its_type;
    }
    ;

possible_formals :
      formal_parameter_list
    | { PascalHelp.Var_Self_If_Object( other_params => False ); }
      -- EMPTY
    ;

result_type : identifier {$$.length := $1.length; $$.text := $1.text;};

---------------------------
--  S T A T E M E N T S  --
---------------------------

statement_part : non_labeled_statement
    | emitted_label COLON_t non_labeled_statement
    | emitted_label COLON_t {PascalHelp.put_keyword(" null;");}
    | {PascalHelp.put_keyword(" null; ");} -- EMPTY
    ;

non_labeled_statement :
      {PascalHelp.function_result_flag:= True; -- *Only on this place*
       PascalHelp.Clear_null_flag;
       PascalHelp.Reset_selection;  -- In case of an assignment.
      }
      simple_statement
    | {PascalHelp.Clear_null_flag;
       PascalHelp.Reset_selection;  -- In case of a FOR i:= ...
      }
      structured_statement
    ;

simple_statement :
      assignment_statement  -- <-- includes prefixed procedure calls !
    | procedure_statement   -- <-- excepted prefixed procedure calls !
    | goto_statement
    ;

structured_statement :
      compound_statement
      {PascalHelp.put_keyword("END;");}
    | if_statement
    | case_statement
    | repeat_statement
    | while_statement
    | for_statement
    | with_statement
    | try_finally -- Added 2007
    ;

assignment_statement : variable_access rest_of_assignment_statement ;

rest_of_assignment_statement :
      true_rest_of_assignment_statement
    | rest_of_prefixed_procedure_call
    ;

rest_of_prefixed_procedure_call :
      {PascalHelp.function_result_flag:= False;}
      params {PascalHelp.put(';');}
    ;

true_rest_of_assignment_statement :
    ASSIGN_t
    {PascalHelp.function_result_flag:= False;}
    {PascalHelp.put(":=");
     PascalHelp.Reset_selection;}
    expression
    {PascalHelp.put(';');}
    ;

-- 15-Dec-2002: no "end;" put on that place.
--              Allows putting a function return and a subprogram name.

compound_statement :
    BEGIN_t {PascalHelp.Put_keyword("BEGIN");
             PascalHelp.Set_null_flag;
             PascalHelp.With_Self_If_Object;}
       statement_sequence_fat
    END_t {PascalHelp.End_Self_If_Object; PascalHelp.Put_eventual_null;}
    ;

try_finally :  -- Added 2007
    TRY_t   {PascalHelp.Put_keyword("BEGIN");
             PascalHelp.Set_null_flag;
             PascalHelp.With_Self_If_Object;
            }
       statement_sequence_fat
    FINALLY_t
      {PascalHelp.Put_eventual_null;
       PascalHelp.Put("[ Help! Please copy here the code in the ""finally"" part ]");
       PascalHelp.New_Line;
       PascalHelp.Put_keyword("EXCEPTION");
       PascalHelp.Put_translation_comment("** Begin of the ""finally"" part");
       PascalHelp.New_Line;
       PascalHelp.Put_keyword("when others =>");
       PascalHelp.New_Line;
       PascalHelp.Set_null_flag;
      }
       statement_sequence_fat
      {
       PascalHelp.New_Line;
       PascalHelp.Put_keyword("raise;");
       PascalHelp.Put_translation_comment("** End of the ""finally"" part, re-raise the exception");
      }
    END_t
    { PascalHelp.End_Self_If_Object;
      PascalHelp.Put_eventual_null;
      PascalHelp.Put_keyword("END;");
    }
    ;

statement_sequence : statement_part
    | statement_sequence SEMICOLON_t statement_part
    ;

statement_part_fat : non_labeled_statement
    | emitted_label COLON_t non_labeled_statement
    | emitted_label COLON_t {PascalHelp.put_keyword(" null; ");}
    | -- EMPTY
    ;

statement_sequence_fat : statement_part_fat
    | statement_sequence_fat SEMICOLON_t statement_part_fat
    ;

fat_statement_part : -- Trash the extra safely enclosed BEGIN...END
    statement_part
    | BEGIN_t {PascalHelp.Set_null_flag;}
         statement_sequence_fat END_t {PascalHelp.Put_eventual_null;}
    ;

repeat_statement : REPEAT_t {PascalHelp.put_keyword("LOOP");}
    statement_sequence_fat
    UNTIL_t {PascalHelp.put_keyword("   EXIT WHEN");
       PascalHelp.Reset_selection;} boolean_expression
    {PascalHelp.put_line(";"); PascalHelp.put_keyword("   END LOOP;");}
    ;

while_statement : WHILE_t {PascalHelp.put_keyword("WHILE");
       PascalHelp.Reset_selection;} boolean_expression
    DO_t {PascalHelp.put_keyword("LOOP");}
    fat_statement_part {PascalHelp.put_keyword("END LOOP;");}
    ;

for_statement : FOR_t {PascalHelp.put_keyword("FOR");} control_variable
            ASSIGN_t {PascalHelp.put_keyword(" IN");
              PascalHelp.DirectIO := False;
              PascalHelp.Reset_selection;
            } initial_value direction
            final_value DO_t
            {PascalHelp.put_keyword("LOOP");}
            fat_statement_part
            {PascalHelp.put_keyword("END LOOP;");}
    ;

with_statement : WITH_t
    { PascalHelp.WITH_header; }
    record_variable_list
    DO_t
    {
    PascalHelp.DirectIO:= True;
    PascalHelp.Put_keyword("BEGIN");
    }
    fat_statement_part -- "fat_": instructions are safely enclosed
    {
    PascalHelp.Close_WITH;
    PascalHelp.New_Line;
    PascalHelp.Put_keyword("END;");
    PascalHelp.Put_translation_comment("end of WITH");
    }
    ;

record_variable_list : record_variable_list comma record_variable
    | record_variable
    ;

record_variable :
    variable_access
    {PascalHelp.WITH_variable;} ;

if_statement :
    IF_t {PascalHelp.put_keyword("IF ");
       PascalHelp.Reset_selection;} boolean_expression
    THEN_t {PascalHelp.put_keyword("THEN");} fat_statement_part
    else_part_possible
    {PascalHelp.put_keyword("END IF;");}
    ;

else_part_possible : else_part | ; -- EMPTY

else_part : ELSE_t {PascalHelp.put_keyword("ELSE");} fat_statement_part ;

procedure_statement :
      simple_procedure_call
    | pointed_procedure_call
    | str_instruction
    | dec_instruction -- 9-Jan-2003
    | inc_instruction -- 9-Jan-2003
    | allocate -- 17-Dec-2002, completed 27-Jan-2003
    | WRITE_t
      {PascalHelp.function_result_flag:= False;
       PascalHelp.RW.Clear_file_state;} write_params
      {PascalHelp.RW.Complete;}
    | WRITELN_t
      {PascalHelp.function_result_flag:= False;
       PascalHelp.RW.Clear_file_state;} write_params
      {PascalHelp.RW.Complete_Ln("New");}
    | READ_t
      {PascalHelp.function_result_flag:= False;
       PascalHelp.RW.Clear_file_state;} read_params
      {PascalHelp.RW.Complete;}
    | READLN_t
      {PascalHelp.function_result_flag:= False;
       PascalHelp.RW.Clear_file_state;} read_params
      {PascalHelp.RW.Complete_Ln("Skip");}
    ;

simple_procedure_call : identifier
      {PascalHelp.function_result_flag:= False;}
      params {PascalHelp.put(';');}
    ;

pointed_procedure_call : pointer_dereference
      {PascalHelp.function_result_flag:= False;}
      params {PascalHelp.put(';');}
    ;

params : non_empty_params
    |  -- EMPTY
    ;

write_params :
    LPAREN_t
    {PascalHelp.DirectIO:= False;
     PascalHelp.put("Put(");
     PascalHelp.RW.parameter:= True;
     PascalHelp.Reset_selection;}
    write_actual_parameter_list RPAREN_t {PascalHelp.Put("); ");}
    |  -- EMTPY
    ;

write_actual_parameter_list : write_actual_parameter_list comma
      {PascalHelp.RW.Separate_arguments("Put");}
      write_actual_parameter
    | write_actual_parameter
    ;

write_actual_parameter :
      expression_without_clear {PascalHelp.RW.Store_file_state;}
    | expression_without_clear COLON_t
     { PascalHelp.RW.Store_file_state; PascalHelp.put(',');
       PascalHelp.Reset_selection;} another_colon
    ;

read_params :
    LPAREN_t
    {PascalHelp.DirectIO:= False;
     PascalHelp.put("Get(");
     PascalHelp.RW.parameter:= True;
     PascalHelp.Reset_selection;}
    read_actual_parameter_list RPAREN_t {PascalHelp.Put("); ");}
    |  -- EMTPY
    ;

read_actual_parameter_list : read_actual_parameter_list comma
      {PascalHelp.RW.Separate_arguments("Get");}
      read_actual_parameter
    | read_actual_parameter
    ;

read_actual_parameter : expression_without_clear {PascalHelp.RW.Store_file_state;} ;

another_colon : expression
    | expression COLON_t {PascalHelp.put(',');
       PascalHelp.Reset_selection;} expression
      {PascalHelp.put(",0");}
    ;

str_instruction : STR_t
    {PascalHelp.function_result_flag:= False;
     PascalHelp.Put("Put");} str_params {PascalHelp.put(';');}
    ;

str_params : LPAREN_t
    {PascalHelp.put('(');
     PascalHelp.RW.Clear_file_state;
     -- 2-Jun-2003: meaningless for STR, but read by WRITE's params.
    }
    write_actual_parameter comma {PascalHelp.put(',');
       PascalHelp.Reset_selection;}
    expression RPAREN_t {PascalHelp.put(')');}
    ;

non_empty_params :
    LPAREN_t
    {PascalHelp.Stack_selection;
     PascalHelp.Stack_Postfixed_alias;
    }
    actual_parameter_list
    RPAREN_t
    {PascalHelp.Recall_Postfixed_alias;
     PascalHelp.Destack_selection;
     }
    ;

actual_parameter_list : actual_parameter_list comma
    {PascalHelp.put(','); PascalHelp.Clear_selection;}
      actual_parameter
    | actual_parameter
    ;

dec_instruction : DEC_t -- 9-Jan-2003
     LPAREN_t
    {PascalHelp.DirectIO:= False;
       PascalHelp.Reset_selection;}
     expression
    {PascalHelp.Inc_dec_part_1;}
     inc_dec_params
     RPAREN_t
    {PascalHelp.Inc_dec_part_2(" - ");}
    ;

inc_instruction : INC_t -- 9-Jan-2003
     LPAREN_t
    {PascalHelp.DirectIO:= False;
       PascalHelp.Reset_selection;}
     expression
    {PascalHelp.Inc_dec_part_1;}
     inc_dec_params
     RPAREN_t
    {PascalHelp.Inc_dec_part_2(" + ");}
    ;

inc_dec_params : inc_dec_params_n  | {PascalHelp.Put('1');} ; -- EMPTY

inc_dec_params_n : comma {PascalHelp.Put('(');
       PascalHelp.Reset_selection;} expression {PascalHelp.Put(')');} ;

allocate :
      NEW_t
      LPAREN_t
      {PascalHelp.Reset_selection;}
      variable_access
      {PascalHelp.Conclude_allocator;}
      discriminants
      RPAREN_t
      {PascalHelp.Put(';');}
;

discriminants :
      COMMA_t
      {PascalHelp.Put('(');}
      discriminant_list
      {PascalHelp.Put(')');}
    |  -- EMPTY
    ;

discriminant_list :
      discriminant_list COMMA_t {PascalHelp.Put(',');} expression
    | expression
    ;


actual_parameter : expression_without_clear
    ;

exit_param : non_empty_exit_param  -- CW Pascal
    |  -- EMPTY
    ;

non_empty_exit_param : LPAREN_t
    {PascalHelp.Put_keyword("return [from] ");
       PascalHelp.Reset_selection;}
    expression
    RPAREN_t
    {PascalHelp.Put(';');
     PascalHelp.Put_translation_comment("!Help! CWP's EXIT(...)");
     }
    ;

goto_statement : GOTO_t {PascalHelp.put_keyword("GOTO");}
    emitted_goto_label {PascalHelp.put("; ");}
    ;

case_statement : CASE_t {PascalHelp.put_keyword("CASE ");
       PascalHelp.Reset_selection;} case_index
    OF_t {PascalHelp.put_keyword_line(" IS ");}
    {PascalHelp.put_keyword("WHEN ");} case_list_element_list
    rest_of_case END_t {PascalHelp.put_keyword_line("END CASE;");}
    ;

rest_of_case : optional_semicolon otherwisepart_or_null optional_semicolon
    ;

optional_semicolon : SEMICOLON_t
    |  -- EMPTY
    ;

otherwisepart_or_null : {PascalHelp.Set_null_flag;} otherwisepart {PascalHelp.Put_eventual_null;}
    | {PascalHelp.Put_empty_otherwise;}   -- EMPTY
    ;

case_index : expression ;

case_list_element_list : case_list_element_list SEMICOLON_t
      {PascalHelp.put_keyword("WHEN ");} case_list_element
    | case_list_element
    ;

case_list_element : case_constant_list COLON_t {PascalHelp.put("=>");}
    fat_statement_part
    ;

otherwisepart : OTHERWISE_t {PascalHelp.put_keyword("WHEN OTHERS =>");} statement_sequence_fat
    | OTHERWISE_t COLON_t {PascalHelp.put_keyword("WHEN OTHERS =>");} statement_sequence_fat
    | ELSE_t {PascalHelp.put_keyword("WHEN OTHERS =>");} statement_sequence_fat
    ;

control_variable : identifier ;

initial_value : expression ;

direction :   TO_t     { PascalHelp.Direction_To;
                         PascalHelp.Reset_selection; }
            | DOWNTO_t { PascalHelp.Direction_Downto;
                         PascalHelp.Reset_selection; } ;

final_value : expression { PascalHelp.Close_eventual_Downto; } ;

boolean_expression : expression ;

expression : expression_without_clear {PascalHelp.Clear_selection;} ;

expression_without_clear :
      simple_expression
    | simple_expression relop simple_expression
      {PascalHelp.Finish_Member_of;}
    ;

simple_expression : unsigned_simple_expression
    | sign unsigned_simple_expression
    ;

unsigned_simple_expression : term
    | unsigned_simple_expression addop term
    ;

term : factor
    | term mulop factor {PascalHelp.Close_Eventual_Shift;}
    ;

factor : AT_t
      {PascalHelp.put("System.Address_To_Access_Conversions.To_Address(");
       PascalHelp.Clear_selection;}
      variable_access {PascalHelp.put_line(")");}
    | unsigned_constant
    | variable_access
    | set_constructor
    | LPAREN_t {PascalHelp.put('(');PascalHelp.Clear_selection;}
      expression
      RPAREN_t {PascalHelp.put(')');}
    | NOT_t
      {PascalHelp.put_keyword("NOT");PascalHelp.Clear_selection;}
      factor
    ;


---------------------------------
--  BEGIN OF: VARIABLE ACCESS  --
---------------------------------

variable_access :
      inner_variable_access ;

inner_variable_access :
      identifier
    | composed_variable_access
    ;

composed_variable_access :
      function_call {null;}
    | pointer_dereference
    | inner_variable_access PERIOD_t {PascalHelp.put('.');} inner_variable_access
    | variable_access_with_brackets
    ;

function_call : inner_variable_access non_empty_params
    ;               -- A function_call could be an identifier, but this is
                    -- always made available when function_call is called.

-- * Access to an array element

variable_access_with_brackets :
      inner_variable_access
      LBRACK_t
      {PascalHelp.put('(');
       PascalHelp.Lost:= PascalHelp.Lost_in_selection;
       PascalHelp.Select_one_dimension;
       if not (PascalHelp.Lost or PascalHelp.First_dim_selected) then
         PascalHelp.Put_translation_comment("Write (a,b) instead of (a)(b) !");
       end if;
       }
      index_expression_list
      RBRACK_t
      {PascalHelp.put(')');PascalHelp.Close_one_dimension;}
    ;

index_expression_list :
      index_expression_list
      index_separator
      {PascalHelp.Close_one_dimension;
       PascalHelp.Lost:= PascalHelp.Lost_in_selection;
       PascalHelp.Select_one_dimension;
       -- ^as if [a][b] == [a,b], avoids having to
       --  remember to close > 1 dimensions
       if PascalHelp.First_dim_selected and not PascalHelp.Lost then
         PascalHelp.Put(")("); -- In Pascal, [a][b] == [a,b], not in Ada
       else
         PascalHelp.Put(',');
       end if;
      }
      index_expression
    | index_expression
    ;

index_expression : expression ;

index_separator  :
   COMMA_t |
   COLON_t {PascalHelp.Put_translation_comment("special array - mem ?");}
   -- Borland's mem[a:b] !
   ;

-- * Access to a pointed item

pointer_dereference :
     inner_variable_access UPARROW_t
     {PascalHelp.put(".all"); PascalHelp.Select_pointed;}
    ;

-------------------------------
--  END OF: VARIABLE ACCESS  --
-------------------------------

unsigned_number :
      CONSTANT_t    {PascalHelp.Put_Decimal(YYText);}
    | HEXADECIMAL_t {PascalHelp.Put_Hexadecimal(YYText);}
    ;

set_constructor :
      LBRACK_t
      {PascalHelp.put("(");}
      set_constructor_contents
      {PascalHelp.put_keyword("OTHERS");
       PascalHelp.put(" => False) ");}
      RBRACK_t ;

set_constructor_contents :
      member_designator_list {PascalHelp.put(" => True, ");}
    | -- EMPTY
    ;

member_designator_list :
      member_designator_list comma {PascalHelp.put('|');} member_designator
    | member_designator
    ;

member_designator : member_designator DOUBLEDOT_t {PascalHelp.put("..");}
    expression
    | expression
    ;

addop : the_addop {PascalHelp.Clear_Selection;} ;

the_addop:
      PLUS_t {PascalHelp.put('+');}
    | MINUS_t {PascalHelp.put('-');}
    | OR_t {PascalHelp.put_keyword(" OR ");}
    | OR_ELSE_t {PascalHelp.put_keyword(" OR ELSE ");} -- 12-Jan-2003 (ISO Ext.)
    | BAR_t {PascalHelp.put_keyword(" OR ELSE ");} -- Added 9-Jan-2003 (CWP)
    | XOR_t {PascalHelp.put_keyword(" XOR ");}
    ;

mulop : the_mulop {PascalHelp.Clear_Selection;} ;

the_mulop :
      TIMES_t {PascalHelp.put('*');}
    | DIVIDE_t {PascalHelp.put('/');}
    | DIV_t {PascalHelp.put("  /  ");}
    | MOD_t {PascalHelp.Put_MOD;}
    | AND_t {PascalHelp.put_keyword(" AND ");}
    | AND_THEN_t {PascalHelp.put_keyword(" AND THEN ");} -- 12-Jan-2003 (ISO Ext.)
    | SHL_t {PascalHelp.put(" * (2 ** "); PascalHelp.Open_Shift;}
    | SHR_t {PascalHelp.put(" / (2 ** "); PascalHelp.Open_Shift;}
    | AMPERSAND_t {PascalHelp.put_keyword(" AND THEN ");} -- Was '&' 9-Jan-2003 (CWP)
    | DOUBLESTAR_t {PascalHelp.put("**");}
    ;

relop : the_relop {PascalHelp.Clear_Selection;} ;

the_relop :
      EQUAL_t {PascalHelp.put('=');}
    | NE_t {PascalHelp.put("/=");}
    | LT_t {PascalHelp.put('<');}
    | GT_t {PascalHelp.put('>');}
    | LE_t {PascalHelp.put("<=");}
    | GE_t {PascalHelp.put(">=");}
    | {PascalHelp.DirectIO:= False;}
      -- Bug: this should be before the left simple_expression,
      -- but ayacc collapses
      IN_t
      {PascalHelp.DirectIO:= True;
       PascalHelp.member_of:= True;
       PascalHelp.put_keyword("AND");}
    ;

new_identifier : ID_t {
      declare
        id: constant String:= YYtext(1..YYLength);
      begin
        PascalHelp.Memorize_identifier( id, id );
        -- NB: no Ada alias, the programmer want THIS name!
        -- But PascalHelp will add a prefix to Ada's id in
        -- case it hits a keyword
        $$.length:= id'length; $$.text(1..id'length):=id;
        PascalHelp.Put( PascalHelp.Recent_identifier(0) );
        -- = id, plus an eventual keyword-avoiding prefix
      end;
      }
    | masked_identifier
    ;

identifier : ID_t {
      declare
        Pascal_id: constant String:= YYtext(1..YYLength);
        Up_Pas_id: constant String:= To_Upper(Pascal_id);
      begin
        PascalHelp.Select_identifier( Pascal_id );
        declare
          Ada_id : constant String:= PascalHelp.Find_alias( Pascal_id );
        begin
          PascalHelp.Memorize_identifier( Ada_id, Pascal_id );
          IF PascalHelp.function_result_flag and then
             PascalHelp.Function_in_stack( Pascal_id ) THEN
             PascalHelp.put("Result_");
          END IF;

          $$.length:= Ada_id'length; $$.text(1..Ada_id'length):=Ada_id;

          if Up_Pas_id="NIL" then
            PascalHelp.Put_keyword(Ada_id); -- "null" is a keyword
          elsif Ada_id = "return" then -- Was an unmasked "exit"
            PascalHelp.function_result_flag:= False;
            PascalHelp.Put_keyword("return");
            if PascalHelp.Is_last_a_function then
              PascalHelp.Put(" Result_"); PascalHelp.Put_last_Ada_subprog_name;
            end if;
          elsif Ada_id = "exit" then
            PascalHelp.Put_keyword("exit");
          elsif To_Upper(Ada_id) = Up_Pas_id and then Up_Pas_id /= "ABS" then
            -- Not Adaliased, but maybe the Pascal id is an Ada keyword.
            -- For example, an redefined "Exit" function.
            -- In that case, Memorize_identifier above has put a prefix to Ada_id.
            PascalHelp.Put(PascalHelp.Recent_identifier(0));
          else
            PascalHelp.Put(Ada_id);
          end if;
          -- To be absolutely correct, we should grab the type of the
          -- possibly masked identifier!
          if Up_Pas_id = "TRUE" or Up_Pas_id = "FALSE" then
            $$.vartype := boolean_type;
          else
            $$.vartype := other_type;
          end if;
        end;
      end;
      }
    | masked_identifier
    ;

masked_identifier :
      STR_t  {PascalHelp.Put_masked_keyword("str"); }
      -- 7-Jan-2003 if a declaration masks Str (81/92) <- (78/89)
    | DEC_t  {PascalHelp.Put_masked_keyword("dec"); } -- 9-Jan-2003
    | INC_t  {PascalHelp.Put_masked_keyword("inc"); } -- 9-Jan-2003
    | FORWARD_t  {PascalHelp.Put_masked_keyword("forward"); }  -- 11-Feb-2003
    | EXTERNAL_t {PascalHelp.Put_masked_keyword("external"); } -- 11-Feb-2003
;

comma : COMMA_t
    ;

%%

-- p2ada
-- a source converter from Pascal MacOS to Ada
-- original version Martin C. Carlisle (November 1996)
-- mcc@cs.usafa.af.mil
-- http://www.usafa.af.mil/dfcs/bios/carlisle.html

-- extended for MacOS by Laurent Gasser (June 1997)
-- lga@sma.ch

with Pascal_Tokens, Pascal_Shift_Reduce, Pascal_Goto, Pascal_IO;
use  Pascal_Tokens, Pascal_Shift_Reduce, Pascal_Goto, Pascal_IO;
with Pascal_DFA, YYroutines, Text_IO, PascalHelp, YYerror;
use  Pascal_DFA, YYroutines, Text_IO;
with Ada.Characters.Handling;           use Ada.Characters.Handling;

##
