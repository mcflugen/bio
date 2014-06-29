% resume.cls
%
%    Copyright 2005 Daniel Burrows
%
% You may use, modify, and redistribute this file in any way you please, so
% long as this copyright notice is maintained.

% Modifed 2010 Michael Galloy

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}

\LoadClassWithOptions{article}

\pagestyle{plain}

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage{tabularx}
\RequirePackage{pgf}
\RequirePackage{pgfshade}
\RequirePackage{xxcolor}

\RequirePackage{times}
\RequirePackage[T1]{fontenc}

\RequirePackage[tmargin=1in,bmargin=1in]{geometry}

\RequirePackage{paralist}  % for more compact lists.
\newcommand{\itembullet}[0]{\hspace{16pt}$\circ$}

\definecolor{rulestartcolor}{rgb}{0.,0.,0.}
\definecolor{ruleendcolor}{rgb}{0.,0.,0.}

\newlength{\titlebuffer}
\setlength{\titlebuffer}{4pt}
\newlength{\headerbuffer}
\setlength{\headerbuffer}{2pt}
\newlength{\secskip}
\setlength{\secskip}{2em}
\newlength{\subsecskip}
\setlength{\subsecskip}{6pt}

\newlength{\@headerscratch}

% Usage: \@setupshading{width}{height}{start}{end}
\newcommand{\@setupshading}[4]{%
  \pgfdeclarehorizontalshading{@ruleshading}{#2}{%
    color(0pt)=(#3); color(#1)=(#4)%
  }
}

\newcommand{\pgfrule}[4]{%
  \begin{pgfpicture}{0pt}{0pt}{#1}{#2}%
    \pgfdeclarehorizontalshading{@ruleshading}{#2}{%
      color(0pt)=(#3); color(#1)=(#4)%
    }
    \pgfputat{\pgfxy(0,0)}{\pgfbox[left,bottom]{\pgfuseshading{@ruleshading}}}
  \end{pgfpicture}%
}

\newcommand{\lrule}[2]{\pgfrule{#1}{#2}{rulestartcolor}{ruleendcolor}}
\newcommand{\rrule}[2]{\pgfrule{#1}{#2}{ruleendcolor}{rulestartcolor}}

\newcommand{\@authorname}{}
\newcommand{\@email}{}
\newcommand{\@streetaddress}{}
\newcommand{\@citystatezip}{}
\newcommand{\@phone}{}
\newcommand{\@webpage}{}

\renewcommand{\author}[1]{\renewcommand{\@authorname}{#1}}
%\newcommand{\email}[1]{\urldef{\@email}{\url}{#1}}
\newcommand{\email}[1]{\renewcommand{\@email}{#1}}
\newcommand{\streetaddress}[1]{\renewcommand{\@streetaddress}{#1}}
\newcommand{\citystatezip}[1]{\renewcommand{\@citystatezip}{#1}}
\newcommand{\phone}[1]{\renewcommand{\@phone}{#1}}
%\newcommand{\webpage}[1]{\urldef{\@webpage}{\url}{#1}}
\newcommand{\webpage}[1]{\renewcommand{\@webpage}{#1}}


\renewcommand{\maketitle}{{%
  \setlength{\@headerscratch}{\linewidth*2/3}%
  \vspace{\titlebuffer}%
  \par\nointerlineskip\noindent{\sc{\huge{\@authorname}}}

  \vspace{\titlebuffer}

  \ifthenelse{\equal{\@streetaddress}{}}{\ClassError{resume}{
      \protect\streetaddress\space required
    }{}
  }{}

  \ifthenelse{\equal{\@citystatezip}{}}{\ClassError{resume}{
      \protect\citystatezip\space required
    }{}
  }{}

  \ifthenelse{\equal{\@email}{}}{\ClassError{resume}{
      \protect\email\space required
    }{}
  }{}

  \ifthenelse{\equal{\@webpage}{}}{\ClassError{resume}{
      \protect\webpage\space required
    }{}
  }{}

  \ifthenelse{\equal{\@phone}{}}{\ClassError{resume}{
      \protect\phone\space required
    }{}
  }{}

  \begin{small}
    \noindent{\sc \@streetaddress\hspace{1em}\@citystatezip} \\
    \noindent{\textbf{EMAIL} \@email\hspace{2em}\textbf{WEB} \@webpage\hspace{2em} \textbf{TEL} \@phone}
  \end{small}
  
  \goodbreak\vspace{1.0em}
}}

\renewcommand{\section}[1]{%
  \goodbreak\vspace{\secskip}%
  \par\nointerlineskip\noindent\textbf{\textsc{\large\makebox[\linewidth][l]{#1}}}\vspace{\headerbuffer}\par\nointerlineskip\noindent%
  \lrule{\linewidth}{0.4pt}%
  \vspace{\headerbuffer}\par\nointerlineskip}

\renewcommand{\subsection}[1]{%
  \goodbreak\vspace{\subsecskip}\par\nointerlineskip\vspace{-1em}\textbf{\flushleft{#1}:}\par%
}

% General catch-all for either educational or job affiliation.
%
%  Usage:
% \affiliation[title]{institution}{years}
\newcommand{\affiliation}[3][]{%
  \goodbreak\vspace{\subsecskip}\par\noindent\begin{tabularx}{\linewidth}{Xr}%
    {\itshape #2} & \textit{#3}%
    \ifthenelse{\equal{#1}{}}{}{%
      \\ \textit{#1}
    }%
  \end{tabularx}\goodbreak\vspace{3pt}
}%

