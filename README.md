# stog-sw-tmpl

Generate [Stog](https://zoggy.github.io/stog/) files for a software static web site.

## Compilation and installation

You need [Stog](https://zoggy.github.io/stog/) >= 0.14.0 to be installed
and [ppx_blob](https://github.com/johnwhitington/ppx_blob)

````
$ git clone https://github.com/zoggy/stog-sw-tmpl.git
$ cd stog-sw-tmpl
$ make all install
````

This will install the `stog-sw-tmpl` package and some new files
in the `modules` and `templates` directories of Stog.

## Usage

`stog-sw-tmpl` generates some files for a software web site:
`index.html`, `doc.html`, `blog.html`, ..., with some images
and a `Makefile`. Then you just have to start editing the
generated files to add content for your site.

````
$ mkdir dir
$ cd dir
$ ocamlfind stog-sw-tmpl/stog-sw-tmpl
    # beware this generates files in the current directory
    # but you can use -d to output files somewhere else
$ tree
|-- about.html
|-- blog.html
|-- doc.html
|-- download.html
|-- index.html
|-- Makefile
|-- next.png
|-- posts
|   |-- first-post.html
|   `-- release-0.1.0.html
|-- rss.png
`-- style.css
$ make test    # have a look at file:///tmp/index.html
$ make server  # then browse http://localhost:8080 to have a preview
               # while # modifying the generated files
````

See [the Stog documentation](https://zoggy.github.io/stog/doc.html).


