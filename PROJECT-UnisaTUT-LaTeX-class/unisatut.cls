%%% UNISA tutorial letter class file 
%%% Original Author:   Yorick Hardy
%%% e-mail:            hardyy@unisa.ac.za
%%% Original filename: unisaletter.sty
%%%
%%% Modified by: Etienne van der Poel 2020
%%% Renamed:     unisatut.sty
%%% e-mail:      evdpoel@unisa.ac.za
%%%
%%% - removed 2012 styles
%%% - School and/or Department optional
%%% - module code, name, year, semester defined as variables
%%%     USAGE: the following in the document preample, before \begin{document}
%%%        \TutName        {Tutorial Letter}   % can use another label for documents that need to look the same as tut letters, but are called something else, e.g. Tasks
%%%        \ModuleCode     {MOD1234}           % UNISA module code
%%%        \TutNum         {101}               % usually 101, 102, 201, etc., but could be any text
%%%        \ModuleSemester {0}                 % 0,1,2, etc.
%%%        \ModuleYear     {2019}              % year for which tut is prepared
%%%        \ModuleName     {Module Name}       % UNISA module name
%%%        \Department     {The Department}    % optional, will not appear on first page if left out
%%%        \School         {The School}        % optional, will not appear on first page if left out
%%%        \Content        {This document contains the tutorial matter for MOD1234 for 2019.}
%%%                                            % summary of tut content to appear on first page
%%%        \Notes          {Optional notes}    % optional notes that will appear at the end of the CONTENTS page
%%% - removed Language support
%%% - added copyright at end of document
%%% - adjusted styles to fit 2019 Unisa tut template

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unisatut}[2020/10/05 UNISA Tutorial letter class]
\LoadClass[a4paper,12pt]{article}

%%%%%%%%%%%%% Options

% Create options: solution to mathsf found online
%%%%%
\newif\if@wantsolution\@wantsolutionfalse
\newif\if@usemathsf\@usemathsftrue
\newif\if@wantonline\@wantonlinefalse

\newif\if@usedepartment\@usedepartmentfalse
\newif\if@useschool\@useschoolfalse

\DeclareOption{solution}{\@wantsolutiontrue}
\DeclareOption{nomathsf}{\@usemathsffalse}
\DeclareOption{online}{\@wantonlinetrue}
\ProcessOptions\relax

%%%%%%%%%%%%% Required packages

\RequirePackage{amsfonts}
\RequirePackage{everypage}
\RequirePackage{fancyhdr}
\RequirePackage[
 a4paper,
 lmargin=1.4cm,rmargin=1.4cm,
 vmargin=2.4cm,bmargin=3.4cm,
 headheight=16pt
]{geometry}
\RequirePackage{graphicx}
\RequirePackage[scaled=1.0]{helvet}
\RequirePackage{ifthen}
\RequirePackage{tikz}
\RequirePackage{xcolor}

% these two lines are last to ensure that the correct sans font
% is loaded before enabling sans math fonts
\renewcommand{\familydefault}{\sfdefault}
\if@usemathsf\RequirePackage[helvet]{sfmath}\fi

%%%%%%%%%%%%% LaTeX commands

% preserve these LaTeX commands
% they will be redefined below
\let\@latexmark=\mark
\let\@latexlabel=\label
\let\@latexref=\ref
\let\@latexpageref=\pageref
\let\@latexsection=\section
\let\@latexsubsection=\subsection
\let\@latexsubsubsection=\subsubsection
\let\@latexaddcontentsline=\addcontentsline
\let\@latexaddtocontents=\addtocontents
\let\@latexontentsline=\contentsline
\let\@latexnumberline=\numberline
\let\@latexAtBeginDocument=\AtBeginDocument
\let\@latexdocument=\document

%%%%%%%%%%%%% Early setup

% Replace AtBeginDocument so that we can append commands
% after packages have appended their commands
\newtoks\@begindocumenttoks%
\gdef\@doatbegindocument{}
\long\gdef\AtBeginDocument#1{%
 \@begindocumenttoks\expandafter{\@doatbegindocument#1}%
 \xdef\@doatbegindocument{\the\@begindocumenttoks}%
}

\@latexAtBeginDocument{\@doatbegindocument}

%%%%%%%%%%%%% Style and layout

\setlength{\parindent}{0pt}

%\linespread{1.25}

% assignment question number box widths
\gdef\@sqlabelwidth{11mm}
\gdef\@ssqlabelwidth{7mm}
\gdef\@marklabelwidth{12mm}



%%%%%%%%%%%%% DEF to draw the first page

\def\@drawfirstpage{%
  \begin{tikzpicture}
   \draw[color=white]
         (0cm,0cm) -- (\paperwidth,\paperheight);
   \draw[color=black!25,yshift=26.4cm,line width=4.8mm]
         (0.025\paperwidth,-2.0mm)
         .. controls (0.2\paperwidth,-1.0cm) and (0.33\paperwidth,-0.9cm)
         .. (0.5\paperwidth,-0.7mm)
         .. controls (0.66\paperwidth, 0.88cm) and (0.88\paperwidth, 0.65cm)
         .. (0.975\paperwidth,-0.4mm);
   \draw[color=black!100,yshift=2.50cm,line width=2.0pt]
         (0.025\paperwidth,-2.0mm)
         .. controls (0.2\paperwidth,-1.0cm) and (0.33\paperwidth,-0.9cm)
         .. (0.5\paperwidth,-0.7mm)
         .. controls (0.66\paperwidth, 0.88cm) and (0.88\paperwidth, 0.65cm)
         .. (0.975\paperwidth,-0.4mm);
   \node[above right,text ragged,yshift=0.91cm,font=\sffamily\large]
         at (1.45cm,-0.4cm)
         {\scalebox{0.962}[0.84]{Define tomorrow.}};
   \node[above left,yshift=-0.4cm,xshift=-7mm]
         at (\paperwidth,0cm)
         {\includegraphics[scale=0.74,bb=0 0 301 111]{unisabw}};
   \node[below right,text ragged,font=\sffamily\bfseries\huge]
         at (3.06cm,23.77cm)
		 {\if@wantonline%
		  MO\@tutnum/\@modulesemester/\@moduleyear%
		  \else%
		  {\@tutname}
		   \@tutnum/\@modulesemester/\@moduleyear%
		  \fi};
   \node[below right,text ragged,font=\sffamily\bfseries\LARGE]
         at (3.06cm,20.34cm)
         {\scalebox{1.06}{\sffamily\bfseries\LARGE\@modulename}};
   \node[right,text ragged,font=\sffamily\bfseries\huge]
         at (3.06cm,18.55cm)
         {\scalebox{1.04}{\@modulecode}};
   \node[below right,text ragged,font=\sffamily\bfseries\LARGE]
         at (3.06cm,16.42cm)
         {\ifthenelse{\@modulesemester = 0}{%
          {Year module}}{%
          \ifthenelse{\@modulesemester = 1}{Semester 1}{%
          \ifthenelse{\@modulesemester = 2}{Semester 2}{%
          \ifthenelse{\@modulesemester = 3}{Semesters 1 \& 2}{}}}}};
   \node[below right,text ragged,font=\sffamily\bfseries\LARGE]
         at (3.06cm,14.82cm)
         {\if@usedepartment%
          {Department of \@department}%
          \fi};
   \node[below right,text ragged,font=\sffamily\bfseries\LARGE]
         at (3.06cm,13.22cm)
         {\if@useschool%
          {School of \@school}%
          \fi};
   \node[below right,text badly ragged,font=\sffamily]
         at (2.80cm,11.37cm)
         {\framebox{%
           \begin{minipage}{15cm}%
             \begin{center}%
				{CONTENTS}
             \end{center}%
             \@content%
             \ifhmode\\\fi%
           \end{minipage}%
          }};
  \end{tikzpicture}%
}


%%%%%%%%%%%%% DEF to draw an odd page - squigle at the bottom of the page, from 2012

\def\@drawoddpage{%
  \begin{tikzpicture}
   \draw[color=white]
         (0cm,0cm) -- (\paperwidth,\paperheight);
   \draw[color=black!57,yshift=2.3cm,line width=1.0pt]
         (0cm,-1.2mm)
         .. controls (0.2\paperwidth,-1.0cm) and (0.33\paperwidth,-0.9cm)
         .. (0.5\paperwidth,-0.7mm)
         .. controls (0.66\paperwidth, 0.88cm) and (0.88\paperwidth, 0.65cm)
         .. (\paperwidth,-1mm);
  \end{tikzpicture}%
}

\AddEverypageHook{%
 \hbox to 0pt{%
  \hskip-1in%
  \vbox to 0pt{%
   \vskip-1in%
   \ifthenelse{\value{page} = 1}{\@drawfirstpage}{%
%    \ifthenelse{\isodd{\value{page}}}{\@drawoddpage}{}}%       %if odd pages need to be treated differently, as in 2012
    \ifthenelse{\isodd{\value{page}}}{}{}}%
  \vss}%
 \hss}%
}

\pagestyle{fancy}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}



%%%%%%%%%%%%% headers and footers

\fancyhead{}
\fancyfoot{}

\rhead{%
 \ifthenelse{\isodd{\value{page}}}{%
 \ifthenelse{\value{page} = 1}{%
  {\sffamily\@modulecode/\@tutnum/\@modulesemester/\@moduleyear}}{%
  {\sffamily\@modulecode/\@tutnum}}}{}}

\lfoot{%
 \vbox{}\vfill%
 \ifthenelse{\isodd{\value{page}}}{}%
 {\sffamily\arabic{page}}}

\rfoot{%
 \vbox{}\vfill%
 \ifthenelse{\isodd{\value{page}}}{%
 \ifthenelse{\value{page} = 1}{}%
 {\sffamily\arabic{page}}{}}}

\chead{}
\cfoot{}

%%%%%%%%%%%%% at beginning document
%%% draw the first page

\gdef\@tutbegin{%
 \strut\newpage%  \@drawfirstpage will fill in the first page
}

%%%%%%%%%%%%% at end of document
%%% add copyright notice

\gdef\@tutend{%
 \vspace*{-1mm}
 \colorbox{white}{%
 \centerline{\sffamily%
    {\copyright~UNISA~\@moduleyear}}}\break%
  \vfill%
  \pagebreak%
}

\gdef\beginUNISAtut{\@tutbegin}
\gdef\endUNISAtut{\@tutend}

%%%%%%%%%%%%% bullets MS Word style

\newenvironment{msworditemize}{%
 \begin{list}{$\bullet$\hfill}{%
  \setlength{\itemsep}{\parsep}%
  \setlength{\leftmargin}{1.5cm}%
  \setlength{\labelwidth}{1.3cm}}%
}{%
 \end{list}%
}

%%%%%%%%%%%%% define rm and sf fonts to use

\gdef\rmfonts{\renewcommand{\familydefault}{\rmdefault}\rmfamily}
\gdef\sffonts{\renewcommand{\familydefault}{\sfdefault}\sffamily}

%%%%%%%%%%%%% Tut letter details

%%%%%\newif\if@usedepartment\@usedepartmenttrue
%%%%%\newif\if@useschool\@useschooltrue

\gdef\@modulecode{}
\gdef\@modulename{}
\gdef\@tutnum{}
\gdef\@tutname{}
\gdef\@modulesemester{}
\gdef\@moduleyear{}
\gdef\@department{}
\gdef\@school{}
\gdef\@content{}
\gdef\@notes{}
\gdef\@firstassignment{1}

%%%%%%%%%%%%% this macro extracts the year, month and day from ISO date format
\newcounter{getnumber}
\gdef\@isodate#1-#2-#3-{%
 \gdef\@isoyear{#1}%
 \setcounter{getnumber}{#2}%
 \xdef\@isomonth{\arabic{getnumber}}%
 \setcounter{getnumber}{#3}%
 \xdef\@isoday{\arabic{getnumber}}%
}

%%%%%%%%%%%%% define variables for tut letter details

\gdef\ModuleName#1{\gdef\@modulename{#1}\gdef\modulename{#1}}
\gdef\Department#1{\gdef\@department{#1}\@usedepartmenttrue}
\gdef\School#1{\gdef\@school{#1}\@useschooltrue}
\long\gdef\Content#1{\long\gdef\@content{#1}}
\gdef\TutName#1{\gdef\@tutname{#1}}
\gdef\ModuleCode#1{\gdef\@modulecode{#1}}
\gdef\TutNum#1{\gdef\@tutnum{#1}}
\gdef\ModuleSemester#1{\gdef\@modulesemester{#1}}
\gdef\ModuleYear#1{\gdef\@moduleyear{#1}}
\gdef\AssignmentsFrom#1{\gdef\@firstassignment{#1}}

\long\gdef\Notes#1{\gdef\@notes{%
 \vspace*{8mm}%
 \framebox{\parbox{\linewidth}{%
  \hfil\parbox{0.99\linewidth}{%
  \vspace*{3mm}%
  {\sffamily\bfseries #1}%
  \vspace*{3mm}}}\hfil}}%
}



\newif\if@solution\@solutionfalse

\newwrite\@tocwrite
\newwrite\@lofwrite
\newwrite\@lotwrite
\newif\if@tocopen\@tocopenfalse
\newif\if@lofopen\@lofopenfalse
\newif\if@lotopen\@lofopenfalse


\gdef\runcounters{%
 \gdef\@questiontype{assignment}
 \setcounter{@assignment0}{\@firstassignment}%
 \setcounter{@assignment1}{\@firstassignment}%
 \setcounter{@assignment2}{\@firstassignment}%
 \setcounter{@assignment3}{\@firstassignment}%
 \setcounter{@addendum}{0}%
 \setcounter{@totalquestions}{0}
 \setcounter{@question}{0}%
 \setcounter{@assnmark}{0}%
 \setcounter{section}{0}%
 \setcounter{page}{1}%
 \setcounter{table}{0}%
 \setcounter{figure}{0}%
 \message{Reloading: \jobname.tex}%
 \@tutinput{\jobname}%
 \message{Reloaded: \jobname.tex}%
 \if@tocopen\immediate\closeout\@tocwrite\fi\@tocopenfalse%
 \if@lofopen\immediate\closeout\@lofwrite\fi\@lofopenfalse%
 \if@lotopen\immediate\closeout\@lotwrite\fi\@lotopenfalse%
}

\AtEndOfClass{%
 \gdef\document{%
  \@latexdocument%
    \if@wantsolution%
    \@solutiontrue%
    \gdef\@curlabel{engsol}%
    \gdef\@curtoc{ec}%
    \gdef\@curlof{et}%
    \gdef\@curlot{ef}%
    \runcounters%
    \@solutionfalse%
   \else%
    \gdef\@curlabel{eng}%
    \gdef\@curtoc{esc}%
    \gdef\@curlof{est}%
    \gdef\@curlot{esf}%
    \runcounters%
   \fi%
  \end{document}%
  \endinput%
}}



%%%%%%%%%%%%% Table of contents

\long\gdef\addtocontents#1#2{{%
 \let\protect\noexpand%
 \ifthenelse{\equal{#1}{toc}}{%
  \if@tocopen\else%
   \immediate\openout\@tocwrite=\jobname.\@curtoc\global\@tocopentrue%
  \fi%
  \protected@write\@tocwrite{}{#2}}{%
 \ifthenelse{\equal{#1}{lof}}{%
  \if@lofopen\else%
   \immediate\openout\@lofwrite=\jobname.\@curlof\global\@lofopentrue%
  \fi%
  \protected@write\@lofwrite{}{#2}}{%
 \ifthenelse{\equal{#1}{lot}}{%
  \if@lotopen\else%
   \immediate\openout\@lotwrite=\jobname.\@curlot\global\@lotopentrue%
  \fi%
  \protected@write\@lotwrite{}{#2}}{%
 \errmessage{\string\addtocontents does not support type #1}}}}%
}}

\gdef\@contentsline#1#2#3{{%
 \ifthenelse{\equal{#1}{section}}{\bfseries}{}%
 \ifthenelse{\equal{#1}{subsubsection}}{\slshape}{}%
 \sffamily\hspace*{1mm}\scalebox{0.93}{#2}%
 \leaders\hbox{.}\hfill#3\hspace*{0mm}}%
 \par\vspace{2.3mm}}
\let\contentsline=\@contentsline%

\gdef\@numberline#1#2{\parbox{1.5cm}{#1}#2}
\let\numberline=\@numberline%


\renewcommand{\tableofcontents}{
   \vspace*{-1mm}
   \colorbox{white}{%
   \centerline{\sffamily\bfseries%
    {CONTENTS}}}\break%
   \par%
   {\catcode`\@11\InputIfFileExists{\jobname.\@curtoc}{}{}}%
   \@notes
   \newpage
}

\renewcommand{\listoffigures}{
   \vspace*{-1mm}
   \colorbox{white}{%
   \centerline{\sffamily\bfseries%
    {LIST OF FIGURES}}}\break%
   \par%
   {\catcode`\@11\InputIfFileExists{\jobname.\@curlof}{}{}}%
   \@notes
   \newpage
}

\renewcommand{\listoftables}{
   \vspace*{-1mm}
   \colorbox{white}{%
   \centerline{\sffamily\bfseries%
    {LIST OF TABLES}}}\break%
   \par%
   {\catcode`\@11\InputIfFileExists{\jobname.\@curlot}{}{}}%
   \@notes
   \newpage
}


%%%%%%%%%%%%% Sectioning

\newcounter{@addendum}
\newif\if@do@tocentry
\renewcommand{\the@addendum}{\Alph{@addendum}}
\renewcommand{\thesection}{\@sectionnumber}
\renewcommand{\thesubsection}{\@sectionnumber.\arabic{subsection}}
\renewcommand{\thesubsubsection}{%
\@sectionnumber.\arabic{subsection}.\arabic{subsubsection}}
\renewcommand{\theparagraph}{
\@sectionnumber.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}}

\gdef\section{\let\@sectioncmd=\@@section\futurelet\@nexttoken\@dosection}%

\gdef\subsection{%
 \let\@sectioncmd=\@@subsection\futurelet\@nexttoken\@dosection}%

\gdef\subsubsection{%
 \let\@sectioncmd=\@@subsubsection\futurelet\@nexttoken\@dosection}%

\gdef\@dosection{%
 \if\@nexttoken *%
  \@do@tocentryfalse%
  \let\@@donext=\@dosectionstar%
 \else%
  \@do@tocentrytrue%
  \let\@@donext=\@sectioncmd%
 \fi%
 \@@donext%
}

\long\gdef\@dosectionstar#1#2{\@sectioncmd{#2}}

\newcommand{\@@section}[1]{
 \gdef\@sectionnumber{\arabic{section}}%
 \if@do@tocentry\refstepcounter{section}\fi%
 \@latexsection*{%
  \addtolength{\linewidth}{2mm}%
%  \kern-2mm\colorbox{black!14}{%
  \kern-1mm{%
    \parbox{\linewidth}{%
     \hspace*{1mm}\large\bfseries\sffamily%
     \if@do@tocentry%
      \parbox[t]{1.2cm}{\arabic{section}}%
     \fi%
     \raisebox{0pt}[4.7mm][1mm]{#1}}}}%
  %\addtolength{\linewidth}{-2mm}%
 \if@do@tocentry%
  \addcontentsline{toc}{section}{\protect\numberline{\arabic{section}}{#1}}%
 \fi%
}

\newcommand{\@@subsection}[1]{%
 \if@do@tocentry\refstepcounter{subsection}\fi%
 \@latexsubsection*{%
  \normalsize\bfseries\sffamily%
  \if@do@tocentry%
   \parbox[t]{1.2cm}{\@sectionnumber.\arabic{subsection}}%
  \fi%
  \hbox{#1}}%
% {\ifvmode\relax\else\hfil\break\fi\vbox to 5mm{}\par%
%  \bfseries\sffamily\if@do@tocentry\parbox[t]{1.5cm}{%
%   \@sectionnumber.\arabic{subsection}}\fi\hbox{#1}%
%  \par\vspace*{5mm}}%
 \if@do@tocentry%
  \addcontentsline{toc}{subsection}{%
   \protect\numberline{\@sectionnumber.\arabic{subsection}}{#1}}%
 \fi%
}

\newcommand{\@@subsubsection}[1]{%
 \if@do@tocentry\refstepcounter{subsubsection}\fi%
 \@latexsubsubsection*{%
  \bfseries\sffamily\slshape%
  \if@do@tocentry%
   \parbox[t]{1.2cm}{%
    \@sectionnumber.\arabic{subsection}.\arabic{subsubsection}}%
  \fi%
  \hbox{#1}}%
% {\ifvmode\relax\else\hfil\break\fi\vbox to 5mm{}\par%
%  \bfseries\sffamily\if@do@tocentry\parbox[t]{1.5cm}{%
%  \@sectionnumber.\arabic{subsection}.\arabic{subsubsection}}\fi\hbox{#1}%
%  \par\vspace*{5mm}}%
 \if@do@tocentry%
  \addcontentsline{toc}{subsubsection}{%
   \protect%
   \numberline{\@sectionnumber.\arabic{subsection}.\arabic{subsubsection}}{#1}}%
 \fi%
}

\newcommand{\addendum}[1]{%
 \refstepcounter{@addendum}%
 \setcounter{subsection}{0}%
 \def\@emptytitle{}%
 \def\@addendumtitle{#1}%
 \ifx\@emptytitle\@addendumtitle%
  \section*{{ADDENDUM} \Alph{@addendum}}%
  \gdef\@sectionnumber{\Alph{@addendum}}%
  \addcontentsline{toc}{section}{%
   {ADDENDUM} \Alph{@addendum}}%
 \else%
  \section*{{ADDENDUM} \Alph{@addendum}: #1}%
  \gdef\@sectionnumber{\Alph{@addendum}}%
  \addcontentsline{toc}{section}{%
   {ADDENDUM} \Alph{@addendum}: #1}%
 \fi%
}

%%%%%%%%%%%%% Assignment support

% these are counters for assignment question numbers
% and their mark allocations
\newcounter{@question}
\newcounter{@subquestion}
\newcounter{@subsubquestion}
\newcounter{@questionmark}
\newcounter{@subquestionmark}
\newcounter{@subsubquestionmark}
\newcounter{@assnmark}
\newcounter{@questionticks}
\newcounter{@subquestionticks}
\newcounter{@subsubquestionticks}
\newcounter{@assignment0}
\newcounter{@assignment1}
\newcounter{@assignment2}
\newcounter{@assignment3}
\newcounter{@totalquestions}

% commands for typesetting question numbers
\renewcommand{\the@question}{\arabic{@question}}
\renewcommand{\the@subquestion}{\arabic{@question}.\arabic{@subquestion}}
\renewcommand{\the@subsubquestion}{%
\arabic{@question}.\arabic{@subquestion}(\alph{@subsubquestion})}

\newenvironment{@question}[1]{%
 \ifhmode\par\fi\addvspace{7mm}%
 \refstepcounter{@question}%
 \stepcounter{@totalquestions}%
 \setcounter{@subquestion}{0}%
 \textbf{{Question} \arabic{@question}}%
 {%
  \edef\@qm{%
   \csname*Q\@curlabel\arabic{@totalquestions}\endcsname}%
  \ifx\@qm\undefined\else%
  \ifthenelse{\equal{\@qm}{0}}{}{:\ %
      \textbf{\@qm~{Mark}%
      \ifthenelse{\equal{\@qm}{1}}{}{{s}}}}%
  \fi%
 }%
 \nopagebreak%
 \ifhmode\par\fi\addvspace{5mm}%
 \nopagebreak%
 \setcounter{@questionmark}{#1}%
 \gdef\@questiontype{question}%
}{%
 \nopagebreak%
 \ifhmode\par\fi\addvspace{1mm}%
 \nopagebreak%
 {%
  \edef\@qm{Q\@curlabel\arabic{@totalquestions}}
  \immediate\write\@auxout{%
   \string\expandafter\string\gdef\string\csname*\@qm\string\endcsname%
   {\arabic{@questionmark}}}%
 }%
% \strut\hfill\textbf{[\arabic{@questionmark}]}\\%
 \addtocounter{@assnmark}{\value{@questionmark}}%
 \gdef\@questiontype{assignment}%
 \pagebreak[1]%
}

\newenvironment{@subquestion}[1]{%
 \refstepcounter{@subquestion}%
 \setcounter{@subsubquestion}{0}%
 \setcounter{@subquestionmark}{#1}%
 \gdef\@questiontype{subquestion}%
 \ifhmode\par\fi\addvspace{5mm}%
 \global\advance\leftskip \@sqlabelwidth%
 \global\advance\rightskip \@marklabelwidth%
 \global\advance\linewidth -\@sqlabelwidth%
 \global\advance\@totalleftmargin \@sqlabelwidth%
 \strut\llap{\parbox[t]{\@sqlabelwidth}{%
  \textbf{(\arabic{@question}.\arabic{@subquestion})}}}%
 {%
  \edef\@sqm{%
   \csname*Q\@curlabel\arabic{@totalquestions}.\arabic{@subquestion}\endcsname}%
  \ifx\@sqm\undefined\else%
  \ifthenelse{\equal{\@sqm}{0}}{}{%
   \rlap{\hbox to \linewidth{\strut\hfill(\@sqm)}}}%
  \fi%
 }%
 \global\advance\linewidth -\@marklabelwidth%
 \bgroup\ignorespaces%
}{%
 \egroup\par%
 \global\advance\leftskip -\@sqlabelwidth%
 \global\advance\rightskip -\@marklabelwidth%
 \global\advance\linewidth \@sqlabelwidth%
 \global\advance\linewidth \@marklabelwidth%
 \global\advance\@totalleftmargin -\@sqlabelwidth%%
 \addtocounter{@questionmark}{\value{@subquestionmark}}%
 \penalty10000%
 {%
  \edef\@sqm{Q\@curlabel\arabic{@totalquestions}.\arabic{@subquestion}}
  \immediate\write\@auxout{%
   \string\expandafter\string\gdef\string\csname*\@sqm\string\endcsname%
   {\arabic{@subquestionmark}}}%
 }%
 \gdef\@questiontype{question}%
 \penalty-5000%
}

\newenvironment{@subsubquestion}[1]{%
 \refstepcounter{@subsubquestion}%
 \setcounter{@subsubquestionmark}{#1}%
 \gdef\@questiontype{subsubquestion}%
 \ifhmode\par\fi\addvspace{3mm}%
 \global\advance\leftskip \@ssqlabelwidth%
 \global\advance\linewidth -\@ssqlabelwidth%
 \global\advance\@totalleftmargin \@ssqlabelwidth%%
 \global\advance\linewidth \@marklabelwidth%
 \strut\llap{\parbox[t]{\@ssqlabelwidth}{\textbf{(\alph{@subsubquestion})}}}%
 {%
  \edef\@sqm{%
\csname*Q\@curlabel\arabic{@totalquestions}.\arabic{@subquestion}.\arabic{@subsubquestion}\endcsname}%
  \ifx\@sqm\undefined\else%
  \ifthenelse{\equal{\@sqm}{0}}{}{%
   \rlap{\hbox to \linewidth{\strut\hfill(\@sqm)}}}%
  \fi%
 }%
 \global\advance\linewidth -\@marklabelwidth%
 \bgroup\ignorespaces%
}{%
 \egroup\par%
 \global\advance\leftskip -\@ssqlabelwidth%
 \global\advance\linewidth \@ssqlabelwidth%
 \global\advance\@totalleftmargin -\@ssqlabelwidth%%
 \addtocounter{@questionmark}{\value{@subsubquestionmark}}%
 {%
  \edef\@sqm{%
   Q\@curlabel\arabic{@totalquestions}.\arabic{@subquestion}.\arabic{@subsubquestion}}
  \immediate\write\@auxout{%
    \string\expandafter\string\gdef\string\csname*\@sqm\string\endcsname%
    {\arabic{@subsubquestionmark}}}%
 }%
 \gdef\@questiontype{subquestion}%
}

\newenvironment{question}[1][0]{%
 \ifthenelse{\equal{\@questiontype}{assignment}}{\begin{@question}{#1}}{%
 \ifthenelse{\equal{\@questiontype}{question}}{\begin{@subquestion}{#1}}{%
 \ifthenelse{\equal{\@questiontype}{subquestion}}{\begin{@subsubquestion}{#1}}%
 {}}}%
}{%
 \ifthenelse{\equal{\@questiontype}{question}}{\end{@question}}{%
 \ifthenelse{\equal{\@questiontype}{subquestion}}{\end{@subquestion}}{%
 \ifthenelse{\equal{\@questiontype}{subsubquestion}}{\end{@subsubquestion}}{}}}%
}

\gdef\duedate#1#2{%
  \edef\@dd{Due#2semester#1\@curlabel}%
  \edef\@ddate{\csname*\@dd\endcsname}%
  \ifx\@ddate\undefined ????\else\@ddate\fi}

\gdef\nextassignment{%
 \ifnum\value{\@assignmentcounter}<10{0}\fi%
 \arabic{\@assignmentcounter}}%

\newenvironment{assignment}[4][0]{%
 \ifthenelse{\equal{#3}{self}}{\@noisodate}{\@isodate#4-}%
 \setcounter{@question}{0}%
 \setcounter{@assnmark}{#1}%
 \gdef\@assignmentcounter{@assignment#2}%
 \gdef\@questiontype{assignment}%
 \edef\@dd{Due\arabic{\@assignmentcounter}semester#2\@curlabel}
 \immediate\write\@auxout{%
  \string\expandafter\string\gdef\string\csname*\@dd\string\endcsname%
  {\@isoday\ \@isomonthname\ \@isoyear}}%
 \framebox{
  \begin{minipage}{\linewidth}
  {\sffamily
  \begin{center}
   \ifthenelse{\equal{#3}{self}}{}{%
   \textbf{{ASSIGNMENT}
           \ifnum\value{\@assignmentcounter}<10{0}\fi%
		   \arabic{\@assignmentcounter}}\\}
   \if@solution\textbf{{Solution}}\\%
   \else%
    \ifthenelse{\equal{#3}{self}}{}{%
     \textbf{{Due Date:} %
             \duedate{#2}{\arabic{\@assignmentcounter}}}\\}
   \fi%
   {%
    \edef\@am{\csname*A\@curlabel\@assignmentcounter\arabic{\@assignmentcounter}\endcsname}%
    \ifx\@am\undefined\else%
    \ifthenelse{\equal{\@am}{0}}{}{{Total Marks:} \@am \\}%
    \fi%
   }
   \ifthenelse{\equal{#3}{self}}{%
    \textbf{{SELF ASSESSMENT ASSIGNMENT}
           \ifnum\value{\@assignmentcounter}<10{0}\fi%
		   \arabic{\@assignmentcounter}}
   }{%
    \textbf{{UNIQUE ASSIGNMENT NUMBER:} #3}%
   }\\[\baselineskip]

   \if@solution\else%
   \ifthenelse{#2 = 0}{%
    \textbf{\emph{{ONLY FOR YEAR MODULE}}}}{}%
   \ifthenelse{#2 = 1}{%
    \textbf{\emph{{ONLY FOR SEMESTER 1}}}}{}%
   \ifthenelse{#2 = 2}{%
    \textbf{\emph{{ONLY FOR SEMESTER 2}}}}{}%
   \ifthenelse{#2 = 3}{%
    \textbf{\emph{{ALL STUDENTS}}}}{}%
   \fi
  \end{center}
  }
  \end{minipage}
 }\par
}{%
 {%
  \edef\@am{A\@curlabel\@assignmentcounter\arabic{\@assignmentcounter}}
  \immediate\write\@auxout{%
   \string\expandafter\string\gdef\string\csname*\@am\string\endcsname%
   {\arabic{@assnmark}}}%
 }%
 \stepcounter{\@assignmentcounter}%
% \penalty10000%
}

\newenvironment{problemset}{%
 \setcounter{@question}{0}%
 \setcounter{@assnmark}{0}%
 \gdef\@questiontype{assignment}%
}{}

\renewcommand{\mark}[1][1]{%
 {\color{red!90!black}\large%
  \ifthenelse{#1 = 1}{\checkmark}{\mbox{\checkmark$^{#1}$}}}%
 \addtocounter{@\@questiontype ticks}{#1}%
 \addtocounter{@\@questiontype mark}{#1}%
}

\newbox\@solutionbox
\newenvironment{solution}{%
 \setcounter{@\@questiontype ticks}{0}%
 \setbox\@solutionbox=\vbox\bgroup%
  \slshape%
}{%
 \egroup%
 \if@solution%
  {\ifhmode\par\fi}\addvspace{2mm}%
  \unvbox\@solutionbox%
  \ifthenelse{\equal{\@questiontype}{question}}{%
   \ifthenelse{\value{@questionticks} = \value{@questionmark}}{}{%
    \par\centerline{{\bfseries\color{red}\{\arabic{@questionticks}\}}}%
   }%
  }{%
  \ifthenelse{\equal{\@questiontype}{subquestion}}{%
   \addtocounter{@questionticks}{\value{@subquestionticks}}%
   \ifthenelse{\value{@subquestionticks} = \value{@subquestionmark}}{}{%
    \par\centerline{{\bfseries\color{red}\{\arabic{@subquestionticks}\}}}%
   }%
  }{%
  \ifthenelse{\equal{\@questiontype}{subsubquestion}}{%
   \addtocounter{@subquestionticks}{\value{@subsubquestionticks}}%
   \ifthenelse{\value{@subsubquestionticks} = \value{@subsubquestionmark}}{}{%
    \par\centerline{{\bfseries\color{red}\{\arabic{@subsubquestionticks}\}}}%
   }%
  }}}%
 \else\relax\fi%
}

\newenvironment{withsolution}{%
 \if@solution%
  \let\@restoresolution=\relax%
 \else%
  \let\@restoresolution=\@solutionfalse%
 \fi%
 \@solutiontrue%
}{%
 \@restoresolution%
}

\newenvironment{withoutsolution}{%
 \if@solution%
  \let\@restoresolution=\@solutiontrue%
 \else%
  \let\@restoresolution=\relax%
 \fi%
 \@solutionfalse%
}{%
 \@restoresolution%
}

%%%%%%%%%%%%% Hyperref support

\gdef\@hyperrefcontentsline#1#2#3#4{%
 \@contentsline{#1}{\hyperlink{#4}{#2}}{\hyperlink{#4}{#3}}}%

\gdef\@hyper@anchor#1{
 \expandafter\@hyperrefhyper@anchor\expandafter{\@curlabel :#1}}

\gdef\@hyper@anchorstart#1{%
 \expandafter\@hyperrefhyper@anchorstart\expandafter{\@curlabel :#1}}

\gdef\@hyper@linkswitch#1#2#3{\@hyperrefhyper@link{#2}{#1}{#3}}
\gdef\@hyper@link#1#2#3{%
 \expandafter\@hyper@linkswitch\expandafter{\@curlabel :#2}{#1}{#3}}

\gdef\@hyper@linkstartswitch#1#2{\@hyperrefhyper@linkstart{#2}{#1}}
\gdef\@hyper@linkstart#1#2{%
 \expandafter\hyper@linkstartswitch\expandafter{\@curlabel :#2}{#1}}

\@latexAtBeginDocument{%
 \@ifpackageloaded{hyperref}{%
  \global\let\contentsline=\@hyperrefcontentsline%
  \global\let\@hyperrefhyper@anchor=\hyper@anchor%
  \global\let\@hyperrefhyper@anchorstart=\hyper@anchorstart%
  \global\let\@hyperrefhyper@link=\hyper@link%
  \global\let\@hyperrefhyper@linkstart=\hyper@linkstart%
  \global\let\hyper@anchor=\@hyper@anchor%
  \global\let\hyper@anchorstart=\@hyper@anchorstart%
  \global\let\hyper@link=\@hyper@link%
  \global\let\hyper@linkstart=\@hyper@linkstart%
}{}}%

%%%%%%%%%%%%% Bibliography

\newenvironment{references}[1]{%
 \begingroup%
  \def\markboth##1##2{}%
  \def\@@section##1{}%
  \begin{thebibliography}{#1}%
}{%
  \end{thebibliography}%
 \endgroup%
}

%%%%%%%%%%%%% Support macros

{%
\catcode`\/=0\catcode`\[=1\catcode`\]=2%
\catcode`\{=12\catcode`\}=12\catcode`\\=12%
/gdef/@matchbegindocument[\begin{document}]%
/gdef/@matchenddocument[\end{document}]%
]%

% Load the current file without the preamble, \begin{document} and \end{document}
\gdef\@tutinput#1{%
 \begingroup%
  \newif\if@preamble\@preambletrue%
  \newif\if@readfin\@readfinfalse%
  \newread\@readletter%
  \newwrite\@nopreamble%
  \openin\@readletter=#1%
  \immediate\openout\@nopreamble=#1.nop%
  \def\@doread{%
   \catcode`\ =12\catcode`\\=12\catcode`\{=12\catcode`\}=12\catcode`\$=12%
   \catcode`\&=12\catcode`\#=12\catcode`\^=12\catcode`\_=12\catcode`\%=12%
   \catcode`\~=12%
   \catcode"0D=9%
   \read\@readletter to\@@tutline%
   \global\let\@tutline=\@@tutline%
  }%
  \def\@preamblescan{%
   {\@doread}\ifeof\@readletter\@readfintrue\fi%
   \ifx\@tutline\@matchbegindocument%
    \global\@preamblefalse%
    \immediate\write\@nopreamble{\@tutline}%
   \else%
    \if@preamble%
     \immediate\write\@nopreamble{}    % so that line numbers match up
    \else%
     \immediate\write\@nopreamble{\@tutline}%
    \fi%
   \fi%
  }%
  \loop\if@readfin\else\@preamblescan\repeat%
  \closein\@readletter%
  \immediate\closeout\@nopreamble%
 \endgroup%
 {\let\document=\beginUNISAtut\let\enddocument=\endUNISAtut\input{#1.nop}}%
}


\edef\@@nl{\char13}%
\def\@@empty{}

%this macro removes whitespace (space and newline) from a string
% -- not used yet
\long\def\@@stripws#1#2\@@endstrip{%
 \def\@@one{#1}\def\@@two{#2}%
 \if\@@one\ \else\if\@@one\@@nl\else\@@one\fi\fi%
 \ifx\@@two\@@empty%
 \else%
  \expandafter\@@stripws\@@two\@@endstrip%
 \fi%
}%

%this macro compares two strings
% -- not used yet
\newif\ifsame\samefalse%
\long\def\compare#1#2\to#3#4\endcmp{%
 \def\one{#1}\def\three{#3}%
 {\tt\meaning\one : \meaning\three}\\%
 \ifx\one\@@empty{%
  \ifx\three\@@empty%
   bothempty\global\sametrue%
  \else%
   \global\samefalse%
  \fi%
 }\else{%
  \if\one\three%
   equal\compare#2\to#4\endcmp
  \else%
   \global\samefalse%
  \fi%
 }\fi%
}%

\def\@putinboxes#1#2\end{%
 \def\@@one{#1}%
 \ifx\@@one\@@empty\else\hbox{1}\@putinboxes#2\enf\fi%
}

\def\supressspecials#1{%
 \catcode`\ =12\catcode`\\=12\catcode`\{=12\catcode`\}=12\catcode`\$=12%
 \catcode`\&=12\catcode`\#=12\catcode`\^=12\catcode`\_=12\catcode`\%=12%
 #1%
}

\def\@putspecialsinboxes#1{{%
 \catcode`\ =12\catcode`\\=12\catcode`\{=12\catcode`\}=12\catcode`\$=12%
 \catcode`\&=12\catcode`\#=12\catcode`\^=12\catcode`\_=12\catcode`\%=12%
 \@putinboxes#1\end%
}}

\def\verbwrap#1{{\ttfamily\@putspecialsinboxes{#1}}}

%%%%%%%%%%%%% %%%%%%%%%%%%% %%%%%%%%%%%%% 
