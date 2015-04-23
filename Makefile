# File name
BASE	= proposal

# How to view output files
VIEWER  = zathura

.SUFFIXES:
.SUFFIXES:.ps .pdf .dvi .tex .uxf .eps .toc .lof .lot

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

# --- DVI ---------------------------------------
${BASE}.dvi: ${BASE}.toc ${BASE}.tex
	@echo "TEX  ${BASE}.tex"
	@latex ${BASE}.tex >/dev/null

# --- TOC ---------------------------------------
${BASE}.toc: ${figures} ${BASE}.tex
	@echo "TOC  ${BASE}.tex"
	@latex -draftmode ${BASE}.tex >/dev/null

# --- PS ----------------------------------------
.dvi.ps:
	@echo "PS   $<"
	@dvips -q $<

# --- PDF ---------------------------------------
.dvi.pdf:
	@echo "PDF  $<"
	@dvipdf -q $<

# --- VIEW --------------------------------------
view-%: ${BASE}.%
	${VIEWER} $<

clean:
	rm -vf *.aux *.log *.dvi *.lof *.lot *.toc

powerclean: clean
	rm -vf *.pdf *.ps

