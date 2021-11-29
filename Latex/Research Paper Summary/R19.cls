\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{R19}[14/08/2019 ver. 0.0]
%Author: Anurag Jain (anurag.jain@research.iiit.ac.in)
\LoadClass[10pt, twocolumn]{article}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{sectsty}
\RequirePackage{dirtytalk}
\RequirePackage{titlesec}
\RequirePackage{tikz}
\usetikzlibrary{intersections,positioning,calc}
\RequirePackage{tkz-euclide,tkz-fct}
    \usetkzobj{all}
\usetikzlibrary{angles,quotes}
\RequirePackage{xltxtra,xunicode}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{hyperref}
\RequirePackage{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}
\RequirePackage{array}
\RequirePackage{changebar}
\RequirePackage{inputenc}
\RequirePackage[margin=0.75in,footskip=0.25in]{geometry}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,      
    urlcolor=cyan,
}

\graphicspath{{\rootDir/figures/}{figures/}}
%--Centering Command for ignoring margins--
\makeatletter
\newcommand*{\centerfloat}{%
  \parindent \z@
  \leftskip \z@ \@plus 1fil \@minus \textwidth
  \rightskip\leftskip
  \parfillskip \z@skip}
\makeatother
%--Section--
\titleformat{\section}[display]
  {\normalfont\bfseries}
  {\filleft
    \begin{tikzpicture}
    \node[
      outer sep=0pt,
      text width=2.5cm,
      fill=white,
      font=\fontsize{24}{0}\selectfont,
      align=center
      ] (num) {\thesection};
    \node[
      rotate=90,
      anchor=south,
      font=\color{black}\large\normalfont
      ] at ([xshift=-5pt]num.west) {\Huge\textsc{}};  
    \end{tikzpicture}%
  }
  {10pt}
  {\titlerule\vskip4pt\large\sc\sffamily}

%--Theorems, Corollary and Lemmas--
\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}{Corollary}[theorem]
\newtheorem{lemma}[theorem]{Lemma}
%--Subsection--
% \newcommand*\numb[1]{%
% \begin{tikzpicture}[baseline=-0.7ex]
% \node[
%   outer sep=0pt,
%       text width=0.6cm,
%       minimum height=0.6cm,
%       font=\color{white}\fontsize{12}{20}\selectfont,
%       align=center
%       ] (num) {\thesubsection};
% \end{tikzpicture}%
% }
% \titleformat{\subsection}
%   {\normalfont\large\sc\sffamily}{\numb{\thesubsection}}{0.8em}{}