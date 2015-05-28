
let print_templates () = print_endline Stog_install.templates_dir; exit 0
let print_modules () = print_endline Stog_install.modules_dir; exit 0

let options = [
  "--templates", Arg.Unit print_templates, " print templates directory and exit";
  "--modules", Arg.Unit print_templates, " print modules directory and exit";
  ]

let usage = Printf.sprintf "Usage: %s [options]\nwhere options are:" Sys.argv.(0)

let main () =
  Arg.parse options (fun _ -> ()) usage

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