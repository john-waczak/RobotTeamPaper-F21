PROJECT = 'Paper'
MAIN = template

TEX_SOURCES = Makefile \
							$(MAIN).tex \
							references.bib

FIGURES := $(shell find ./images/* -type f)

SHELL=/bin/bash
DATE = $(shell date +"%d%b%Y")

OPT = --interaction=nonstopmode


all: $(MAIN).pdf


# add -pvc for continuous recompilation on save
$(MAIN).pdf: $(TEX_SOURCES) $(FIGURES)
	# latexmk -pdf -pvc -pdflatex="pdflates $(OPT)" $(MAIN)
	latexmk -pdf $(MAIN)

clean:
	-rm -f $(MAIN).{pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls,fdb_latexmk} final.pdf


zip:
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) clean
	zip -q $(PROJECT)_$(DATE).zip $(TEX_SOURCES) $(FIGURES)


# don't allow another file to be named clean or all
.PHONY: clean all
