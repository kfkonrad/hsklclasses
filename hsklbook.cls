%Die folgenden Zeilen NICHT ÄNDERN (abgesehen vom Datum als Versionskontrolle)
\NeedsTeXFormat{LaTeX2e}
\def\hsversion{2.5b}
\ProvidesClass{hsklbook}[2017/11/06 hsklbook v\hsversion - Eine Book-Klasse fuer die Hochschule Kaiserslautern, basierend auf scrbook]

%% Anmerkung des Autors  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% In Klassen und Paketen wird per Konvention der Befehl             %%
%% \RequirePackage anstatt von \usepackage verwendet. Die Anwendung  %%
%% und Bedeutung der Befehle ist jedoch gleich.                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Changelog  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Version 2.0 - Dezember 2016                                       %%
%%%% Alte Vorlage in Dokumentenklassen ueberfuehrt                 %%%%
%%%% Einheitliche Titelei mit neuen Befehlen integriert            %%%%
%% Version 2.0.1 - Maerz 2017                                        %%
%%%% Pakete multicol, longtable & hologo erg�nzt                   %%%%
%%%% Umgebung hskltable f�r einheitliche Tabellen geschaffen       %%%%
%%%% Kodierungsfehler im Wort Ak�rzungsverzeichnis behoben         %%%%
%% Version 2.1 - Mai 2017                                            %%
%%%% Anpassungen an die Beduerfnisse einer Studienarbeit bei       %%%%
%%%% Adrian Mueller                                                %%%%
%%%% Sämtliche hsklXY-Befehle wurden der Lesbarkeit halber in      %%%%
%%%% hsXY umbenannt                                                %%%%
%% Version 2.2 - Mai 2017                                            %%
%%%% Option splitbib ergaenzt                                      %%%%
%%%%   Bislang wurde das Literaturverzeichnis immer in gedruckte   %%%%
%%%%   und Internet-Literatur unterschieden. Jetzt geschieht das   %%%%
%%%%   nur noch, wenn die Option splitbib genutzt wird. Ohne die   %%%%
%%%%   Option wird ein einzelnes, alle Quellen umfassendendes      %%%%
%%%%   Literaturverzeichnis erzeugt.                               %%%%
%%%% Bug behoben, durch den das Dokument nicht sauber kompiliert,  %%%%
%%%%   falls biblatex nicht von Hand eingebunden wird.             %%%%
%%%% Optionen lot zum Deaktivieren des Tabellenverzeichnisses      %%%%
%%%%    und lof zum Deaktivieren des Abbildungsverzeichnisses      %%%%
%%%%    ergänzt                                                    %%%%
%% Version 2.3b - August 2017                                        %%
%%%% Neue Optionsverarbeitung mit modernen key/value Optionen      %%%%
%%%% Zu den einzelnen Optionen siehe Dokumentation                 %%%%
%%%% Version 2.3 ist zugunsten von 2.4 nie final erschienen        %%%%
%% Version 2.4a - September 2017                                   %%%%
%%%% neuer Befehl: hslayout, zur Anwendung siehe Dokumentation     %%%%
%%%% hslayout manipuliert den automatischen Output von gewissen    %%%%
%%%%    Bestandteilen wissenschaflicher Arbeiten mittels selbst    %%%%
%%%%    definierter Hooks, die jeweils in hsfrontmatter,           %%%%
%%%%    hsmainmatter, hsbackmatter und AtEndDocument liegen        %%%%
%%%% neue Option custombiblatex für ein angepasstes Einbinden von  %%%%
%%%%    von biblatex mit abweichenden Zitierstilen                 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Ab hier darf nach Belieben veraendert werden    %%%%%%%%%%%%%%
%%%%%%%  (Auch wenn das selten notwendig sein sollte...) %%%%%%%%%%%%%%

\RequirePackage{scrbase}
\DefineFamily{hskl}
\DefineFamilyMember{hskl}

%Option shortprelims deklarieren. Hiermit wird eine verkuerzte Titelei, wie sie
%fuer Studienarbeiten bei Adrian Mueller im Studiengang Informatik ueblich sind,
%generiert. Die Titelei bleibt ausdruecklich auch für andere Module / Arbeiten
%verwendbar.

\newcommand{\hsboolTrue}[1]{%
  \ifcsname#1\endcsname
  \else
  \expandafter\newif\csname if#1\endcsname
  \csname #1true\endcsname
  \fi
}
\newcommand{\hsboolFalse}[1]{%
  \ifcsname#1\endcsname
  \else
  \expandafter\newif\csname if#1\endcsname
  \csname #1false\endcsname
  \fi
}
\newcommand{\hsbooloptionTrue}[2]
{
  \hsboolTrue{#2}
  \csname #1true\endcsname
  \FamilyBoolKey{hskl}{#1}{#2}
}
\newcommand{\hsbooloptionFalse}[2]
{
  \hsboolFalse{#2}
  \csname #1false\endcsname
  \FamilyBoolKey{hskl}{#1}{#2}
}

%\newif\iflof\loftrue
%\DeclareOption{nolof}{\loffalse}
\hsbooloptionTrue{listoffigures}{lof}

%\newif\ifshortprelims
%\shortprelimsfalse
%\DeclareOption{shortprelims}{\shortprelimstrue}
\hsbooloptionFalse{shortprelims}{shortprelims}

%\newif\iflot\lottrue
%\DeclareOption{nolot}{\lotfalse}
\hsbooloptionTrue{listoftables}{lot}

\newif\ifanytocs
\anytocsfalse

%\newif\ifsplitbib\splitbibfalse
%\DeclareOption{splitbib}{\splitbibtrue}
\hsbooloptionFalse{internetbibliography}{splitbib}

%\newif\iftitlepage\titlepagetrue
%\DeclareOption{notitlepage}{\titlepagefalse}
\hsbooloptionTrue{titlepage}{titlepage}

\hsbooloptionTrue{dedication}{hsdedication}

\hsbooloptionTrue{restrictionnote}{restrictionnote}

\hsbooloptionTrue{titlepage-showsupervisor}{titlepageSHOWsupervisor}
\hsbooloptionTrue{titlepage-showmatriculation}{titlepageSHOWmatriculation}

\hsbooloptionTrue{copyright-showname}{copySHOWname}%
\hsbooloptionTrue{copyright-showaddress}{copySHOWaddress}%
\hsbooloptionTrue{copyright-showpermanentcontact}{copySHOWpermanentcontact}%
\hsbooloptionFalse{copyright-multiauthor}{copySHOWmultiauthor}%

\hsbooloptionFalse{multiauthor}{SHOWmultiauthor}

\hsbooloptionFalse{custombiblatex}{custombiblatex}

\hsbooloptionFalse{smallereditionnotes}{smallereditionnotes}

%Damit werden alle sonstigen Optionen direkt an scrbook durchgeschleift
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\FamilyProcessOptions{hskl}

\ifSHOWmultiauthor
  \titlepageSHOWmatriculationfalse
  \copySHOWnamefalse
  \copySHOWaddressfalse
  \copySHOWpermanentcontactfalse
  \copySHOWmultiauthortrue
\fi

%\ProcessOptions\relax
\LoadClass{scrbook}

\RequirePackage{hsklbase}
\addtokomafont{date}{\vskip 4ex}
\RequirePackage{makeidx}
\makeindex %Index anschalten
%\setindexpreamble{Hier kann Ihr Text für den Index stehen}

%%  Glossar, Abkürzungen, Symbole  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% ACHTUNG Nachverarbeitung im Ausgabeprofil einstellen
%% Ausgabeprofil.tco  ins TeXnicCenter importieren
%% makeindex -s %tm.ist -t %tm.alg -o %tm.acr datei.acn
%% makeindex -s %tm.ist -t %tm.glg -o %tm.gls datei.glo
%% makeindex -s %tm.ist -t %tm.slg -o %tm.syi datei.syg
%%
\RequirePackage[
nonumberlist,                          %keine Seitenzahlen anzeigen
acronym,                               %ein Abkürzungsverzeichnis erstellen
section,                               %im Inhaltsverzeichnis auf Unterkapitelebene erscheinen
toc                                    %Einträge im Inhaltsverzeichnis
]{glossaries}

\newglossary[slg]                      %Ein eigenes Symbolverzeichnis erstellen
{symbolslist}{syi}{syg}{\translate{List of Symbols}}

\makeglossaries %Glossar-Befehle anschalten


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ein angepasster Titel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Befehlsdefinitionen
\setkomafont{author}{\LARGE}
\newcommand{\hslogofile}[1]{\def\hslogofilevalue{#1}}
\newcommand{\hsauthor}[1]{\author{#1}\def\hsnamevalue{\let\oldand\and\let\and\quad #1 \let\and\oldand}}
\newcommand{\hssubtitle}[1]{\subtitle{#1\\[-1.5ex]\quad}}
\newcommand{\hsdate}[1]{\date{#1}}
\newcommand{\hstitle}[1]{\title{#1}}
\newcommand{\hsmajor}[1]{\def\hsmajorvalue{#1}}
\newcommand{\hsmatriculation}[1]{\def\hsmatriculationvalue{#1}}
\newcommand{\hsaddress}[1]{\def\hsaddressvalue{#1}}
\newcommand{\hspermanentcontact}[1]{\def\hspermanentcontactvalue{#1}}
\def\hsyearvalue{\number\year}
\newcommand{\hsyear}[1]{\def\hsyearvalue{#1}}
\newcommand{\hsplaceofstudy}[1]{\def\hsplaceofstudyvalue{#1}}
\newcommand{\hsplaceofstudyaddress}[1]{\def\hsplaceofstudyaddressvalue{#1}}
\newcommand{\hssupervisorname}[1]{\def\hssupervisornamevalue{#1}}
\newcommand{\hssupervisorphone}[1]{\def\hssupervisorphonevalue{#1}}
\newcommand{\hssupervisormail}[1]{\def\hssupervisormailvalue{#1}}
\newcounter{supervisorcnt}
\setcounter{supervisorcnt}{2}
\def\hsaddsupervisorvalue{}
\def\hsaddmultiauthorvalue{}
\def\leftadd#1#2{\edef#1{\unexpanded{#2}\unexpanded\expandafter{#1}}}
\def\rightadd#1#2{\edef#1{\unexpanded\expandafter{#1}\unexpanded{#2}}}
\def\leftaddOnceExpand#1#2{\edef#1{#2\unexpanded\expandafter{#1}}}
\def\rightaddCS#1#2{\edef#1{\unexpanded\expandafter{#1}\unexpanded{\csname}#2\unexpanded{\endcsname}}}
\newcommand{\hsaddsupervisor}[3]
{
  \rightadd\hsaddsupervisorvalue{%
    \item[\arabic{supervisorcnt}\stepcounter{supervisorcnt}. \translate{supervisor (secondary)}] #1 \newline%
    \translate{Phone}: #2 \newline%
    Email: #3%
  }
}
\newcommand{\hsaddmultiauthor}[4]
{
  \rightadd\hsaddmultiauthorvalue{%
    #1 & #2 & #3 & #4\\
  }
}
\newcommand{\hsdistribution}[1]{\def\hsdistributionvalue{#1}}
\newcommand{\hsdedication}[1]{\def\hsdedicationvalue{#1}}
\newcommand{\hskindofpaper}[1]{\subject{#1}}
\newcommand{\hsworkenvironment}[1]{\def\hsworkenvironmentvalue{#1}}

\hsboolFalse{custom@any}

\NewDocumentCommand{\hslayout}{m m}
{
  \ifcustom@any\else
  \renewcommand\hs@hook@frontmatter{}
  \renewcommand\hs@hook@mainmatter{}
  \renewcommand\hs@hook@backmatter{}
  \renewcommand\hs@hook@end{}
    \custom@anytrue
  \fi
  \let\hs@this@printable\empty
  \ifthenelse{ \equal{#2}{title} }
    {\def\hs@this@printable{titling}}{}
  \ifthenelse{ \equal{#2}{restrictionnote} }
    {\def\hs@this@printable{restrictionnote}}{}
  \ifthenelse{ \equal{#2}{table of contents} }
    {\def\hs@this@printable{tableofcontents}}{}
  \ifthenelse{ \equal{#2}{tables of figures/tables} }
    {\def\hs@this@printable{tablesoffiguresandtables}}{}
  \ifthenelse{ \equal{#2}{abbreviations/glossary} }
    {\def\hs@this@printable{abbreviations}}{}
  \ifthenelse{ \equal{#2}{bibliography} }
    {\def\hs@this@printable{bibliography}}{}
  \ifthenelse{ \equal{#2}{appendix} }
    {\def\hs@this@printable{appendix}}{}
  \ifthenelse{ \equal{#2}{index} }
    {\def\hs@this@printable{index}}{}

  \ifx\hs@this@printable\empty\else
    \ifthenelse{ \equal{#1}{frontmatter} }
    {
    \rightaddCS\hs@hook@frontmatter{hs@printable@\hs@this@printable}
    %Nur zu Testzwecken verwenden
    %\leftaddOnceExpand\hs@hook@frontmatter{hs@printable@\hs@this@printable\unexpanded\expandafter{\newline}}
    }{}
    \ifthenelse{ \equal{#1}{mainmatter} }
    {
      \rightaddCS\hs@hook@mainmatter{hs@printable@\hs@this@printable}
    }{}
    \ifthenelse{ \equal{#1}{backmatter} }
    {
      \rightaddCS\hs@hook@backmatter{hs@printable@\hs@this@printable}
    }{}
    \ifthenelse{ \equal{#1}{end} }
    {
    \rightaddCS\hs@hook@end{hs@printable@\hs@this@printable}
    }{}
  \fi
}

%% Textbefehle für den Titleback: Copyrighttexte & Co.
\newcommand{\hscopyrighttext}[1]{\def\hscopyrighttextvalue{#1}}
\hscopyrighttext
{
Das Werk einschlie\ss{}lich aller Abbildungen ist urheberrechtlich gesch\"utzt.
Jede Verwertung au\ss{}erhalb der Grenzen des Urheberrechts ist ohne Zustimmung des Autors unzul\"assig und strafbar.
Das gilt insbesondere f\"ur Vervielf\"altigungen, \"Ubersetzungen, Mikroverfilmungen und die Einspeicherung und Bearbeitung in elektronischen Systemen.
}

\newcommand{\hscopyrightowner}[1]{\def\hscopyrightownervalue{#1}}
\hscopyrightowner
{
Hochschule Kaiserslautern, Studienort \hsplaceofstudyvalue
}

\newcommand{\hsfurthernotices}[1]{\def\hsfurthernoticesvalue{#1}}
\hsfurthernotices
{
Alle in der Arbeit angef\"uhrten Gebrauchsnamen, Handelsnamen, Marken, Warenzeichen usw. sind Eigentum ihrer jeweiligen Inhaber.
Die Verwendung auch ohne besondere Kennzeichnung bedeutet nicht die freie Verf\"ugbarkeit dieser Namen.
\par
Bei direkten oder indirekten Bez\"ugen oder Zitaten aus Gesetzen, Normen, Standards oder Richtlinien
kann keine Gew\"ahr f\"ur Aktualit\"at, Richtigkeit oder Vollst\"andigkeit \"ubernommen werden.
F\"ur die eigene Arbeit empfiehlt es sich, immer die vollst\"andigen Dokumente in der jeweils g\"ultigen Fassung zu benutzen.
\par
Diese Darstellung wurde nach bestem Wissen und Gewissen und den Regeln wissenschaftlicher Werke erstellt.
Sie stellt insofern nur die Ergebnisse der Arbeiten dar, insbesondere der Literatur und Quellenstudien zum Thema.
\par
Genderspezifische Schreibweisen wurden nicht explizit ber\"ucksichtigt.
Wo immer m\"oglich wurde geschlechtsneutral formuliert.
Wenn nur die m\"annliche Form benutzt wird, bedeutet dies,
dass es sich um eine Funktionsbezeichnung oder Rolle handelt.
}

\newcommand{\hsprintcountry}[1]{\def\hsprintcountryvalue{#1}}
\hsprintcountry{Germany}

\newcommand{\hsfurthereditionnotes}[1]{\def\hsfurthereditionnotesvalue{#1}}
\let\hsfurthereditionnotesvalue\@empty

\DeclareRobustCommand{\wiebefehl}[1]{\texttt{\textbackslash#1}}

% Inititalwerte
\hslogofile{Position des Logos im Ordner mit \wiebefehl{hslogofile} angeben}
\hstitle{\wiebefehl{hstitle\{Titel der Arbeit\}}}
\hsdate{\today}
\hsmajor{\wiebefehl{hsmajor\{Name des Studiengangs\}}}
\hsmatriculation{\wiebefehl{hsmatriculation\{Matrikelnummer\}}}
\hsaddress{\wiebefehl{hsaddress\{Eigene Adresse\}}}
\hspermanentcontact{\wiebefehl{hspermanentcontact\{Permanente Kontaktdaten\}}}
\hsplaceofstudy{\wiebefehl{hsplaceofstudy\{Studienort\}}}
\hsplaceofstudyaddress{\wiebefehl{hsplaceofstudyaddress\{Adresse des Studienorts (bzw. des Copyrightinhabers, sofern abweichend), einzeilig\}}}
\hssupervisorname{\wiebefehl{hssupervisorname\{Name des Betreuers\}}}
\hssupervisorphone{\wiebefehl{hssupervisorphone\{Name des Betreuers\}}}
\hssupervisormail{\wiebefehl{hssupervisormail\{Name des Betreuers\}}}
\hsdistribution{\wiebefehl{hsdistribution\{LaTeX Distribution (Mik\textbackslash{}TeX oder \textbackslash{}TeX\textasciitilde{}Live)\}}}
\hsdedication{De gustibus non est disputandum. \par \wiebefehl{hsdedication\{Widmung/Zueignung\}}}
\hskindofpaper{\wiebefehl{hskindofpaper\{Art der Arbeit (Bachelorarbeit, Praxisbericht etc.)\}}}
\hsworkenvironment{\wiebefehl{hsworkenvironment\{Arbeitsumgebung, also z.B. \textbackslash{}TeX\{\}nicCenter\}}}


%Eigentliche Titelei
%Erzwingt zweiseitiges Titellayout auch bei einseitigen Dokumenten
\leftadd\maketitle{%
  \let\@hskl@actual@twoside\if@twoside%
  \let\@hskl@actual@clearpage\clearpage%
  \let\clearpage\relax%
  \@twosidetrue%
}
\rightadd\maketitle{%
  \let\if@twoside\@hskl@actual@twoside%
  \let\clearpage\@hskl@actual@clearpage%
}
\leftadd\next@tdpage{\let\clearpage\@hskl@actual@clearpage}
\rightadd\next@tdpage{\let\clearpage\relax}

\titlehead{\includegraphics[width=\ScaleByXIfNeeded{0.75}]{\hslogofilevalue}}
%%%\subject{Bachelorarbeit}
%%%\title{Titel der Arbeit}
%%%\author{\LARGE Name des Studierenden}
%%%\date{\today}							% falls anderes, als das aktuelle gewünscht

\publishers{\translate{Degree Course}: \hsmajorvalue
				\iftitlepageSHOWmatriculation
          \\\translate{Matriculation}: \hsmatriculationvalue
        \fi
        \iftitlepageSHOWsupervisor
          \\\enlargethispage{3\baselineskip}\vfill\vfill\vfill\vfill
          \translate{supervisor (short)}: \hssupervisornamevalue
        \fi
}

\uppertitleback{%
\enlargethispage{5\baselineskip}
\footnotesize
\hsboolFalse{copySHOWany}
\ifcopySHOWname\copySHOWanytrue \hsnamevalue \newline\fi
\ifcopySHOWaddress\copySHOWanytrue \hsaddressvalue \newline\fi
\ifcopySHOWpermanentcontact\copySHOWanytrue \hspermanentcontactvalue \newline\fi
\ifcopySHOWmultiauthor
  \scriptsize
  \begin{longtable}{llll}
    \toprule
    \translate{Name} & \translate{Matric.} & \translate{Address} & \translate{Permanent Contact}\\\midrule
    \hsaddmultiauthorvalue
    \bottomrule
  \end{longtable}
  \extravspace
  \extravspace
  \extravspace
\fi

\footnotesize
\hscopyrighttextvalue
\extravspace

\small
\copyright\  Copyright \hsyearvalue\ by \hscopyrightownervalue

\small\hsplaceofstudyaddressvalue

\small Printed in \hsprintcountryvalue

\extravspace

\footnotesize
\hsfurthernoticesvalue
}

\lowertitleback{
\footnotesize
\begin{description}
	\item[\translate{supervisor (primary)}] \hssupervisornamevalue \newline
	\translate{Phone}: \hssupervisorphonevalue \newline
Email: \hssupervisormailvalue
\hsaddsupervisorvalue
\end{description}
\vspace{-.3ex}
\ifsmallereditionnotes
  \scriptsize\extravspace
\fi
\translate{Typesetting System}:\enskip \translate{setting copy}\\
\translate{Automated Typsetting System}:\enskip \LaTeX{} -- KOMA-Script -- \translate{Distribution} \hsdistributionvalue\\
\translate{Environment}:\enskip \hsworkenvironmentvalue\ -- \translate{Bibliography} Bib\LaTeX~\&~Biber\\
\translate{Thesis Template}: \HSKLbook K. Konrad \& M. W\"olker 2013--2017 -- Version \hsversion%
\ifx\hsfurthereditionnotesvalue\@empty
\else
  \\[0.5ex] \hsfurthereditionnotesvalue
\fi
}

\ifshortprelims
  \let\@uppertitleback\@empty
  \let\@lowertitleback\@empty
\fi
%% Widmungsseite %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndPreamble{
\ifhsdedication
\dedication{\hsdedicationvalue}
\fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ein angepasster Sperrvermerk %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\hscompany}[1]{\def\hscompanyvalue{#1}}
\newcommand{\hsrestrictedchapters}[1]{\def\hsrestrictedchaptersvalue{#1}}
\newcommand{\hsfaculty}[1]{\def\hsfacultyvalue{#1}}
\newcommand{\hsrestrictionduration}[1]{\def\hsrestrictiondurationvalue{#1}}

\newcommand{\restrictionnote}
{%
\chapter*{\translate{Restriction Note}}%
\par%
Dieses Werk enth\"alt zum Teil Informationen technischer oder gesch\"aftlicher Art der \hscompanyvalue,
die als geheimhaltungsbed\"urftig erkl\"art oder als solche erkennbar sind.
Dies betrifft die Kapitel \hsrestrictedchaptersvalue\ und wird ansonsten in einer Fu\ss{}note vermerkt.
Diese sind vertraulich zu behandeln und
d\"urfen nicht ohne schriftliche Zustimmung des Verfassers und der \hscompany\ Dritten zur Kenntnis gebracht werden.

Davon unbetroffen ist der bestimmungsgem\"a\ss{}e Gebrauch des Werkes in allen seinen Teilen gem\"a\ss{} zum Zeitpunkt der Pr\"ufung g\"ultiger Ordnungen
der Hochschule Kaiserslautern, des Fachbereiches \hsfacultyvalue\ und des Studiengangs
\hsmajorvalue.
Informationen, die der \"Offentlichkeit vor dem Pr\"ufungstermin bekannt oder allgemein zug\"anglich waren oder
nach dem Pr\"ufungstermin ohne Mitwirken oder Verschulden der am Verfahren Beteiligten bekannt oder
allgemein zug\"anglich werden oder im wesentlichen Informationen entsprechen, die zu irgendeinem Zeitpunkt von einem berechtigten Dritten offenbart oder
zug\"anglich gemacht werden sind von der Geheimhaltung ausgenommen.

Dieser Sperrvermerk ist auf \hsrestrictiondurationvalue\ Jahre nach dem Pr\"ufungstermin befristet.
}


\hscompany{\wiebefehl{hscompany\{Name des Unternehmens mit Rechtsform\}}}
\hsrestrictedchapters{\wiebefehl{hsrestrictedchapters\{ betroffene Kapitel hier benennen, auch die Anh\"ange\}}}
\hsfaculty{\wiebefehl{hsfaculty\{Fachbereich\}}}
\hsrestrictionduration{Dauer der Sperre in Jahren, meist 3}


\newcommand{\hs@printable@titling}
{
  \iftitlepage
  \maketitle
  \fi
}

\newcommand{\hs@printable@restrictionnote}
{
  \ifrestrictionnote
    \restrictionnote
  \fi
}

\newcommand{\hs@printable@tableofcontents}
{
  \cleardoublepage
  \tableofcontents
}

\newcommand{\hs@printable@tablesoffiguresandtables}
{
\iflot
  \anytocstrue
\fi

\iflof
  \anytocstrue
\fi

\ifanytocs
  \chapter{\translate{Lists}}
\fi

\iflot
  \listoftables
\fi

\iflof
  \listoffigures
\fi
}

\newcommand{\hs@printable@abbreviations}
{
  \label{label:abk}    \printglossary[type=\acronymtype]      %Abkürzungen ausgeben
  \label{label:symbole}\printglossary[type=symbolslist,style=long]       %Symbole ausgeben
  \label{label:glossar}\printglossary[style=altlist,title=\translate{Glossary}]       %Glossar ausgeben
}

\newcommand{\hs@printable@bibliography}
{
\ifsplitbib
  \printbibheading[title={\translate{Resources}}]{}
  \translate{splitresources}\extravspace

  \addcontentsline{toc}{section}{\translate{Literature}}

  \printbibliography[notkeyword=Internet,heading=subbibliography,title={\translate{Literature}}]  % Gedruckte Quellen
  \addcontentsline{toc}{section}{Internet}
  \printbibliography[   keyword=Internet,heading=subbibliography,title={Internet}]   % Quellen aus dem Internet
\else
  \printbibliography
\fi
}

\newcommand{\hs@printable@appendix}
{
  \appendix
  \makeatletter
  \renewcommand{\thesection}{\@Alph\c@section}
  \global\let\@autodottrue\@autodotfalse
  \makeatother
}

\newcommand{\hs@printable@index}
{
\printindex
}

\newcommand{\hs@hook@frontmatter}
{
\hs@printable@titling
\hs@printable@restrictionnote
}

\newcommand{\hs@hook@mainmatter}
{
\hs@printable@tableofcontents
\hs@printable@tablesoffiguresandtables
\hs@printable@abbreviations
}

\newcommand{\hs@hook@backmatter}
{
\hs@printable@bibliography
\hs@printable@appendix
}

\newcommand{\hs@hook@end}
{
\hs@printable@index
}

\newcommand{\hsfrontmatter}
{
\frontmatter
\hs@hook@frontmatter
\pagenumbering{Roman}
}

\newcommand{\hsmainmatter}
{
\cleardoublepage
\hs@hook@mainmatter
\cleardoublepage
\mainmatter
}

\newcommand{\hsbackmatter}
{
\backmatter
\hs@hook@backmatter
}

\AtEndDocument{\hs@hook@end}

\ifcustombiblatex\else
\usepackage[style=authoryear-icomp,
isbn=true,
pagetracker=true,
maxbibnames=50,
maxcitenames=2,
autocite=inline,
block=space,
backref=true,
backrefstyle=three+,
date=short,
url=true,
backend=biber]{biblatex}
\fi
