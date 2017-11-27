# hsklclasses
## Die inoffiziellen LaTeX-Klassen der Hochschule Kaiserslautern

### Vollständiges Beispiel
Das vollständige Beispiel ist so konzipiert, dass jeder verfügbare
Befehl wenigstens einmal verwendet wird (teilweise auskommentiert). Ebenso sind
sämtlich Optionen gelistet (ebenfalls teilweise auskommentiert) und auch eine
grobe, beispielhafte Kapitelstruktur ist vorgegeben. Wer diese Vorlage mit
seinen persönlichen Daten ausfüllt und eigene Inhalte ergänzt, muss sich kaum
noch um die Formatierung kümmern. Wenn ein Befehl unklar sein sollte, hilft im
Zweifel ein Blick in die Doku.

Damit das vollständige Beispiel ausführbar ist, müssen nach dem Download die
Dateien `hsklbook.cls`, `hsklbase.sty`, `hskldictionary-English.dict` und
`hskldictionary-German.dict` in den Ordner kopiert werden!

### Makefile
Das Makefile ist ein Vorschlag zum automatisierten Erstellen von LaTeX-Projekten.

Die Variablen `SOURCEFILE` und `BIBLIOGRAPHY` müssen an die Namen der Haupt-.tex-Datei
und der .bib-Datei angepasst werden. Die Dateiendung wird dabei weggelassen,
statt `datei.tex` etwa `datei`.

Mit der Variablen THELATEX wird die LaTeX Engine eingestellt. Je nach Projekt trägt
man hier `latex`, `pdflatex`, `xelatex` oder `lualatex` ein.

### Dokumentation
Die Dokumentation listet Beschreibungen und Erklärungen aller neu eingeführten
Befehle auf. Die Quelldaten finden sich im Ordner `Quelle_Dokumentation`. Um die
Dokumentation zu kompilieren, müssen die Dateien `hsklarticle.cls`,
`hsklbase.sty`, `hskldictionary-English.dict` und `hskldictionary-German.dict`
in den Ordner kopiert werden.
