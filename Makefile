SOURCEFILE=Anleitung_Celoplan
BIBLIOGRAPHY=Literatur
THELATEX=lualatex
SILENCE=2>/dev/null
#Auskommentieren für stummes Kompilieren
SILENCE=

.PHONY: all
all: $(SOURCEFILE).pdf

$(SOURCEFILE).pdf: $(SOURCEFILE).tex #$(SOURCEFILE).bbl $(SOURCEFILE).ind
	$(THELATEX) $(SOURCEFILE).tex $(SILENCE)
	$(THELATEX) $(SOURCEFILE).tex $(SILENCE)
	$(THELATEX) $(SOURCEFILE).tex $(SILENCE)
	@touch -c $(SOURCEFILE).bbl $(SILENCE)
	@touch -c $(SOURCEFILE).ind $(SILENCE)

#Erzeugt Bibliografie
$(SOURCEFILE).bbl: $(BIBLIOGRAPHY).bib $(SOURCEFILE).bcf
	biber $(SOURCEFILE) $(SILENCE)


#Erzeugt Index
$(SOURCEFILE).ind: $(SOURCEFILE).idx
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).alg -o $(SOURCEFILE).acr $(SOURCEFILE).acn $(SILENCE)
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).glg -o $(SOURCEFILE).gls $(SOURCEFILE).glo $(SILENCE)
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).slg -o $(SOURCEFILE).syi $(SOURCEFILE).syg $(SILENCE)



$(SOURCEFILE).bcf: $(SOURCEFILE).tex
	$(THELATEX) $(SOURCEFILE).tex $(SILENCE)

$(SOURCEFILE).idx: $(SOURCEFILE).tex
	$(THELATEX) $(SOURCEFILE).tex $(SILENCE)

clean:
	rm -vf $(SOURCEFILE).{aux,bbl,bcf,blg,log,out,run.xml,toc} $(SILENCE)
