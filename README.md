# stog-sw-tmpl

Generate [Stog](https://zoggy.github.io/stog/) files for a software static web site.

## Compilation and installation

You need Stog >= 0.14.0 to be installed.

````
git clone https://github.com/zoggy/stog-sw-tmpl.git
cd stog-sw-tmpl
make all install
````

This will install the `stog-sw-tmpl` package and some new files
in the `modules` and `templates` directories of Stog.

## Usage

`stog-sw-tmpl` generates some files for a software web site:
`index.html`, `doc.html`, `blog.html`, ..., with some images
and a `Makefile`. Then you just have to start editing the
generated files to add content for your site.

````
mkdir dir
cd dir
stog-sw-tmpl # beware this generates files in the current directory
             # but you can use -d to output files somewhere else
make test    # have a look at file:///tmp/index.html
make server  # then browse http://localhost:8080 to have a preview
             # while # modifying the generated files
````

See [the Stog documentation](https://zoggy.github.io/stog/doc.html).


