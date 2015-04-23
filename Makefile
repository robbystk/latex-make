# File names
BASE	= proposal
SOURCES = sources

# How to view output files
VIEWER  = zathura

.SUFFIXES:
.SUFFIXES:.ps .pdf .dvi .tex .toc .aux .bbl .bib

.PHONY: default all dvi ps pdf view view-ps view-pdf clean powerclean

# What should 'make' run by default ?
default: pdf

# build everything
all: ps pdf view-pdf

# The output files
dvi: ${BASE}.dvi
ps:  ${BASE}.ps
pdf: ${BASE}.pdf

# Default view
view: view-ps

# --- PDF ---------------------------------------
.dvi.pdf:
	@echo "PDF  $<"
	@dvipdf -q $<

# --- PS ----------------------------------------
.dvi.ps:
	@echo "PS   $<"
	@dvips -q $<

# --- DVI ---------------------------------------
${BASE}.dvi: ${BASE}.aux ${BASE}.toc ${BASE}.tex
	@echo "TEX  ${BASE}.tex"
	@latex ${BASE}.tex >/dev/null

# --- TOC ---------------------------------------
${BASE}.toc: ${BASE}.tex
	@echo "TOC  ${BASE}.tex"
	@latex -draftmode ${BASE}.tex >/dev/null

# --- AUX ---------------------------------------
${BASE}.aux: ${BASE}.tex ${BASE}.bbl
	@echo "TEX  ${BASE}.tex"
	@latex -draftmode ${BASE}.tex >/dev/null

# --- BBL ---------------------------------------
${BASE}.bbl: ${BASE}.aux ${SOURCES}.bib 
	@echo "BIB  ${BASE}.aux"
	@bibtex ${BASE}.aux >/dev/null

# --- VIEW --------------------------------------
view-%: ${BASE}.%
	${VIEWER} $<

clean:
	@rm -vf *.aux *.log *.dvi *.lof *.lot *.toc

powerclean: clean
	@rm -vf *.pdf *.ps

