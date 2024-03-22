% Author: Fenglielie
% Email: fenglielie@qq.com

%% 文档类基本信息
\ProvidesClass{simplenote}[2024/03/11 SimpleNote v1.1 class]
\NeedsTeXFormat{LaTeX2e}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 文档类设置选项

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{family=SIMPLENOTE,prefix=SIMPLENOTE@,setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{SIMPLENOTE}{#1}}

\DeclareStringOption[blue]{color}
\DeclareVoidOption{cyan}{\ekv{color=cyan}}
\DeclareVoidOption{blue}{\ekv{color=blue}}
\DeclareVoidOption{black}{\ekv{color=black}}

\DeclareStringOption[normal]{device}
\DeclareVoidOption{normal}{\ekv{device=normal}}
\DeclareVoidOption{pad}{\ekv{device=pad}}

\DeclareStringOption[cn]{lang}
\DeclareVoidOption{cn}{\ekv{lang=cn}}
\DeclareVoidOption{en}{\ekv{lang=en}}


\DeclareStringOption[auto]{cnfont}
\DeclareVoidOption{auto}{\ekv{cnfont=auto}}
\DeclareVoidOption{windows}{\ekv{cnfont=windows}}
\DeclareVoidOption{fandol}{\ekv{cnfont=fandol}}
\DeclareVoidOption{none}{\ekv{cnfont=none}}
\DeclareVoidOption{FZ}{\ekv{cnfont=FZ}}
\DeclareVoidOption{NotoCJK}{\ekv{cnfont=NotoCJK}}
\DeclareVoidOption{SourceHan}{\ekv{cnfont=SourceHan}}


\DeclareStringOption[11pt]{fontsize}
\DeclareVoidOption{10pt}{\ekv{fontsize=10pt}}
\DeclareVoidOption{11pt}{\ekv{fontsize=11pt}}
\DeclareVoidOption{12pt}{\ekv{fontsize=12pt}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 加载基本文档article

\DeclareDefaultOption{
    \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessKeyvalOptions*\relax
\LoadClass{article}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 检查编译引擎并配置
\RequirePackage{iftex}

% pdflatex不支持中文模式
\ifPDFTeX
    \ifdefstring{\SIMPLENOTE@lang}{cn}{
        \ClassError{SimpleNote}{PDFTeX engine is not supported with chinese}{Please compile with XeTeX engine}
    }{\relax}
\fi

% xelatex需要加载字体支持宏包
\ifXeTeX
    % 一个特殊的宏包，不支持pdflatex，必须使用xelatex（或lualatex）
    \PassOptionsToPackage{no-math}{fontspec}
    \PassOptionsToPackage{quiet}{fontspec}
    \RequirePackage{fontspec}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 在中文模式加载ctex，并支持不同的字体选项：（已经保证为xelatex并且已经加载fontspec宏包）
% ctex自动选择方案：cnfont=auto
% windows默认方案：cnfont=windows
% fandol默认方案：cnfont=fandol
% 禁用字体配置：cnfont=none
% 方正字体：cnfont=FZ
% Noto 思源字体（SC）：cnfont=NotoCJK
% Source Han 思源字体（SC）：cnfont=SourceHan


\ifdefstring{\SIMPLENOTE@lang}{cn}{ %
    \ifdefstring{\SIMPLENOTE@cnfont}{auto}{
        \RequirePackage[UTF8,scheme=plain]{ctex} %
    }{\relax}

    \ifdefstring{\SIMPLENOTE@cnfont}{windows}{
        \RequirePackage[UTF8,scheme=plain,fontset=windows]{ctex} %
    }{\relax}

    \ifdefstring{\SIMPLENOTE@cnfont}{fandol}{
        \RequirePackage[UTF8,scheme=plain,fontset=fandol]{ctex} %
    }{\relax}

    \ifdefstring{\SIMPLENOTE@cnfont}{none}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %
    }{\relax}


    \ifdefstring{\SIMPLENOTE@cnfont}{FZ}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %

        \setCJKmainfont{FZShuSong-Z01}[BoldFont={FZHei-B01},ItalicFont={FZKai-Z03}]
        \setCJKsansfont{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKmonofont{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \setCJKfamilyfont{zhsong}{FZShuSong-Z01}
        \setCJKfamilyfont{zhhei}{FZHei-B01}
        \setCJKfamilyfont{zhkai}{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKfamilyfont{zhfs}{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \ifdefstring{\SIMPLENOTE@cnfont}{NotoCJK}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %

        \setCJKmainfont{Noto Serif CJK SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKsansfont{Noto Sans CJK SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKmonofont{Noto Sans Mono CJK SC}[
            Script         = CJK,
        ]%

        \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhkai}{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKfamilyfont{zhfs}{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \ifdefstring{\SIMPLENOTE@cnfont}{SourceHan}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %

        \setCJKmainfont{Source Han Serif SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKsansfont{Source Han Sans SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKmonofont {FZFangSong-Z02} % 用方正字体是因为没有对应的Mono字体

        \setCJKfamilyfont{zhsong}{Source Han Serif SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhhei}{Source Han Sans SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhkai}{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKfamilyfont{zhfs}{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \AfterEndPreamble{\setlength\parindent{2\ccwd}}
}{\relax}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 基本的宏包

\RequirePackage{amsmath,amsthm,amsfonts,amssymb}
\RequirePackage{mathrsfs}
\RequirePackage{bm}
\RequirePackage{mathtools}
\RequirePackage{float}
\RequirePackage{appendix}
\RequirePackage{indentfirst}
\RequirePackage{xcolor}
\RequirePackage{silence}
\RequirePackage{anyfontsize}
\RequirePackage{xpatch}
\RequirePackage{extarrows}
\RequirePackage{booktabs,multirow,multicol}
\RequirePackage{calligra}
\RequirePackage{framed}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 中文模式和英文模式的各种引导词设置

\ifdefstring{\SIMPLENOTE@lang}{cn}{%
    % \theoremstyle{plain}% default
    % \newtheorem{theorem}{定理} %
    % \newtheorem{lemma}{引理} %
    % \newtheorem{proposition}{命题} %
    % \newtheorem*{corollary}{推论} %
    % \theoremstyle{definition} %
    % \newtheorem{definition}{定义} %
    % \newtheorem{example}{例} %
    % \theoremstyle{remark} %
    % \newtheorem*{remark}{\normalfont\bfseries 注} %
    % \newtheorem*{note}{\normalfont\bfseries 笔记} %

    % \newenvironment{problem}{\begin{shaded}\par\noindent {\color{ecolor}\normalfont\bfseries 题目 }}{\end{shaded}\par}
    % \newenvironment{solution}{\par\noindent {\color{ecolor}\normalfont\bfseries 解 }}{\par}


    \renewcommand\contentsname{\color{ecolor}目录}
    \renewcommand\figurename{图} %
    \renewcommand\tablename{表}
    \renewcommand\refname{\color{ecolor}参考文献} %
    \newcommand\figref[1]{图~\ref{#1}}
    \newcommand\tabref[1]{表~\ref{#1}}
    \renewcommand*{\proofname}{\normalfont\bfseries\color{ecolor}证明} %

    \newcommand{\notename}{笔记}
    \newcommand{\definitionname}{定义}
    \newcommand{\theoremname}{定理}
    \newcommand{\lemmaname}{引理}
    \newcommand{\propositionname}{命题}
    \newcommand{\corollaryname}{推论}
    \newcommand{\examplename}{例} %
    \newcommand{\problemname}{题目}
    \newcommand{\exercisename}{练习}
    \newcommand{\remarkname}{注}
    \newcommand{\solutionname}{解}
}{\relax}

\ifdefstring{\SIMPLENOTE@lang}{en}{
    % \theoremstyle{plain}% default
    % \newtheorem{theorem}{Theorem} %
    % \newtheorem{lemma}{Lemma} %
    % \newtheorem{proposition}{Proposition} %
    % \newtheorem*{corollary}{Corollary} %
    % \theoremstyle{definition} %
    % \newtheorem{definition}{Definition} %
    % \newtheorem{example}{Example} %
    % \theoremstyle{remark} %
    % \newtheorem*{remark}{Remark} %
    % \newtheorem*{note}{Note} %

    % \newenvironment{problem}{\begin{shaded}\par\noindent {\color{ecolor}\normalfont\bfseries Problem }}{\end{shaded}\par}
    % \newenvironment{solution}{\par\noindent {\color{ecolor}\normalfont\bfseries Solution }}{\par}

    \renewcommand*{\proofname}{\normalfont\bfseries\color{ecolor} Proof}
    \newcommand\figref[1]{Figure~\ref{#1}}
    \newcommand\tabref[1]{Table~\ref{#1}}

    \newcommand{\definitionname}{Definition}
    \newcommand{\theoremname}{Theorem}
    \newcommand{\lemmaname}{Lemma}
    \newcommand{\propositionname}{Proposition}
    \newcommand{\corollaryname}{Corollary}
    \newcommand{\examplename}{Example}
    \newcommand{\problemname}{Problem}
    \newcommand{\exercisename}{Exercise}
    \newcommand{\remarkname}{Remark}
    \newcommand{\solutionname}{Solution}
    \renewcommand{\appendixname}{Appendix}
}{\relax}


%% 中文字体配套
\ifcsname heiti\endcsname
    \newcommand{\cbfseries}{\heiti}
\else
    \newcommand{\cbfseries}{\bfseries}
\fi
\ifcsname kaishu\endcsname
    \newcommand{\citshape}{\kaishu}
\else
    \newcommand{\citshape}{\itshape}
\fi
\ifcsname kaishu\endcsname
    \newcommand{\cnormal}{\kaishu}
\else
    \newcommand{\cnormal}{\normalfont}
\fi
\ifcsname fangsong\endcsname
    \newcommand{\cfs}{\fangsong}
\else
    \newcommand{\cfs}{\normalfont}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 主题色选项 default blue

% 主题色ecolor
\ifdefstring{\SIMPLENOTE@color}{cyan}{
    \definecolor{ecolor}{RGB}{31,186,190}
}{\relax}
\ifdefstring{\SIMPLENOTE@color}{blue}{
    \definecolor{ecolor}{RGB}{1,126,218}
}{\relax}
\ifdefstring{\SIMPLENOTE@color}{black}{
    \definecolor{ecolor}{RGB}{0,0,0}
}{\relax}

% 阴影颜色
\definecolor{shadecolor}{RGB}{241, 241, 255}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 设备选项 default normal

\RequirePackage{geometry}
\WarningsOff
\RequirePackage[\SIMPLENOTE@fontsize]{extsizes}
\WarningsOn

\ifdefstring{\SIMPLENOTE@device}{normal}{ % A4
    \geometry{
        % A4: 21.0cm * 29.7cm
        margin=1in,
        a4paper}
}{\relax}

\ifdefstring{\SIMPLENOTE@device}{pad}{ % 3:4
    \geometry{
        paperwidth=7in,
        paperheight=10in,
        includefoot,
        margin=8mm}
}{\relax}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 超链接宏包和颜色，应用主题色
\RequirePackage{hyperref}
\hypersetup{%
    pdfborder={0 0 0},
    colorlinks,
    citecolor=ecolor,
    filecolor=ecolor,
    linkcolor=ecolor,
    urlcolor=ecolor
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 图片支持
\RequirePackage{graphicx}

\graphicspath{% graphics默认的图片查找路径
    {./figure/}{./figures/}{./image/}{./images/}{./graphic/}{./graphics/}{./picture/}{./pictures/}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caption细节设置
\RequirePackage{caption}
\RequirePackage{subcaption}

\captionsetup{labelfont={bf,color=ecolor}} % 设置粗体，使用主题色
\captionsetup[table]{skip=3pt} % 设置table的caption竖直间距
\captionsetup[figure]{skip=3pt} % 设置figure的caption竖直间距



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 行距细节设置
\linespread{1.3}
\setlength{\parskip}{3mm}
\setlength{\parindent}{2em}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 数学定理环境

% 两个样式
\newtheoremstyle{defstyle}{3pt}{3pt}{\citshape}{-3pt}{
    \bfseries\color{ecolor}}{}{0.5em}{\thmname{#1} \thmnumber{#2} \thmnote{(#3)}}
\newtheoremstyle{thmstyle}{3pt}{3pt}{\citshape}{-3pt}{
    \bfseries\color{ecolor}}{}{0.5em}{\thmname{#1} \thmnumber{#2} \thmnote{(#3)}}


\NewDocumentCommand \SIMPLENOTE@newtheorem { m m O{} } {
    \theoremstyle{#2}
    \ifblank{#3}{
        \newtheorem{#1}{\csname #1name\endcsname}
    }{
        \newtheorem{#1}[#3]{\csname #1name\endcsname}
    }
    \newtheorem*{#1*}{\csname #1name\endcsname}
}

% 五个主要的定理类环境
\SIMPLENOTE@newtheorem{definition}{defstyle}
\SIMPLENOTE@newtheorem{theorem}{thmstyle}
\SIMPLENOTE@newtheorem{lemma}{thmstyle}
\SIMPLENOTE@newtheorem{corollary}{thmstyle}
\SIMPLENOTE@newtheorem{proposition}{thmstyle}

%% 带编号的example
\newcounter{exam}
\setcounter{exam}{0}
\newenvironment{example}[1][]{
    \refstepcounter{exam}
    \par\noindent\textbf{\color{ecolor}{\examplename} \theexam #1 }\rmfamily}{
    \par\ignorespacesafterend}

%% 带编号的problem
\newcounter{prob}
\setcounter{prob}{0}
\newenvironment{problem}[1][]{
    \refstepcounter{prob}
    \par\noindent\textbf{\color{ecolor}{\problemname} \theprob #1 }\rmfamily}{
    \par\ignorespacesafterend}

%% 带编号的exercise
\newcounter{exer}
\setcounter{exer}{0}
\newenvironment{exercise}[1][]{
    \refstepcounter{exer}
    \par\noindent\textbf{\color{ecolor}{\exercisename} \theexer #1 }\rmfamily}{
    \par\ignorespacesafterend}

% 不带编号的note，remark，solution
\newenvironment{note}{\par\noindent\textbf{\color{ecolor}\notename} \citshape}{\par}
\newenvironment{remark}{\par\noindent\textbf{\color{ecolor}\remarkname} \citshape}{\par}
\newenvironment{solution}{\par\noindent\textbf{\color{ecolor}\solutionname} \cfs}{\par}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% list/itemize/enumerate细节设置
\RequirePackage[shortlabels,inline]{enumitem}
\setlist{nolistsep} % 调整间距细节

% 基于tikz绘制的无序列表序号样式
\RequirePackage{tikz}
\usetikzlibrary{shapes}

\newcommand*{\eitemi}{\tikz\draw[baseline,fill=ecolor,draw=none] circle (2pt);}
\newcommand*{\eitemii}{\tikz\draw[baseline, fill=ecolor, draw=none, rectangle] (0,0) rectangle (4pt,4pt);}
\newcommand*{\eitemiii}{\tikz\draw[baseline, fill=ecolor, draw=none, diamond]  (3pt,0) -- (0,3pt) -- (-3pt,0) -- (0,-3pt) -- cycle;}
\newcommand*{\eitemiv}{\tikz\draw[baseline, fill=ecolor, draw=none, regular polygon, regular polygon sides=3] (0,0) -- (0,4pt) -- (4.5pt,2pt) -- cycle;}

\setlist[itemize]{label={\eitemi}} % default 圆点
\setlist[itemize,1]{label={\eitemi}} % 圆点
\setlist[itemize,2]{label={\eitemii}} % 矩形
\setlist[itemize,3]{label={\eitemiii}} % 菱形
\setlist[itemize,4]{label={\eitemiv}} % 三角形

% 重写有序列表的样式，其实仍然是默认样式，只是改为使用主题颜色
\setlist[enumerate,1]{label=\color{ecolor}\arabic*.}
\setlist[enumerate,2]{label=\color{ecolor}(\alph*)}
\setlist[enumerate,3]{label=\color{ecolor}\roman*.}
\setlist[enumerate,4]{label=\color{ecolor}\Alph*.}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% title细节设置，应用主题色
\RequirePackage{titlesec}

\titleformat*{\section}{\normalfont\Large\bfseries\color{ecolor}}
\titleformat*{\subsection}{\normalfont\large\bfseries\color{ecolor}}
\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries\color{ecolor}}
% 上面的样式设置同样对\section*等生效


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 脚注设置
\RequirePackage[flushmargin,stable]{footmisc} % flushmargin 取消脚注相对于正文的缩进
\setlength{\footnotesep}{12pt} % 脚注间的竖直间距


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 页眉页脚细节设置
\RequirePackage{fancyhdr}

\renewcommand{\headrulewidth}{0pt} % 不显示页眉横线
\renewcommand{\footrulewidth}{0pt} % 不显示页脚横线

% 定义fancy-simplenote风格
\fancypagestyle{fancy-simplenote}{
    \fancyhf{} % 清理默认设置
    \fancyfoot[C]{\footnotesize\thepage}
}

% 重定义plain风格（因为可能被自动用于章节首页等）
\fancypagestyle{plain}{%
    \fancyhf{} % 清理默认设置
    \fancyfoot[C]{\footnotesize\thepage}
}

% 应用fancy-simplenote风格
\pagestyle{fancy-simplenote}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 算法和代码环境支持

\RequirePackage[ruled,linesnumbered,noline]{algorithm2e}

\RequirePackage{listings,lstautogobble}
% 定义一个simplestyle并且应用
\lstdefinestyle{simplestyle}{
    basicstyle=\small\ttfamily,
    commentstyle=\color[RGB]{34,139,34},
    keywordstyle=\color[RGB]{0,0,255},
    numberstyle=\tiny\color{gray},
    stringstyle=\color[RGB]{128,0,128},
    identifierstyle=\color{black},
    showstringspaces=false,
    tabsize=4,
    breaklines=true,
    numbers=left,
    frame=single,
    rulecolor=\color{black},
    captionpos=b,
    xleftmargin=\parindent,
    aboveskip=\baselineskip,
    belowskip=\baselineskip,
    escapeinside={\%*}{*)},
}
\lstset{style=simplestyle}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 定义\maketitle（在内部会调用\@maketitle）
\renewcommand\maketitle{%
\par
\begingroup % 开始一个group，内部的所有配置都是局部的，不会影响到外部

\renewcommand\thefootnote{\@fnsymbol\c@footnote} % 重新定义脚注的样式，不采用默认数字，而是十字架或星号等特殊符号
\def\@makefnmark{
    \rlap{\@textsuperscript{\normalfont\@thefnmark}}
} % 定义了排版脚注标记在文本中的呈现细节
\long\def\@makefntext##1{
\parindent 1em\noindent
\hb@xt@1.8em{\hss\@textsuperscript{\normalfont\@thefnmark}}##1
}% 定义了脚注文本的排版细节，包括缩进等

% 判断单栏或两栏，并调用\@maketitle命令（在下面重定义）
\if@twocolumn % 两栏
    \ifnum \col@number=\@ne % 处于两栏模式下的第一页，会占据两栏展示标题部分
        \@maketitle
    \else
        \twocolumn[\@maketitle] % 不在第一页则只会占据一栏显示
    \fi
\else % 单栏
    \newpage
    \global\@topnum\z@  % 阻止浮动体出现在title页的顶部
    \@maketitle
\fi

\thispagestyle{plain} % 设置页眉页脚的风格为plain

\@thanks % 打印\thanks的内容（显示在脚注中）

\endgroup % 结束当前group


\setcounter{footnote}{0}% 将脚注计数器置零

% 将相关命令清空
\global\let\thanks\relax
\global\let\maketitle\relax
\global\let\@maketitle\relax
\global\let\title\relax
\global\let\author\relax
\global\let\date\relax
\global\let\and\relax
\global\let\SIMPLENOTE@version\relax

% 将相关定义清空
\global\let\@thanks\@empty
\global\let\@author\@empty
\global\let\@SIMPLENOTE@version\@empty
\global\let\@date\@empty
\global\let\@title\@empty

}


% 定义\@maketitle
\def\@maketitle{%
    \color{ecolor} % 使用主题色
    \null % 插入一个空盒子
    \vskip 2em % 插入垂直间距

    % 下面的内容居中排版
    \begin{center}%
        \let \footnote \thanks % 将\footnote命令归于\thanks

        {\LARGE\bfseries \@title \par} % 标题显示

        \vskip 1.5em % 插入垂直间距

            {\large
                \begin{tabular}[t]{c} % 作者显示
                    \@author
                \end{tabular}

                \normalfont\citshape\@date % 日期显示
            }

    \end{center}
    \par
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
