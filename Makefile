# How to view output files
VIEWER  = zathura

# Clear built-in rules
.SUFFIXES:

.PHONY: default all dvi ps pdf view clean powerclean

# Figure out what we're making
input = $(patsubst %.tex,%,$(wildcard *.tex))

# Do not delete these files
secondaries = .aux .bbl .dvi
.SECONDARY: $(patsubst .%,$(input).%,$(secondaries))

default: pdf

# build everything
all: ps pdf view-pdf

# The output files
dvi: *.dvi
ps:  *.ps
pdf: *.pdf

# Default view
view: view-pdf

# --- PDF ---------------------------------------
%.pdf: %.dvi
	@echo "PDF  $<"
	@dvipdf -q $<

# --- PS ----------------------------------------
%.ps: %.dvi
	@echo "PS   $<"
	@dvips -q $<

# --- DVI ---------------------------------------
%.dvi: %.tex %.toc
	@echo "TEX  $<"
	@latex $< >/dev/null

# --- TOC ---------------------------------------
%.toc: %.tex
	@echo "TOC  $<"
	@latex $< >/dev/null

# If using sources, add BBL dependency to TOC
# --- BBL ---------------------------------------
# %.bbl: %.aux %.tex *.bib 
# 	@echo "BIB  $<"
# 	@bibtex $< >/dev/null

# --- AUX ---------------------------------------
%.aux: %.tex 
	@echo "AUX  $<"
	@latex -draftmode $< >/dev/null

# --- VIEW --------------------------------------
view-%: %
	${VIEWER} *.$* &

clean:
	@rm -vf *.aux *.log *.dvi *.lof *.lot *.toc *.bbl *.blg *.out

powerclean: clean
	@rm -vf *.pdf *.ps
