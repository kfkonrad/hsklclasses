SOURCEFILE=Bachelorarbeit
BIBLIOGRAPHY=literatur
THELATEX=lualatex
SHELLESCAPE=-shell-escape
#Einkommentieren um shell escaping zu verhindern
SHELLESCAPE=

.PHONY: all fatlady quick qquick $(SOURCEFILE).pdf $(SOURCEFILE).bbl $(SOURCEFILE).ind $(SOURCEFILE).bcf $(SOURCEFILE).idx clean open

all: $(SOURCEFILE).pdf

fatlady: #it's not over until the fat lady sings.
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) clean
	$(MAKE) open

quick:
	$(THELATEX) $(SHELLESCAPE) $(SOURCEFILE).tex

qquick:
	$(THELATEX) --draftmode $(SHELLESCAPE) $(SOURCEFILE).tex
	$(THELATEX) $(SHELLESCAPE) $(SOURCEFILE).tex

$(SOURCEFILE).pdf: $(SOURCEFILE).tex $(SOURCEFILE).bbl #$(SOURCEFILE).ind
	$(THELATEX) --draftmode $(SHELLESCAPE) $(SOURCEFILE).tex
	$(THELATEX) --draftmode $(SHELLESCAPE) $(SOURCEFILE).tex
	$(THELATEX) $(SHELLESCAPE) $(SOURCEFILE).tex
	@touch -c $(SOURCEFILE).bbl
	@touch -c $(SOURCEFILE).ind
	@touch -c $(SOURCEFILE).pdf

#Erzeugt Bibliografie
$(SOURCEFILE).bbl: $(BIBLIOGRAPHY).bib $(SOURCEFILE).bcf $(SOURCEFILE).tex
	biber $(SOURCEFILE)


#Erzeugt Index
$(SOURCEFILE).ind: $(SOURCEFILE).idx $(SOURCEFILE).tex
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).alg -o $(SOURCEFILE).acr $(SOURCEFILE).acn
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).glg -o $(SOURCEFILE).gls $(SOURCEFILE).glo
	makeindex -s $(SOURCEFILE).ist -t $(SOURCEFILE).slg -o $(SOURCEFILE).syi $(SOURCEFILE).syg



$(SOURCEFILE).bcf: #$(SOURCEFILE).tex
	$(THELATEX) --draftmode $(SHELLESCAPE) $(SOURCEFILE).tex

$(SOURCEFILE).idx: #$(SOURCEFILE).tex
	$(THELATEX) --draftmode $(SHELLESCAPE) $(SOURCEFILE).tex

clean:
	rm -vf $(SOURCEFILE).{aux,bbl,bcf,blg,log,out,run.xml,toc,acn,glo,idx,ist,lot,syg} ./kapitel/*.aux
	rm -rvf _minted-$(SOURCEFILE)

open:
	open $(SOURCEFILE).pdf
