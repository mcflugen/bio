NAME=huttone
CV=$(NAME)-two-page-cv
BIBDIR=../bib
BIBFILES=$(BIBDIR)/$(NAME)-inpress.bib \
				 $(BIBDIR)/$(NAME)-abstracts.bib \
				 $(BIBDIR)/$(NAME)-citations.bib \
				 $(BIBDIR)/$(NAME)-proceedings.bib \
				 $(BIBDIR)/$(NAME)-five-most-recent.bib \
				 ./$(NAME)-five-relevant.bib

# Write stdout here
#OUTPUT=/dev/null
OUTPUT=$(CV).out

# Use these commands
PDFLATEX=pdflatex
BIBTEX=bibtex
RM=/bin/rm
ECHO=/usr/bin/printf

# Use these compile flags
LATEXFLAGS=-halt-on-error -interaction=batchmode
BIBTEXFLAGS=

PASS='\033[00;32mPASS\033[00m\n'
FAIL="\033[00;31mFAIL\033[00m\n"

.PHONY: clean

all: $(CV).pdf

$(CV).pdf: $(CV).tex $(BIBFILES)
	@$(RM) -f $(OUTPUT) 2> /dev/null || true
	@$(ECHO) "$(PDFLATEX) $(CV).tex... "
	@($(PDFLATEX) $(LATEXFLAGS) $(CV).tex > $(OUTPUT) && $(ECHO) $(PASS)) || $(ECHO) $(FAIL) 
	@for file in $(CV)[1-9].aux ; \
	do \
		$(ECHO) "$(BIBTEX) $$file... " ; \
		($(BIBTEX) $(BIBTEXFLAGS) $$file >> $(OUTPUT) && $(ECHO) $(PASS)) || $(ECHO) $(FAIL) ; \
	done
	@$(ECHO) "$(PDFLATEX) $(CV).tex... "
	@($(PDFLATEX) $(LATEXFLAGS) $(CV).tex > $(OUTPUT) && $(ECHO) $(PASS)) || $(ECHO) $(FAIL)
	@$(ECHO) "$(PDFLATEX) $(CV).tex... "
	@($(PDFLATEX) $(LATEXFLAGS) $(CV).tex > $(OUTPUT) && $(ECHO) $(PASS)) || $(ECHO) $(FAIL)
	@$(ECHO) "$(CV).pdf successfully created.\n"

clean:
	@$(RM) -f $(CV).log $(CV).out *aux *bbl *blg 

nuke: clean
	@$(RM) -f $(CV).pdf

pdf: all clean

