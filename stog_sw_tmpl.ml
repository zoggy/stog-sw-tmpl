
let index = [%xtmpl "tmpl/index.html"]

(*c==v=[File.file_of_string]=1.1====*)
let file_of_string ~file s =
  let oc = open_out file in
  output_string oc s;
  close_out oc
(*/c==v=[File.file_of_string]=1.1====*)

let gen_file ~outdir xmls path =
  let file = Filename.concat outdir path in
  file_of_string ~file (Xtmpl.string_of_xmls xmls)

let generate ~outdir ~sw_name =
  let files =
    [ index ~sw_name (), "index.html" ;

    ]
  in
  List.iter
    (fun (xmls, path) -> gen_file ~outdir xmls path)
    files

let print_templates () = print_endline Stog_install.templates_dir; exit 0
let print_modules () = print_endline Stog_install.modules_dir; exit 0
let outdir = ref Filename.current_dir_name
let name = ref "Mysoftware"

let options = [
  "--templates", Arg.Unit print_templates, " print templates directory and exit";
  "--modules", Arg.Unit print_templates, " print modules directory and exit";
  "-d", Arg.Set_string outdir, "<dir> output to <dir> instead of current directory" ;
  "-n", Arg.Set_string name, "<name> set name of the software in the generated files" ;
  ]

let usage = Printf.sprintf "Usage: %s [options]\nwhere options are:" Sys.argv.(0)

let main () =
  Arg.parse options (fun _ -> ()) usage;
  generate ~outdir: !outdir ~sw_name: !name

(*c==v=[Misc.safe_main]=1.0====*)
let safe_main main =
  try main ()
  with
    Failure s
  | Sys_error s ->
      prerr_endline s;
      exit 1
(*/c==v=[Misc.safe_main]=1.0====*)

let () = safe_main main