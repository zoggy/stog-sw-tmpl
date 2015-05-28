
PACKAGE=stog-sw-tmpl
# DO NOT FORGET TO UPDATE META FILE
VERSION=0.1.0

OCAMLFIND=ocamlfind
PACKAGES=stog
COMPFLAGS=-annot -rectypes -safe-string -g
OCAMLPP=
OCAMLLIB:=`$(OCAMLC) -where`

RM=rm -f
CP=cp -f
MKDIR=mkdir -p

STOG_SW_TMPL=stog-sw-tmpl
STOG_SW_TMPL_BYTE=$(STOG_SW_TMPL).byte

CMXFILES=stog_sw_tmpl.cmx
CMOFILES=$(CMXFILES:.cmx=.cmo)
CMIFILES=$(CMXFILES:.cmx=.cmi)

all: byte opt
byte: $(STOG_SW_TMPL_BYTE)
opt: $(STOG_SW_TMPL)

$(STOG_SW_TMPL): $(CMIFILES) $(CMXFILES)
	$(OCAMLFIND) ocamlopt -o $@ -linkpkg -package $(PACKAGES) $(CMXFILES)

$(STOG_SW_TMPL_BYTE): $(CMIFILES) $(CMOFILES)
	$(OCAMLFIND) ocamlc -o $@ -linkpkg -package $(PACKAGES) $(CMOFILES)

TMPL_FILES:=$(shell find tmpl -name "*html")
stog_sw_tmpl.cmx: $(TMPL_FILES)
stog_sw_tmpl.cmo: $(TMPL_FILES)
%.cmx: %.ml %.cmi
	$(OCAMLFIND) ocamlopt -c -package $(PACKAGES) $(COMPFLAGS) $<

%.cmo: %.ml %.cmi
	$(OCAMLFIND) ocamlc -c -package $(PACKAGES) $(COMPFLAGS) $<

%.cmi: %.mli
	$(OCAMLFIND) ocamlc -c -package $(PACKAGES) $(COMPFLAGS) $<

######
clean:
	$(RM) *.cm* *.o *.a *.annot $(STOG_SW_TMPL) $(STOG_SW_TMPL_BYTE)

##########
install: all
	$(OCAMLFIND) install $(PACKAGE) META LICENSE \
		$(STOG_SW_TMPL) $(STOG_SW_TMPL_BYTE)
	export TDIR=`$(OCAMLFIND) $(PACKAGE)/$(STOG_SW_TMPL) --templates` ; \
	export MDIR=`$(OCAMLFIND) $(PACKAGE)/$(STOG_SW_TMPL) --modules` ; \
	$(MKDIR) $$TDIR $$MDIR ; \
	$(CP) templates/*.tmpl $$TDIR/ ;\
	$(CP) modules/*.stm $$MDIR/


uninstall:
	$(OCAMLFIND) remove $(PACKAGE)
