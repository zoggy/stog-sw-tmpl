
let about = [%xtmpl "tmpl/about.html"]
let blog = [%xtmpl "tmpl/blog.html"]
let doc = [%xtmpl "tmpl/doc.html"]
let download = [%xtmpl "tmpl/download.html"]
let first_post = [%xtmpl "tmpl/posts/first-post.html"]
let index = [%xtmpl "tmpl/index.html"]
let release_0_1_0 = [%xtmpl "tmpl/posts/release-0.1.0.html"]

(*c==v=[File.file_of_string]=1.1====*)
let file_of_string ~file s =
  let oc = open_out file in
  output_string oc s;
  close_out oc
(*/c==v=[File.file_of_string]=1.1====*)

let mkdir s =
  let qs = Filename.quote s in
  match Sys.command (Printf.sprintf "mkdir -p %s" qs) with
    0 -> ()
  | n -> failwith (Printf.sprintf "Could not create directory %s" qs)

let gen_file ~outdir xmls path =
  let file = Filename.concat outdir path in
  mkdir (Filename.dirname file) ;
  file_of_string ~file (Xtmpl.string_of_xmls xmls)

let generate ~outdir ~sw_name =
  let files =
    [
      about (), "about.html" ;
      blog ~sw_name (), "blog.html" ;
      doc (), "doc.html" ;
      download ~sw_name (), "download.html" ;
      first_post (), "posts/first-post.html" ;
      index ~sw_name (), "index.html" ;
      release_0_1_0 ~sw_name (), "posts/release-0.1.0.html" ;
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
  "--modules", Arg.Unit print_modules, " print modules directory and exit";
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