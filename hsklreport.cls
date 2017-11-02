%Die folgenden Zeilen NICHT ÄNDERN (abgesehen vom Datum als Versionskontrolle)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hsklreport}[2017/03/10 hsklreport - Eine Report-Klasse fuer die Hochschule Kaiserslautern, basierend auf scrreprt]
%Damit werden alle Optionen direkt an scrbook durchgeschleift
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptions\relax
\LoadClass{scrreprt}
\RequirePackage{hsklbase}

%% Anmerkung des Autors  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% In Klassen und Paketen wird per Konvention der Befehl             %%
%% \RequirePackage anstatt von \usepackage verwendet. Die Anwendung  %%
%% und Bedeutung der Befehle ist jedoch gleich.                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Changelog  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Version 2.0 - Dezember 2016                                       %%
%%%% Alte Vorlage in Dokumentenklassen �berf�hrt                   %%%%
%% Version 2.0.1 - M�rz 2017                                         %%
%%%% Pakete multicol, longtable & hologo erg�nzt                   %%%%
%%%% Umgebung hskltable f�r einheitliche Tabellen geschaffen       %%%%
%%%% Kodierungsfehler im Wort Ak�rzungsverzeichnis behoben         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Ab hier darf nach Belieben vereandert werden    %%%%%%%%%%%%%%
%%%%%%%  (Auch wenn das selten notwendig sein sollte...) %%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Grundsätzliches Aussehen des Dokuments  %%%%%%%%%%%%%%%%%%%%%%
% Seiteneinstellungen
%\pagestyle{empty}		% keine Kopf und Fußzeile (k. Seitenzahl)
%\pagestyle{headings}	% lebender Kolumnentitel

% Verzeichnissstruktur
% Einstellungen für die Verzeichnisse
\KOMAoption{listof}{leveldown}           % die Verzeichnisse werden als Section gesetzt
\setcounter{tocdepth}{3}                 % Das Verzeichnis wird 4 Ebenen tief
\setcounter{secnumdepth}{4}              % Nummerierung bei subsubsection
\newcommand{\subsubsubsection}[1]{\paragraph[#1]{#1\\}\mbox{}\\}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Der Seitenkopf  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\iflogo

\newcommand{\hslogofile}[1]{\def\hslogofilevalue{#1}\logotrue}

\newif\ifsecondlogo

\newcommand{\hssecondlogofile}[1]{\def\hssecondlogofilevalue{#1}\secondlogotrue}

\AtEndPreamble
{
  \iflogo
    \usepackage[headsepline]{scrlayer-scrpage}
    \pagestyle{scrheadings}
    \rehead*{\includegraphics[width=.2\textwidth]{\hslogofilevalue}}

    \lohead*{\includegraphics[width=.2\textwidth]{\hslogofilevalue}}

    \setlength{\headheight}{56pt}
    \ifsecondlogo
      \lehead*{\includegraphics[width=.2\textwidth]{\hssecondlogofilevalue}}
      \rohead*{\includegraphics[width=.2\textwidth]{\hssecondlogofilevalue}}
    \fi %ifsecondlogo
  \fi %iflogo
} %AtEndPreamble
