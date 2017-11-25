SOURCEFILE=Main
BIBLIOGRAPHY=Literatur
THELATEX=lualatex


.PHONY: all
all: $(SOURCEFILE).pdf

$(SOURCEFILE).pdf: $(SOURCEFILE).tex $(SOURCEFILE).bbl $(SOURCEFILE).ind
	$(THELATEX) $(SOURCEFILE).tex
	$(THELATEX) $(SOURCEFILE).tex
	$(THELATEX) $(SOURCEFILE).tex
	@touch -c $(SOURCEFILE).bbl
	@touch -c $(SOURCEFILE).ind

#Erzeugt Bibliografie
$(SOURCEFILE).bbl: $(BIBLIOGRAPHY).bib $(SOURCEFILE).bcf
	biber $(SOURCEFILE)


#Erzeugt Index
$(SOURCEFILE).ind: $(SOURCEFILE).idx
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).alg -o $(SOURCEFILE).acr $(SOURCEFILE).acn
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).glg -o $(SOURCEFILE).gls $(SOURCEFILE).glo
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).slg -o $(SOURCEFILE).syi $(SOURCEFILE).syg



$(SOURCEFILE).bcf: $(SOURCEFILE).tex
	$(THELATEX) $(SOURCEFILE).tex

$(SOURCEFILE).idx: $(SOURCEFILE).tex
	$(THELATEX) $(SOURCEFILE).tex

clean:
	rm -vf $(SOURCEFILE).{aux,bbl,bcf,blg,log,out,run.xml,toc}
