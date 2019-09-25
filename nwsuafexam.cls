%版本信息
\NeedsTeXFormat{LaTeX2e}[2007/10/19]
\ProvidesClass{nwsuafexam}
[2016/01/04 v0.1 nwsuafexam
document class]

%定义条件变量
\newif\if@sealed\@sealedfalse%密封试卷
\newif\if@contitemcnt\@contitemcntfalse%连续编号
\newif\if@cancelspace\@cancelspacefalse%忽略答题空白
\newif\if@prescorebox\@prescoreboxfalse%前置评分框
\newif\if@Tailscore\@Tailscorefalse%分值显示位置（分题目开头和右边界）

%设置文档类选项
\DeclareOption{sealed}{\@sealedtrue}%密封试卷
\DeclareOption{contitemcnt}{\@contitemcnttrue}%连续编号
\DeclareOption{answers}{\PassOptionsToClass{\CurrentOption}{exam}}%显示答案
\DeclareOption{cancelspace}{\PassOptionsToClass{\CurrentOption}{exam} \@cancelspacetrue}%忽略答题空白
\DeclareOption{prescorebox}{\@prescoreboxtrue}%前置评分框
\DeclareOption{Tailscore}{\@Tailscoretrue}%分数显示位置（分题目开头和右边界两种）
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions

%引入宏包和文档类
\LoadClass{exam}
\RequirePackage[scheme=chinese,zihao=-4,
punct=kaiming,linespread=1.25]{ctex}%排版方案为chinese，字号为小四，标点符号的处理格式为开明式，行距设为1.5倍（一般为1.2倍行距，所以1.5/1.2为1.25）
\RequirePackage{amsmath,amssymb,amsthm,bm,dsfont,cases,mathtools}%数学公式排版以及相关数学字体
\RequirePackage{bbding,pifont}%图形符号宏包
\RequirePackage{graphicx,verbatim}%插图、代码环境
\RequirePackage{ulem,tabularx}%下划线、自动计算列宽的表格


%重定义字号命令,方便使用
\newcommand{\xiaoliu}{\tiny}
\newcommand{\liuhao}{\scriptsize}
\newcommand{\xiaowu}{\footnotesize}
\newcommand{\wuhao}{\small}
\newcommand{\xiaosan}{\large}
\newcommand{\xiaoer}{\Large}
\newcommand{\erhao}{\LARGE}
\newcommand{\xiaoyi}{\huge}
\newcommand{\yihao}{\Huge}

%为密封卷和普通卷设置不同的页面参数
\if@sealed
\RequirePackage[paper=a4paper,margin=3.3cm,
marginparwidth=2cm,marginparsep=0.5cm]{geometry}%密封卷
\else
\RequirePackage[paper=a4paper,hmargin=2.3cm,
top=1.5cm,bottom=2cm,headsep=10pt,footskip=20pt]{geometry}%普通卷
\fi

%页眉页脚
\pagestyle{headandfoot}
\runningheader{}{\heiti \@papertitle}{} %页眉内容，\@papertitle为试卷标题变量
\runningheadrule %页眉水平线
\cfoot{第 \thepage 页，共 \numpages 页}%页码
\rfoot{\iflastpage{试卷结束}{\ifincomplete{题目 \IncompleteQuestion 下页续 \ldots}{}}}%页脚提示信息


%----设置分值显示位置和格式
\if@Tailscore
\pointsinrightmargin
\marginpointname{分}
\pointformat{\kaishu (\themarginpoints)}
\else
\pointname{分}
\pointformat{\kaishu ~(\thepoints)}
\fi

%设置questions环境参数
\renewcommand{\questionshook}{%题目之间增加当前字号下0.5倍的小写字母x高度的空白
	\setlength{\itemsep}{0.5ex}
}
%设置二级和三级题目样式及参数
\renewcommand{\thepartno}{\arabic{partno}}
\renewcommand{\partlabel}{(\thepartno)}
\renewcommand{\subpartlabel}{[\thesubpart]}
\renewcommand{\partshook}{%parts环境前后增加当前字号下0.5倍的小写字母x高度的空白
	\setlength{\topsep}{0.5ex}
}

%根据sealed选项设计密封线
\if@sealed
\input{sty/SealedLine.sty}
\fi

%试卷基本信息设计
\input{sty/PaperInformation.sty}

%主题干的设计
\input{sty/MainQuestion.sty}

%各类题型的设计
\input{sty/AllQuestion.sty}

%插图功能的设计
\input{sty/InsertGraph.sty}

%常用数学符号简化
\input{sty/MathSymbol.sty}

%答题卡的设计
\input{sty/AnswerCard.sty}
