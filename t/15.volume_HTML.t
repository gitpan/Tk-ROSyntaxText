#!perl

#   15.volume_HTML.t

use strict;
use warnings;
use English qw{-no_match_vars};
use Test::More 0.94;

use Tk;
use Tk::ROSyntaxText;

my $mw = eval { MainWindow->new(
    -title => q{Tk::ROSyntaxText: 15.volume_HTML.t},
); };

if ($mw) {
    plan tests => 3;
}
else {
    plan skip_all => q{No display detected.};
}

my $rosyn = eval { $mw->ScrlROSyntaxText(-syntax_lang => q{HTML}, -dark_style => 1); };

ok(! $EVAL_ERROR, q{Test widget instantiaton})
    or diag $EVAL_ERROR;

eval { $rosyn->pack(-fill => q{both}, -expand => 1); };

ok(! $EVAL_ERROR, q{Test widget packing})
    or diag $EVAL_ERROR;

my $code_for_scrolling = <<'END_CODE';
<!--
    2946 lines of HTML code
    Source: http://www.w3.org/TR/html401/struct/tables.html
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tables in HTML documents</title>
<link rel="previous" href="lists.html">
<link rel="next" href="links.html">
<link rel="contents" href="../cover.html#toc">
<link rel="stylesheet" type="text/css" href= 
"http://www.w3.org/StyleSheets/TR/W3C-REC">
<link rel="STYLESHEET" href="../style/default.css" type="text/css">
</head>
<body>
<div class="navbar" align="center">&nbsp;<a href="lists.html">previous</a>
&nbsp; <a href="links.html">next</a> &nbsp; <a href="../cover.html#minitoc">
contents</a> &nbsp; <a href="../index/elements.html">elements</a> &nbsp; <a
href="../index/attributes.html">attributes</a> &nbsp; <a href= 
"../index/list.html">index</a> 

<hr></div>

<h1 align="center"><a name="h-11">11</a> Tables</h1>

<div class="subtoc">
<p><strong>Contents</strong></p>

<ol>
<li><a class="tocxref" href="#h-11.1">Introduction to tables</a></li>

<li><a class="tocxref" href="#h-11.2">Elements for constructing tables</a> 

<ol>
<li><a class="tocxref" href="#h-11.2.1">The <samp class="einst2">TABLE</samp>
element</a> 

<ul>
<li><a class="tocxref" href="#h-11.2.1.1">Table directionality</a></li>
</ul>
</li>

<li><a class="tocxref" href="#h-11.2.2">Table Captions: The <samp class=
"einst2">CAPTION</samp> element</a></li>

<li><a class="tocxref" href="#h-11.2.3">Row groups: the <samp class="einst2">
THEAD</samp>, <samp class="einst2">TFOOT</samp>, and <samp class="einst2">
TBODY</samp> elements</a></li>

<li><a class="tocxref" href="#h-11.2.4">Column groups: the <samp class=
"einst2">COLGROUP</samp> and <samp class="einst2">COL</samp> elements</a> 

<ul>
<li><a class="tocxref" href="#h-11.2.4.1">The <samp class="einst2">
COLGROUP</samp> element</a></li>

<li><a class="tocxref" href="#h-11.2.4.2">The <samp class="einst2">COL</samp>
element</a></li>

<li><a class="tocxref" href="#h-11.2.4.3">Calculating the number of columns in
a table</a></li>

<li><a class="tocxref" href="#h-11.2.4.4">Calculating the width of
columns</a></li>
</ul>
</li>

<li><a class="tocxref" href="#h-11.2.5">Table rows: The <samp class="einst2">
TR</samp> element</a></li>

<li><a class="tocxref" href="#h-11.2.6">Table cells: The <samp class="einst2">
TH</samp> and <samp class="einst2">TD</samp> elements</a> 

<ul>
<li><a class="tocxref" href="#h-11.2.6.1">Cells that span several rows or
columns</a></li>
</ul>
</li>
</ol>
</li>

<li><a class="tocxref" href="#h-11.3">Table formatting by visual user
agents</a> 

<ol>
<li><a class="tocxref" href="#h-11.3.1">Borders and rules</a></li>

<li><a class="tocxref" href="#h-11.3.2">Horizontal and vertical alignment</a> 

<ul>
<li><a class="tocxref" href="#h-11.3.2.1">Inheritance of alignment
specifications</a></li>
</ul>
</li>

<li><a class="tocxref" href="#h-11.3.3">Cell margins</a></li>
</ol>
</li>

<li><a class="tocxref" href="#h-11.4">Table rendering by non-visual user
agents</a> 

<ol>
<li><a class="tocxref" href="#h-11.4.1">Associating header information with
data cells</a></li>

<li><a class="tocxref" href="#h-11.4.2">Categorizing cells</a></li>

<li><a class="tocxref" href="#h-11.4.3">Algorithm to find heading
information</a></li>
</ol>
</li>

<li><a class="tocxref" href="#h-11.5">Sample table</a></li>
</ol>
</div>

<h2><a name="h-11.1">11.1</a> Introduction to tables</h2>

<p>The HTML table model allows authors to arrange data -- text, preformatted
text, images, links, forms, form fields, other tables, etc. -- into rows and
columns of cells.</p>

<p>Each table may have an associated caption (see the <a href= 
"tables.html#edef-CAPTION" class="noxref"><samp class="einst">
CAPTION</samp></a> element) that provides a short description of the table's
purpose. A longer description may also be provided (via the <a href= 
"tables.html#adef-summary" class="noxref"><samp class="ainst">
summary</samp></a> attribute) for the benefit of people using speech or
Braille-based user agents.</p>

<p><a href="#rowgroups">Table rows</a> may be grouped into a head, foot, and
body sections, (via the <a href="tables.html#edef-THEAD" class="noxref"><samp
class="einst">THEAD</samp></a>, <a href="tables.html#edef-TFOOT" class=
"noxref"><samp class="einst">TFOOT</samp></a> and <a href= 
"tables.html#edef-TBODY" class="noxref"><samp class="einst">TBODY</samp></a>
elements, respectively). Row groups convey additional structural information
and may be rendered by user agents in ways that emphasize this structure. User
agents may exploit the head/body/foot division to support scrolling of body
sections independently of the head and foot sections. When long tables are
printed, the head and foot information may be repeated on each page that
contains table data.</p>

<p>Authors may also <a href="#colgroups">group columns</a> to provide
additional structural information that may be exploited by user agents.
Furthermore, authors may declare column properties at the start of a table
definition (via the <a href="tables.html#edef-COLGROUP" class="noxref"><samp
class="einst">COLGROUP</samp></a> and <a href="tables.html#edef-COL" class= 
"noxref"><samp class="einst">COL</samp></a> elements) in a way that enables
user agents to render the table incrementally rather than having to wait for
all the table data to arrive before rendering.</p>

<p><a href="#cells">Table cells</a> may either contain "header" information
(see the <a href="tables.html#edef-TH" class="noxref"><samp class="einst">
TH</samp></a> element) or "data" (see the <a href="tables.html#edef-TD" class= 
"noxref"><samp class="einst">TD</samp></a> element). Cells may span multiple
rows and columns. The HTML 4 table model allows authors to label each cell so
that <a href="#non-visual-rendering">non-visual user agents</a> may more easily
communicate heading information about the cell to the user. Not only do these
mechanisms greatly assist users with visual disabilities, they make it possible
for multi-modal wireless browsers with limited display capabilities (e.g.,
Web-enabled pagers and phones) to handle tables.</p>

<p>Tables should not be used purely as a means to layout document content as
this may present problems when rendering to non-visual media. Additionally,
when used with graphics, these tables may force users to scroll horizontally to
view a table designed on a system with a larger display. To minimize these
problems, authors should use <a href="../present/styles.html">style sheets</a>
to control layout rather than tables.</p>

<div class="note">
<p><em><strong>Note.</strong> This specification includes more detailed
information about tables in sections on <a href= 
"../appendix/notes.html#notes-tables">table design rationale and implementation
issues</a>.</em></p>
</div>

<div class="example">
<p>Here's a simple table that illustrates some of the features of the HTML
table model. The following table definition:</p>

<pre>
&lt;TABLE border="1"
          summary="This table gives some statistics about fruit
                   flies: average height and weight, and percentage
                   with red eyes (for both males and females)."&gt;
&lt;CAPTION&gt;&lt;EM&gt;A test table with merged cells&lt;/EM&gt;&lt;/CAPTION&gt;
&lt;TR&gt;&lt;TH rowspan="2"&gt;&lt;TH colspan="2"&gt;Average
    &lt;TH rowspan="2"&gt;Red&lt;BR&gt;eyes
&lt;TR&gt;&lt;TH&gt;height&lt;TH&gt;weight
&lt;TR&gt;&lt;TH&gt;Males&lt;TD&gt;1.9&lt;TD&gt;0.003&lt;TD&gt;40%
&lt;TR&gt;&lt;TH&gt;Females&lt;TD&gt;1.7&lt;TD&gt;0.002&lt;TD&gt;43%
&lt;/TABLE&gt;
</pre>

<p>might be rendered something like this on a tty device:</p>

<pre>
          A test table with merged cells
    /-----------------------------------------\
    |          |      Average      |   Red    |
    |          |-------------------|  eyes    |
    |          |  height |  weight |          |
    |-----------------------------------------|
    |  Males   | 1.9     | 0.003   |   40%    |
    |-----------------------------------------|
    | Females  | 1.7     | 0.002   |   43%    |
    \-----------------------------------------/
</pre>

<p>or like this by a graphical user agent:</p>

<p><img src="../images/mergedcells.gif" alt="A table with merged cells"></p>
</div>

<h2><a name="h-11.2">11.2</a> Elements for constructing tables</h2>

<h3><a name="h-11.2.1">11.2.1</a> The <a name="edef-TABLE"><samp class="edef">
TABLE</samp></a> element</h3>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-TABLE" class="noxref"><samp class=
"einst">TABLE</samp></a> - -
     (CAPTION?, (COL*|COLGROUP*), THEAD?, TFOOT?, TBODY+)&gt;
&lt;!ATTLIST TABLE                        -- table element --
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  <a href="tables.html#adef-summary" class="noxref"><samp class=
"ainst-TABLE">summary</samp></a>     <a href=
"../sgml/dtd.html#Text">%Text;</a>         #IMPLIED  -- purpose/structure for speech output--
  <a href="tables.html#adef-width-TABLE" class="noxref"><samp class=
"ainst-TABLE">width</samp></a>       <a href=
"../sgml/dtd.html#Length">%Length;</a>       #IMPLIED  -- table width --
  <a href="tables.html#adef-border-TABLE" class="noxref"><samp class= 
"ainst-TABLE">border</samp></a>      <a href=
"../sgml/dtd.html#Pixels">%Pixels;</a>       #IMPLIED  -- controls frame width around table --
  <a href="tables.html#adef-frame" class="noxref"><samp class=
"ainst-TABLE">frame</samp></a>       <a href=
"../sgml/dtd.html#TFrame">%TFrame;</a>       #IMPLIED  -- which parts of frame to render --
  <a href="tables.html#adef-rules" class="noxref"><samp class=
"ainst-TABLE">rules</samp></a>       <a href=
"../sgml/dtd.html#TRules">%TRules;</a>       #IMPLIED  -- rulings between rows and cols --
  <a href="tables.html#adef-cellspacing" class="noxref"><samp class=
"ainst-TABLE">cellspacing</samp></a> <a href=
"../sgml/dtd.html#Length">%Length;</a>       #IMPLIED  -- spacing between cells --
  <a href="tables.html#adef-cellpadding" class="noxref"><samp class=
"ainst-TABLE">cellpadding</samp></a> <a href=
"../sgml/dtd.html#Length">%Length;</a>       #IMPLIED  -- spacing within cells --
  &gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
required</strong></em></p>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-summary"><samp class="adef">summary</samp></a> = <a href= 
"../types.html#type-text"><em>text</em></a> <a href= 
"../types.html#case-sensitive">[CS]</a></dt>

<dd>This attribute provides a summary of the table's purpose and structure for
user agents rendering to non-visual media such as speech and Braille.</dd>

<dt><a name="adef-align-TABLE"><samp class="adef">align</samp></a> = <samp>
left|center|right</samp> <a href="../types.html#case-insensitive">[CI]</a></dt>

<dd><a href="../conform.html#deprecated"><strong>Deprecated.</strong></a> This
attribute specifies the position of the table with respect to the document.
Permitted values: 

<ul>
<li><samp>left:</samp> The table is to the left of the document.</li>

<li><samp>center:</samp> The table is to the center of the document.</li>

<li><samp>right:</samp> The table is to the right of the document.</li>
</ul>
</dd>

<dt><a name="adef-width-TABLE"><samp class="adef">width</samp></a> = <a href= 
"../types.html#type-length"><em>length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies the desired width of the entire table and is
intended for visual user agents. When the value is a percentage value, the
value is relative to the user agent's available horizontal space. In the
absence of any width specification, table width is determined by the user
agent.</dd>
</dl>
</div>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a>)</li>

<li><a href="../present/graphics.html#adef-bgcolor" class="noxref"><samp class= 
"ainst">bgcolor</samp></a> (<a href=
"../present/graphics.html#background-color">background color</a>)</li>

<li><a href="tables.html#adef-frame" class="noxref"><samp class="ainst">
frame</samp></a>, <a href="tables.html#adef-rules" class="noxref"><samp class= 
"ainst-TABLE">rules</samp></a>, <a href="tables.html#adef-border-TABLE" class= 
"noxref"><samp class="ainst-TABLE">border</samp></a> (<a href=
"#borders">borders and rules</a>)</li>

<li><a href="tables.html#adef-cellspacing" class="noxref"><samp class="ainst">
cellspacing</samp></a>, <a href="tables.html#adef-cellpadding" class="noxref">
<samp class="ainst">cellpadding</samp></a> (<a href="#margins">cell
margins</a>)</li>
</ul>
</div>

<p>The <a href="tables.html#edef-TABLE" class="noxref"><samp class="einst">
TABLE</samp></a> element contains all other elements that specify caption,
rows, content, and formatting.</p>

<p>The following informative list describes what operations user agents may
carry out when rendering a table:</p>

<ul>
<li>Make the table <a href="tables.html#adef-summary" class="noxref"><samp
class="ainst">summary</samp></a> available to the user. Authors should provide
a summary of a table's content and structure so that people using non-visual
user agents may better understand it.</li>

<li>Render the caption, if one is defined.</li>

<li>Render the table header, if one is specified. Render the table footer, if
one is specified. User agents must know where to render the header and footer.
For instance, if the output medium is paged, user agents may put the header at
the top of each page and the footer at the bottom. Similarly, if the user agent
provides a mechanism to scroll the rows, the header may appear at the top of
the scrolled area and the footer at the bottom.</li>

<li>Calculate the <a href="#column-calc">number of columns</a> in the table.
<span class="index-inst" title="table::number of rows|row::number of in table">
<a name="idx-table">Note that the number of rows in a table</a></span> is equal
to the number of <a href="tables.html#edef-TR" class="noxref"><samp class=
"einst">TR</samp></a> elements contained by the <a href=
"tables.html#edef-TABLE" class="noxref"><samp class="einst">TABLE</samp></a>
element.</li>

<li>Group the columns according to any <a href="#colgroups">column group</a>
specifications.</li>

<li>Render the cells, row by row and grouped in appropriate columns, between
the header and footer. Visual user agents should <a href="#visual-formatting">
format the table</a> according to HTML attributes and style sheet
specification.</li>
</ul>

<p>The HTML table model has been designed so that, with author assistance, user
agents may render tables <span class="index-inst" title="table::incremental 
rendering of"><a name="idx-table-1"><em>incrementally</em></a></span> (i.e., as
table rows arrive) rather than having to wait for all the data before beginning
to render.</p>

<p>In order for a user agent to format a table in one pass, authors must tell
the user agent:</p>

<ul>
<li>The number of columns in the table. Please consult the section on <a href= 
"#column-calc">calculating the number of columns in a table</a> for details on
how to supply this information.</li>

<li>The widths of these columns. Please consult the section on <a href= 
"#column-width">calculating the width of columns</a> for details on how to
supply this information.</li>
</ul>

<p>More precisely, a user agent may render a table in a single pass when the
column widths are specified using a combination of <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> and <a href="tables.html#edef-COL" class="noxref"><samp
class="einst">COL</samp></a> elements. If any of the columns are specified in
relative or percentage terms (see the section on <a href="#column-width">
calculating the width of columns</a>), authors must also specify the width of
the table itself.</p>

<h4><a name="table-directionality">Table directionality</a><a name=
"h-11.2.1.1">&nbsp;</a></h4>

<p>The <span class="index-inst" title="table::directionality of|direction::of 
table information"><a name="idx-table-2">directionality of a table</a></span>
is either the inherited directionality (the default is left-to-right) or that
specified by the <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> attribute for the <a href="tables.html#edef-TABLE"
class="noxref"><samp class="einst">TABLE</samp></a> element.</p>

<p>For a left-to-right table, column zero is on the left side and row zero is
at the top. For a right-to-left table, column zero is on the right side and row
zero is at the top.</p>

<p>When a user agent allots extra cells to a row (see the section on <a href= 
"#column-calc">calculating the number of columns in a table</a>), extra row
cells are added to the right of the table for left-to-right tables and to the
left side for right-to-left tables.</p>

<p>Note that <a href="tables.html#edef-TABLE" class="noxref"><samp class=
"einst">TABLE</samp></a> is the only element on which <a href= 
"dirlang.html#adef-dir" class="noxref"><samp class="ainst">dir</samp></a>
reverses the visual order of the columns; a single table row (<a href= 
"tables.html#edef-TR" class="noxref"><samp class="einst">TR</samp></a>) or a
group of columns (<a href="tables.html#edef-COLGROUP" class="noxref"><samp
class="einst">COLGROUP</samp></a>) cannot be independently reversed.</p>

<p>When set for the <a href="tables.html#edef-TABLE" class="noxref"><samp
class="einst">TABLE</samp></a> element, the <a href="dirlang.html#adef-dir"
class="noxref"><samp class="ainst">dir</samp></a> attribute also affects the
direction of text within table cells (since the <a href="dirlang.html#adef-dir"
class="noxref"><samp class="ainst">dir</samp></a> attribute is inherited by
block-level elements).</p>

<div class="example">
<p>To specify a right-to-left table, set the <a href="dirlang.html#adef-dir"
class="noxref"><samp class="ainst">dir</samp></a> attribute as follows:</p>

<pre>
&lt;TABLE dir="RTL"&gt;
<em>...the rest of the table...</em>
&lt;/TABLE&gt;
</pre>
</div>

<p>The direction of text in individual cells can be changed by setting the <a
href="dirlang.html#adef-dir" class="noxref"><samp class="ainst">dir</samp></a>
attribute in an element that defines the cell. Please consult the section on <a
href="./dirlang.html#bidirection">bidirectional text</a> for more information
on text direction issues.</p>

<h3><a name="h-11.2.2">11.2.2</a> <a name="caption">Table Captions:</a> The <a
name="edef-CAPTION"><samp class="edef">CAPTION</samp></a> element</h3>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-CAPTION" class="noxref"><samp class= 
"einst">CAPTION</samp></a>  - - (<a href=
"../sgml/dtd.html#inline">%inline;</a>)*     -- table caption --&gt;

&lt;!ATTLIST CAPTION
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  &gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
required</strong></em></p>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-align-CAPTION"><samp class="adef">align</samp></a> = <samp>
top|bottom|left|right</samp> <a href="../types.html#case-insensitive">
[CI]</a></dt>

<dd><a href="../conform.html#deprecated"><strong>Deprecated.</strong></a> For
visual user agents, this attribute specifies the position of the caption with
respect to the table. Possible values: 

<ul>
<li><samp>top:</samp> The caption is at the top of the table. This is the
default value.</li>

<li><samp>bottom:</samp> The caption is at the bottom of the table.</li>

<li><samp>left:</samp> The caption is at the left of the table.</li>

<li><samp>right:</samp> The caption is at the right of the table.</li>
</ul>
</dd>
</dl>
</div>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a> )</li>
</ul>
</div>

<p>When present, the <a href="tables.html#edef-CAPTION" class="noxref"><samp
class="einst">CAPTION</samp></a> element's text should <span class="index-inst"
title="table::caption for"><a name="idx-table-3">describe the nature of the
table.</a></span> The <a href="tables.html#edef-CAPTION" class="noxref"><samp
class="einst">CAPTION</samp></a> element is only permitted immediately after
the <a href="tables.html#edef-TABLE" class="noxref"><samp class="einst">
TABLE</samp></a> start tag. A <a href="tables.html#edef-TABLE" class="noxref">
<samp class="einst">TABLE</samp></a> element may only contain one <a href= 
"tables.html#edef-CAPTION" class="noxref"><samp class="einst">
CAPTION</samp></a> element.</p>

<p>Visual user agents allow sighted people to quickly grasp the structure of
the table from the headings as well as the caption. A consequence of this is
that captions will often be inadequate as a summary of the purpose and
structure of the table from the perspective of people relying on non-visual
user agents.</p>

<p><span class="index-inst" title="table::summary of contents|summary::of table 
contents"><a name="idx-table-4">Authors should therefore take care to provide
additional</a></span> information summarizing the purpose and structure of the
table using the <a href="tables.html#adef-summary" class="noxref"><samp class= 
"ainst">summary</samp></a> attribute of the <a href="tables.html#edef-TABLE"
class="noxref"><samp class="einst">TABLE</samp></a> element. This is especially
important for tables without captions. Examples below illustrate the use of the
<a href="tables.html#adef-summary" class="noxref"><samp class="ainst">
summary</samp></a> attribute.</p>

<p>Visual user agents should avoid <span class="index-inst" title= 
"clipping::table text"><a name="idx-clipping">clipping</a></span> any part of
the table including the caption, unless a means is provided to access all
parts, e.g., by horizontal or vertical scrolling. We recommend that the caption
text be wrapped to the same width as the table. (See also the section on <a
href="../appendix/notes.html#layout">recommended layout algorithms</a>.)</p>

<h3><a name="h-11.2.3">11.2.3</a> <a name="rowgroups">Row groups:</a> the <a
name="edef-THEAD"><samp class="edef">THEAD</samp></a>, <a name="edef-TFOOT">
<samp class="edef">TFOOT</samp></a>, and <a name="edef-TBODY"><samp class=
"edef">TBODY</samp></a> elements</h3>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-THEAD" class="noxref"><samp class=
"einst">THEAD</samp></a>    - O (TR)+           -- table header --&gt;
&lt;!ELEMENT <a href="tables.html#edef-TFOOT" class="noxref"><samp class=
"einst">TFOOT</samp></a>    - O (TR)+           -- table footer --&gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
optional</strong></em></p>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-TBODY" class="noxref"><samp class=
"einst">TBODY</samp></a>    O O (TR)+           -- table body --&gt;
</pre>
</div>

<p><em>Start tag: <strong>optional</strong>, End tag: <strong>
optional</strong></em></p>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ATTLIST (THEAD|TBODY|TFOOT)          -- table section --
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  <a href=
"../sgml/dtd.html#cellhalign">%cellhalign;</a>                         -- horizontal alignment in cells --
  <a href=
"../sgml/dtd.html#cellvalign">%cellvalign;</a>                         -- vertical alignment in cells --
  &gt;
</pre>
</div>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a> )</li>

<li><a href="tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a>, <a href="tables.html#adef-char" class="noxref"><samp class= 
"ainst">char</samp></a>, <a href="tables.html#adef-charoff" class="noxref">
<samp class="ainst">charoff</samp></a>, <a href="tables.html#adef-valign"
class="noxref"><samp class="ainst">valign</samp></a> (<a href="#alignment">cell
alignment</a>)</li>
</ul>
</div>

<p><span class="index-inst" title="row group|table::row group in"><a name= 
"idx-row_group">Table rows may be grouped</a></span> into a table head, table
foot, and one or more table body sections, using the <a href= 
"tables.html#edef-THEAD" class="noxref"><samp class="einst">THEAD</samp></a>,
<a href="tables.html#edef-TFOOT" class="noxref"><samp class="einst">
TFOOT</samp></a> and <a href="tables.html#edef-TBODY" class="noxref"><samp
class="einst">TBODY</samp></a> elements, respectively. This division enables
user agents to support scrolling of table bodies independently of the table
head and foot. When long tables are printed, the table head and foot
information may be repeated on each page that contains table data.</p>

<p>The table head and table foot should contain information about the table's
columns. The table body should contain rows of table data.</p>

<p>When present, each <a href="tables.html#edef-THEAD" class="noxref"><samp
class="einst">THEAD</samp></a>, <a href="tables.html#edef-TFOOT" class=
"noxref"><samp class="einst">TFOOT</samp></a>, and <a href= 
"tables.html#edef-TBODY" class="noxref"><samp class="einst">TBODY</samp></a>
contains a <em>row group</em>. Each row group must contain at least one row,
defined by the <a href="tables.html#edef-TR" class="noxref"><samp class=
"einst">TR</samp></a> element.</p>

<div class="example">
<p>This example illustrates the order and structure of table heads, feet, and
bodies.</p>

<pre>
&lt;TABLE&gt;
&lt;THEAD&gt;
     &lt;TR&gt; <em>...header information...</em>
&lt;/THEAD&gt;
&lt;TFOOT&gt;
     &lt;TR&gt; <em>...footer information...</em>
&lt;/TFOOT&gt;
&lt;TBODY&gt;
     &lt;TR&gt; <em>...first row of block one data...</em>
     &lt;TR&gt; <em>...second row of block one data...</em>
&lt;/TBODY&gt;
&lt;TBODY&gt;
     &lt;TR&gt; <em>...first row of block two data...</em>
     &lt;TR&gt; <em>...second row of block two data...</em>
     &lt;TR&gt; <em>...third row of block two data...</em>
&lt;/TBODY&gt;
&lt;/TABLE&gt;
</pre>
</div>

<p><a href="tables.html#edef-TFOOT" class="noxref"><samp class="einst">
TFOOT</samp></a> must appear before <a href="tables.html#edef-TBODY" class= 
"noxref"><samp class="einst">TBODY</samp></a> within a <a href= 
"tables.html#edef-TABLE" class="noxref"><samp class="einst">TABLE</samp></a>
definition so that user agents can render the foot before receiving all of the
(potentially numerous) rows of data. The following summarizes which tags are
required and which may be omitted:</p>

<ul>
<li>The <a href="tables.html#edef-TBODY" class="noxref"><samp class="einst">
TBODY</samp></a> start tag is always required except when the table contains
only one table body and no table head or foot sections. The <a href= 
"tables.html#edef-TBODY" class="noxref"><samp class="einst">TBODY</samp></a>
end tag may always be safely omitted.</li>

<li>The start tags for <a href="tables.html#edef-THEAD" class="noxref"><samp
class="einst">THEAD</samp></a> and <a href="tables.html#edef-TFOOT" class= 
"noxref"><samp class="einst">TFOOT</samp></a> are required when the table head
and foot sections are present respectively, but the corresponding end tags may
always be safely omitted.</li>
</ul>

<p>Conforming user agent parsers must obey these rules for reasons of backward
compatibility.</p>

<div class="example">
<p>The table of the previous example could be shortened by removing certain end
tags, as in:</p>

<pre>
&lt;TABLE&gt;
&lt;THEAD&gt;
     &lt;TR&gt; <em>...header information...</em>
&lt;TFOOT&gt;
     &lt;TR&gt; <em>...footer information...</em>
&lt;TBODY&gt;
     &lt;TR&gt; <em>...first row of block one data...</em>
     &lt;TR&gt; <em>...second row of block one data...</em>
&lt;TBODY&gt;
     &lt;TR&gt; <em>...first row of block two data...</em>
     &lt;TR&gt; <em>...second row of block two data...</em>
     &lt;TR&gt; <em>...third row of block two data...</em>
&lt;/TABLE&gt;
</pre>
</div>

<p>The <a href="tables.html#edef-THEAD" class="noxref"><samp class="einst">
THEAD</samp></a>, <a href="tables.html#edef-TFOOT" class="noxref"><samp class= 
"einst">TFOOT</samp></a>, and <a href="tables.html#edef-TBODY" class="noxref">
<samp class="einst">TBODY</samp></a> sections must contain the same number of
columns.</p>

<h3><a name="h-11.2.4">11.2.4</a> <a name="colgroups">Column groups:</a> the <a
href="tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> and <a href="tables.html#edef-COL" class="noxref"><samp
class="einst">COL</samp></a> elements</h3>

<p><span class="index-inst" title="column group|table::column group in"><a
name="idx-column_group">Column groups</a></span> allow authors to create
structural divisions within a table. Authors may highlight this structure
through style sheets or HTML attributes (e.g., the <a href= 
"tables.html#adef-rules" class="noxref"><samp class="ainst-TABLE">
rules</samp></a> attribute for the <a href="tables.html#edef-TABLE" class= 
"noxref"><samp class="einst">TABLE</samp></a> element). For an example of the
visual presentation of column groups, please consult the <a href="#sample">
sample table</a>.</p>

<p>A table may either contain a single implicit column group (no <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element delimits the columns) or any number of explicit
column groups (each delimited by an instance of the <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element).</p>

<p>The <a href="tables.html#edef-COL" class="noxref"><samp class="einst">
COL</samp></a> element allows authors to share attributes among several columns
without implying any structural grouping. The "span" of the <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
element is the number of columns that will share the element's attributes.</p>

<h4>The <a name="edef-COLGROUP"><samp class="edef">COLGROUP</samp></a>
element<a name="h-11.2.4.1">&nbsp;</a></h4>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-COLGROUP" class="noxref"><samp class= 
"einst">COLGROUP</samp></a> - O (COL)*          -- table column group --&gt;
&lt;!ATTLIST COLGROUP
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  <a href="tables.html#adef-span-COLGROUP" class="noxref"><samp class= 
"ainst-COLGROUP">span</samp></a>        <a href=
"../types.html#type-number">NUMBER</a>         1         -- default number of columns in group --
  <a href="tables.html#adef-width-COLGROUP" class="noxref"><samp class= 
"ainst-COLGROUP">width</samp></a>       <a href=
"../sgml/dtd.html#MultiLength">%MultiLength;</a>  #IMPLIED  -- default width for enclosed COLs --
  <a href=
"../sgml/dtd.html#cellhalign">%cellhalign;</a>                         -- horizontal alignment in cells --
  <a href=
"../sgml/dtd.html#cellvalign">%cellvalign;</a>                         -- vertical alignment in cells --
  &gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
optional</strong></em></p>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-span-COLGROUP"><samp class="adef">span</samp></a> = <a href= 
"../types.html#type-number"><em>number</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute, which must be an integer &gt; 0, specifies the number of
columns in a column group. Values mean the following: 

<ul>
<li>In the absence of a <a href="tables.html#adef-span-COLGROUP" class=
"noxref"><samp class="ainst-COLGROUP">span</samp></a> attribute, each <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> defines a column group containing one column.</li>

<li>If the <a href="tables.html#adef-span-COLGROUP" class="noxref"><samp class= 
"ainst-COLGROUP">span</samp></a> attribute is set to N &gt; 0, the current <a
href="tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element defines a column group containing N columns.</li>
</ul>

<p>User agents must ignore this attribute if the <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element contains one or more <a href="tables.html#edef-COL"
class="noxref"><samp class="einst">COL</samp></a> elements.</p>
</dd>

<dt><a name="adef-width-COLGROUP"><samp class="adef">width</samp></a> = <a
href="../types.html#type-multi-length"><em>multi-length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>
<p>This attribute specifies a default width for each column in the current
column group. In addition to the standard pixel, percentage, and relative
values, this attribute allows the special form "0*" (zero asterisk) which means
that the width of the each column in the group should be the minimum width
necessary to hold the column's contents. This implies that a column's entire
contents must be known before its width may be correctly computed. Authors
should be aware that specifying "0*" will prevent visual user agents from
rendering a table incrementally.</p>

<p>This attribute is overridden for any column in the column group whose <a
href="tables.html#adef-width-COL" class="noxref"><samp class="ainst-COL">
width</samp></a> is specified via a <a href="tables.html#edef-COL" class=
"noxref"><samp class="einst">COL</samp></a> element.</p>
</dd>
</dl>
</div>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a> )</li>

<li><a href="tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a>, <a href="tables.html#adef-char" class="noxref"><samp class= 
"ainst">char</samp></a>, <a href="tables.html#adef-charoff" class="noxref">
<samp class="ainst">charoff</samp></a>, <a href="tables.html#adef-valign"
class="noxref"><samp class="ainst">valign</samp></a> (<a href="#alignment">cell
alignment</a>)</li>
</ul>
</div>

<p>The <a href="tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element creates an explicit column group. The number of
columns in the column group may be specified in two, mutually exclusive
ways:</p>

<ol>
<li>The element's <a href="tables.html#adef-span-COLGROUP" class="noxref"><samp
class="ainst-COLGROUP">span</samp></a> attribute (default value 1) specifies
the number of columns in the group.</li>

<li>Each <a href="tables.html#edef-COL" class="noxref"><samp class="einst">
COL</samp></a> element in the <a href="tables.html#edef-COLGROUP" class=
"noxref"><samp class="einst">COLGROUP</samp></a> represents one or more columns
in the group.</li>
</ol>

<p>The advantage of using the <a href="tables.html#adef-span-COLGROUP" class= 
"noxref"><samp class="ainst-COLGROUP">span</samp></a> attribute is that authors
may group together information about column widths. Thus, if a table contains
forty columns, all of which have a width of 20 pixels, it is easier to
write:</p>

<pre class="example">
   &lt;COLGROUP span="40" width="20"&gt;
   &lt;/COLGROUP&gt;
</pre>

<p>than:</p>

<pre class="example">
   &lt;COLGROUP&gt;
      &lt;COL width="20"&gt;
      &lt;COL width="20"&gt;
      <em>...a total of forty COL elements...</em>
   &lt;/COLGROUP&gt;
</pre>

<p>When it is necessary to single out a column (e.g., for style information, to
specify width information, etc.) within a group, authors must identify that
column with a <a href="tables.html#edef-COL" class="noxref"><samp class=
"einst">COL</samp></a> element. Thus, to apply special style information to the
last column of the previous table, we single it out as follows:</p>

<pre class="example">
   &lt;COLGROUP width="20"&gt;
      &lt;COL span="39"&gt;
      &lt;COL id="format-me-specially"&gt;
   &lt;/COLGROUP&gt;
</pre>

<p>The <a href="tables.html#adef-width-COLGROUP" class="noxref"><samp class= 
"ainst-COLGROUP">width</samp></a> attribute of the <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element is inherited by all 40 columns. The first <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
element refers to the first 39 columns (doing nothing special to them) and the
second one assigns an <a href="global.html#adef-id" class="noxref"><samp class= 
"ainst">id</samp></a> value to the fortieth column so that style sheets may
refer to it.</p>

<div class="example">
<p>The table in the following example contains two column groups. The first
column group contains 10 columns and the second contains 5 columns. The default
width for each column in the first column group is 50 pixels. The width of each
column in the second column group will be the minimum required for that
column.</p>

<pre>
&lt;TABLE&gt;
&lt;COLGROUP span="10" width="50"&gt;
&lt;COLGROUP span="5" width="0*"&gt;
&lt;THEAD&gt;
&lt;TR&gt;&lt;TD&gt; <em>...</em>
&lt;/TABLE&gt;
</pre>
</div>

<h4>The <a name="edef-COL"><samp class="edef">COL</samp></a> element<a name= 
"h-11.2.4.2">&nbsp;</a></h4>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-COL" class="noxref"><samp class=
"einst">COL</samp></a>      - O EMPTY           -- table column --&gt;
&lt;!ATTLIST COL                          -- column groups and properties --
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  <a href="tables.html#adef-span-COL" class="noxref"><samp class=
"ainst-COL">span</samp></a>        <a href=
"../types.html#type-number">NUMBER</a>         1         -- COL attributes affect N columns --
  <a href="tables.html#adef-width-COL" class="noxref"><samp class=
"ainst-COL">width</samp></a>       <a href=
"../sgml/dtd.html#MultiLength">%MultiLength;</a>  #IMPLIED  -- column width specification --
  <a href=
"../sgml/dtd.html#cellhalign">%cellhalign;</a>                         -- horizontal alignment in cells --
  <a href=
"../sgml/dtd.html#cellvalign">%cellvalign;</a>                         -- vertical alignment in cells --
  &gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
forbidden</strong></em></p>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-span-COL"><samp class="adef">span</samp></a> = <a href= 
"../types.html#type-number"><em>number</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute, whose value must be an integer &gt; 0, specifies the number
of columns "spanned" by the <a href="tables.html#edef-COL" class="noxref"><samp
class="einst">COL</samp></a> element; the <a href="tables.html#edef-COL" class= 
"noxref"><samp class="einst">COL</samp></a> element shares its attributes with
all the columns it spans. The default value for this attribute is 1 (i.e., the
<a href="tables.html#edef-COL" class="noxref"><samp class="einst">
COL</samp></a> element refers to a single column). If the <a href= 
"tables.html#adef-span-COL" class="noxref"><samp class="ainst-COL">
span</samp></a> attribute is set to N &gt; 1, the current <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
element shares its attributes with the next N-1 columns.</dd>

<dt><a name="adef-width-COL"><samp class="adef">width</samp></a> = <a href= 
"../types.html#type-multi-length"><em>multi-length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies a default width for each column spanned by the
current <a href="tables.html#edef-COL" class="noxref"><samp class="einst">
COL</samp></a> element. It has the same meaning as the <a href= 
"tables.html#adef-width-COLGROUP" class="noxref"><samp class="ainst-COLGROUP">
width</samp></a> attribute for the <a href="tables.html#edef-COLGROUP" class= 
"noxref"><samp class="einst">COLGROUP</samp></a> element and overrides it.</dd>
</dl>
</div>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a> )</li>

<li><a href="tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a>, <a href="tables.html#adef-char" class="noxref"><samp class= 
"ainst">char</samp></a>, <a href="tables.html#adef-charoff" class="noxref">
<samp class="ainst">charoff</samp></a>, <a href="tables.html#adef-valign"
class="noxref"><samp class="ainst">valign</samp></a> (<a href="#alignment">cell
alignment</a>)</li>
</ul>
</div>

<p>The <a href="tables.html#edef-COL" class="noxref"><samp class="einst">
COL</samp></a> element allows authors to group together attribute
specifications for table columns. The <a href="tables.html#edef-COL" class= 
"noxref"><samp class="einst">COL</samp></a> does <strong>not</strong> group
columns together structurally -- that is the role of the <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element. <a href="tables.html#edef-COL" class="noxref">
<samp class="einst">COL</samp></a> elements are empty and serve only as a
support for attributes. They may appear inside or outside an explicit column
group (i.e., <a href="tables.html#edef-COLGROUP" class="noxref"><samp class= 
"einst">COLGROUP</samp></a> element).</p>

<p>The <a href="tables.html#adef-width-COL" class="noxref"><samp class= 
"ainst-COL">width</samp></a> attribute for <a href="tables.html#edef-COL"
class="noxref"><samp class="einst">COL</samp></a> refers to the width of each
column in the element's span.</p>

<h4><span class="index-inst" title="column::number of in a table|table::number 
of columns"><a name="column-calc">Calculating the number of columns in a
table</a></span><a name="h-11.2.4.3">&nbsp;</a></h4>

<p>There are two ways to determine the number of columns in a table (in order
of precedence):</p>

<ol>
<li>If the <a href="tables.html#edef-TABLE" class="noxref"><samp class="einst">
TABLE</samp></a> element contains any <a href="tables.html#edef-COLGROUP"
class="noxref"><samp class="einst">COLGROUP</samp></a> or <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
elements, user agents should calculate the number of columns by summing the
following: 

<ul>
<li>For each <a href="tables.html#edef-COL" class="noxref"><samp class="einst">
COL</samp></a> element, take the value of its <a href=
"tables.html#adef-span-COL" class="noxref"><samp class="ainst-COL">
span</samp></a> attribute (default value 1).</li>

<li>For each <a href="tables.html#edef-COLGROUP" class="noxref"><samp class= 
"einst">COLGROUP</samp></a> element containing at least one <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
element, ignore the <a href="tables.html#adef-span-COLGROUP" class="noxref">
<samp class="ainst-COLGROUP">span</samp></a> attribute for the <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> element. For each <a href="tables.html#edef-COL" class= 
"noxref"><samp class="einst">COL</samp></a> element, perform the calculation of
step 1.</li>

<li>For each empty <a href="tables.html#edef-COLGROUP" class="noxref"><samp
class="einst">COLGROUP</samp></a> element, take the value of its <a href= 
"tables.html#adef-span-COLGROUP" class="noxref"><samp class="ainst-COLGROUP">
span</samp></a> attribute (default value 1).</li>
</ul>
</li>

<li>Otherwise, if the <a href="tables.html#edef-TABLE" class="noxref"><samp
class="einst">TABLE</samp></a> element contains no <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> or <a href="tables.html#edef-COL" class="noxref"><samp
class="einst">COL</samp></a> elements, user agents should base the number of
columns on what is required by the rows. The number of columns is equal to the
number of columns required by the row with the most columns, including cells
that span multiple columns. For any row that has fewer than this number of
columns, the end of that row should be padded with empty cells. The "end" of a
row depends on the <a href="#table-directionality">table
directionality</a>.</li>
</ol>

<p>It is an error if a table contains <a href="tables.html#edef-COLGROUP"
class="noxref"><samp class="einst">COLGROUP</samp></a> or <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
elements and the two calculations do not result in the same number of
columns.</p>

<p>Once the user agent has calculated the number of columns in the table, it
may group them into <a href="#colgroups">column groups.</a></p>

<div class="example">
<p>For example, for each of the following tables, the two column calculation
methods should result in three columns. The first three tables may be rendered
incrementally.</p>

<pre>
&lt;TABLE&gt;
&lt;COLGROUP span="3"&gt;&lt;/COLGROUP&gt;
&lt;TR&gt;&lt;TD&gt; <em>...</em>
<em>...rows...</em>
&lt;/TABLE&gt;

&lt;TABLE&gt;
&lt;COLGROUP&gt;
&lt;COL&gt;
&lt;COL span="2"&gt;
&lt;/COLGROUP&gt;
&lt;TR&gt;&lt;TD&gt; <em>...</em>
<em>...rows...</em>
&lt;/TABLE&gt;

&lt;TABLE&gt;
&lt;COLGROUP&gt;
&lt;COL&gt;
&lt;/COLGROUP&gt;
&lt;COLGROUP span="2"&gt;
&lt;TR&gt;&lt;TD&gt; <em>...</em>
<em>...rows...</em>
&lt;/TABLE&gt;

&lt;TABLE&gt;
&lt;TR&gt;
  &lt;TD&gt;&lt;TD&gt;&lt;TD&gt;
&lt;/TR&gt;
&lt;/TABLE&gt;
</pre>
</div>

<h4><span class="index-inst" title="column::width of in a table|table::width of 
columns"><a name="column-width">Calculating the width of columns</a></span><a
name="h-11.2.4.4">&nbsp;</a></h4>

<p>Authors may specify column widths in three ways:</p>

<dl>
<dt><strong>Fixed</strong></dt>

<dd>A fixed width specification is given in pixels (e.g., <samp class="ainst">
width</samp>="30"). A fixed-width specification enables incremental
rendering.</dd>

<dt><strong>Percentage</strong></dt>

<dd>A percentage specification (e.g., <samp class="ainst">width</samp>="20%")
is based on the percentage of the horizontal space available to the table
(between the current left and right margins, including floats). Note that this
space does not depend on the table itself, and thus percentage specifications
enable incremental rendering.</dd>

<dt><strong>Proportional</strong></dt>

<dd>Proportional specifications (e.g., <samp class="ainst">width</samp>="3*")
refer to portions of the horizontal space <em>required</em> by a table. If the
table width is given a fixed value via the <samp class="ainst">width</samp>
attribute of the <a href="tables.html#edef-TABLE" class="noxref"><samp class= 
"einst">TABLE</samp></a> element, user agents may render the table
incrementally even with proportional columns. 

<p>However, if the table does not have a fixed width, user agents must receive
all table data before they can determine the horizontal space required by the
table. Only then may this space be allotted to proportional columns.</p>
</dd>
</dl>

<p>If an author specifies no width information for a column, a user agent may
not be able to incrementally format the table since it must wait for the entire
column of data to arrive in order to allot an appropriate width.</p>

<p>If column widths prove to be too narrow for the contents of a particular
table cell, user agents may choose to reflow the table.</p>

<div class="example">
<p>The table in this example contains six columns. The first one does not
belong to an explicit column group. The next three belong to the first explicit
column group and the last two belong to the second explicit column group. This
table cannot be formatted incrementally since it contains proportional column
width specifications and no value for the <a href=
"tables.html#adef-width-TABLE" class="noxref"><samp class="ainst-TABLE">
width</samp></a> attribute for the <a href="tables.html#edef-TABLE" class= 
"noxref"><samp class="einst">TABLE</samp></a> element.</p>

<p>Once the (visual) user agent has received the table's data: the available
horizontal space will be alloted by the user agent as follows: First the user
agent will allot 30 pixels to columns one and two. Then, the minimal space
required for the third column will be reserved. The remaining horizontal space
will be divided into six equal portions (since 2* + 1* + 3* = 6 portions).
Column four (2*) will receive two of these portions, column five (1*) will
receive one, and column six (3*) will receive three.</p>

<pre>
    
&lt;TABLE&gt;
&lt;COLGROUP&gt;
   &lt;COL width="30"&gt;
&lt;COLGROUP&gt;
   &lt;COL width="30"&gt;
   &lt;COL width="0*"&gt;
   &lt;COL width="2*"&gt;
&lt;COLGROUP align="center"&gt;
   &lt;COL width="1*"&gt;
   &lt;COL width="3*" align="char" char=":"&gt;
&lt;THEAD&gt;
&lt;TR&gt;&lt;TD&gt; <em>...</em>
<em>...rows...</em>
&lt;/TABLE&gt;
</pre>

<p>We have set the value of the <a href="tables.html#adef-align-TD" class= 
"noxref"><samp class="ainst-TD">align</samp></a> attribute in the third column
group to "center". All cells in every column in this group will inherit this
value, but may override it. In fact, the final <a href="tables.html#edef-COL"
class="noxref"><samp class="einst">COL</samp></a> does just that, by specifying
that every cell in the column it governs will be aligned along the ":"
character.</p>
</div>

<div class="example">
<p>In the following table, the column width specifications allow the user agent
to format the table incrementally:</p>

<pre>
    
&lt;TABLE width="200"&gt;
&lt;COLGROUP span="10" width="15"&gt;
&lt;COLGROUP width="*"&gt;
   &lt;COL id="penultimate-column"&gt;
   &lt;COL id="last-column"&gt;
&lt;THEAD&gt;
&lt;TR&gt;&lt;TD&gt; <em>...</em>
<em>...rows...</em>
&lt;/TABLE&gt;
</pre>

<p>The first ten columns will be 15 pixels wide each. The last two columns will
each receive half of the remaining 50 pixels. Note that the <a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a>
elements appear only so that an <a href="global.html#adef-id" class="noxref">
<samp class="ainst">id</samp></a> value may be specified for the last two
columns.</p>
</div>

<div class="example">
<p><em><strong>Note.</strong> Although the <a href=
"tables.html#adef-width-TABLE" class="noxref"><samp class="ainst-TABLE">
width</samp></a> attribute on the <a href="tables.html#edef-TABLE" class=
"noxref"><samp class="einst">TABLE</samp></a> element is not deprecated,
authors are encouraged to use style sheets to specify table widths.</em></p>
</div>

<h3><a name="h-11.2.5">11.2.5</a> <a name="rows">Table rows:</a> The <a name= 
"edef-TR"><samp class="edef">TR</samp></a> element</h3>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT <a href="tables.html#edef-TR" class="noxref"><samp class=
"einst">TR</samp></a>       - O (TH|TD)+        -- table row --&gt;
&lt;!ATTLIST TR                           -- table row --
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  <a href=
"../sgml/dtd.html#cellhalign">%cellhalign;</a>                         -- horizontal alignment in cells --
  <a href=
"../sgml/dtd.html#cellvalign">%cellvalign;</a>                         -- vertical alignment in cells --
  &gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
optional</strong></em></p>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a> )</li>

<li><a href="../present/graphics.html#adef-bgcolor" class="noxref"><samp class= 
"ainst">bgcolor</samp></a> (<a href=
"../present/graphics.html#background-color">background color</a>)</li>

<li><a href="tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a>, <a href="tables.html#adef-char" class="noxref"><samp class= 
"ainst">char</samp></a>, <a href="tables.html#adef-charoff" class="noxref">
<samp class="ainst">charoff</samp></a>, <a href="tables.html#adef-valign"
class="noxref"><samp class="ainst">valign</samp></a> (<a href="#alignment">cell
alignment</a>)</li>
</ul>
</div>

<p>The <a href="tables.html#edef-TR" class="noxref"><samp class="einst">
TR</samp></a> elements acts as a container for a row of table cells. The end
tag may be omitted.</p>

<div class="example">
<p>This sample table contains three rows, each begun by the <a href= 
"tables.html#edef-TR" class="noxref"><samp class="einst">TR</samp></a>
element:</p>

<pre>
&lt;TABLE summary="This table charts the number of cups
                   of coffee consumed by each senator, the type 
                   of coffee (decaf or regular), and whether 
                   taken with sugar."&gt;
&lt;CAPTION&gt;Cups of coffee consumed by each senator&lt;/CAPTION&gt;
&lt;TR&gt; <em>...A header row...</em>
&lt;TR&gt; <em>...First row of data...</em>
&lt;TR&gt; <em>...Second row of data...</em>
<em>...the rest of the table...</em>
&lt;/TABLE&gt;
</pre>
</div>

<h3><a name="h-11.2.6">11.2.6</a> <a name="cells">Table cells:</a> The <a name= 
"edef-TH"><samp class="edef">TH</samp></a> and <a name="edef-TD"><samp class= 
"edef">TD</samp></a> elements</h3>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!ELEMENT (<a href="tables.html#edef-TH" class="noxref"><samp class=
"einst">TH</samp></a>|<a href="tables.html#edef-TD" class="noxref"><samp class= 
"einst">TD</samp></a>)  - O (<a href=
"../sgml/dtd.html#flow">%flow;</a>)*       -- table header cell, table data cell--&gt;

&lt;!-- Scope is simpler than headers attribute for common tables --&gt;
&lt;!ENTITY % Scope "(row|col|rowgroup|colgroup)"&gt;

&lt;!-- TH is for headers, TD for data, but for cells acting as both use TD --&gt;
&lt;!ATTLIST (TH|TD)                      -- header or data cell --
  <a href=
"../sgml/dtd.html#attrs">%attrs;</a>                              -- <a href= 
"../sgml/dtd.html#coreattrs">%coreattrs</a>, <a href=
"../sgml/dtd.html#i18n">%i18n</a>, <a href=
"../sgml/dtd.html#events">%events</a> --
  <a href="tables.html#adef-abbr" class="noxref"><samp class=
"ainst-TH">abbr</samp></a>        <a href=
"../sgml/dtd.html#Text">%Text;</a>         #IMPLIED  -- abbreviation for header cell --
  <a href="tables.html#adef-axis" class="noxref"><samp class=
"ainst-TH">axis</samp></a>        <a href=
"../types.html#type-cdata">CDATA</a>          #IMPLIED  -- comma-separated list of related headers--
  <a href="tables.html#adef-headers" class="noxref"><samp class=
"ainst-TH">headers</samp></a>     <a href=
"../types.html#type-idrefs">IDREFS</a>         #IMPLIED  -- list of id's for header cells --
  <a href="tables.html#adef-scope" class="noxref"><samp class=
"ainst-TH">scope</samp></a>       <a href=
"../sgml/dtd.html#Scope">%Scope;</a>        #IMPLIED  -- scope covered by header cells --
  <a href="tables.html#adef-rowspan" class="noxref"><samp class=
"ainst-TH">rowspan</samp></a>     <a href=
"../types.html#type-number">NUMBER</a>         1         -- number of rows spanned by cell --
  <a href="tables.html#adef-colspan" class="noxref"><samp class=
"ainst-TH">colspan</samp></a>     <a href=
"../types.html#type-number">NUMBER</a>         1         -- number of cols spanned by cell --
  <a href=
"../sgml/dtd.html#cellhalign">%cellhalign;</a>                         -- horizontal alignment in cells --
  <a href=
"../sgml/dtd.html#cellvalign">%cellvalign;</a>                         -- vertical alignment in cells --
  &gt;
</pre>
</div>

<p><em>Start tag: <strong>required</strong>, End tag: <strong>
optional</strong></em></p>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-headers"><samp class="adef">headers</samp></a> = <a href= 
"../types.html#type-idrefs"><em>idrefs</em></a> <a href= 
"../types.html#case-sensitive">[CS]</a></dt>

<dd>This attribute specifies the list of header cells that provide header
information for the current data cell. The value of this attribute is a
space-separated list of cell names; those cells must be named by setting their
<a href="global.html#adef-id" class="noxref"><samp class="ainst">id</samp></a>
attribute. Authors generally use the <a href="tables.html#adef-headers" class= 
"noxref"><samp class="ainst">headers</samp></a> attribute to help non-visual
user agents render header information about data cells (e.g., header
information is spoken prior to the cell data), but the attribute may also be
used in conjunction with style sheets. See also the <a href= 
"tables.html#adef-scope" class="noxref"><samp class="ainst">scope</samp></a>
attribute.</dd>

<dt><a name="adef-scope"><samp class="adef">scope</samp></a> = <em>
scope-name</em> <a href="../types.html#case-insensitive">[CI]</a></dt>

<dd>This attribute specifies the set of data cells for which the current header
cell provides header information. This attribute may be used in place of the <a
href="tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> attribute, particularly for simple tables. When specified,
this attribute must have one of the following values: 

<ul>
<li><strong>row:</strong> The current cell provides header information for the
rest of the row that contains it (see also the section on <a href= 
"#table-directionality">table directionality</a>).</li>

<li><strong>col:</strong> The current cell provides header information for the
rest of the column that contains it.</li>

<li><strong>rowgroup:</strong> The header cell provides header information for
the rest of the <a href="#rowgroups">row group</a> that contains it.</li>

<li><strong>colgroup:</strong> The header cell provides header information for
the rest of the <a href="#colgroups">column group</a> that contains it.</li>
</ul>
</dd>

<dt><a name="adef-abbr"><samp class="adef">abbr</samp></a> = <a href= 
"../types.html#type-text"><em>text</em></a> <a href= 
"../types.html#case-sensitive">[CS]</a></dt>

<dd>This attribute should be used to provide an abbreviated form of the cell's
content, and may be rendered by user agents when appropriate in place of the
cell's content. Abbreviated names should be short since user agents may render
them repeatedly. For instance, speech synthesizers may render the abbreviated
headers relating to a particular cell before rendering that cell's
content.</dd>

<dt><a name="adef-axis"><samp class="adef">axis</samp></a> = <a href= 
"../types.html#type-cdata"><em>cdata</em></a> <a href= 
"../types.html#case-insensitive">[CI]</a></dt>

<dd>This attribute may be used to place a cell into conceptual categories that
can be considered to form axes in an n-dimensional space. User agents may give
users access to these categories (e.g., the user may query the user agent for
all cells that belong to certain categories, the user agent may present a table
in the form of a table of contents, etc.). Please consult the section on <a
href="#multi-dimension">categorizing cells</a> for more information. The value
of this attribute is a comma-separated list of category names.</dd>

<dt><a name="adef-rowspan"><samp class="adef">rowspan</samp></a> = <a href= 
"../types.html#type-number"><em>number</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies the number of rows spanned by the current cell.
The default value of this attribute is one ("1"). The value zero ("0") means
that the cell spans all rows from the current row to the last row of the table
section (<a href="tables.html#edef-THEAD" class="noxref"><samp class=
"einst">THEAD</samp></a>, <a href="tables.html#edef-TBODY" class="noxref"><samp
class="einst">TBODY</samp></a>, or <a href="tables.html#edef-TFOOT" class= 
"noxref"><samp class="einst">TFOOT</samp></a>) in which the cell is
defined.</dd>

<dt><a name="adef-colspan"><samp class="adef">colspan</samp></a> = <a href= 
"../types.html#type-number"><em>number</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies the number of columns spanned by the current cell.
The default value of this attribute is one ("1"). The value zero ("0") means
that the cell spans all columns from the current column to the last column of
the column group (<a href="tables.html#edef-COLGROUP" class="noxref"><samp
class="einst">COLGROUP</samp></a>) in which the cell is defined.</dd>

<dt><a name="adef-nowrap"><samp class="adef">nowrap</samp></a> <a href= 
"../types.html#case-insensitive">[CI]</a></dt>

<dd><a href="../conform.html#deprecated"><strong>Deprecated.</strong></a> When
present, this boolean attribute tells visual user agents to disable automatic
text wrapping for this cell. <a href="../present/styles.html">Style sheets</a>
should be used instead of this attribute to achieve wrapping effects. <strong>
Note.</strong> if used carelessly, this attribute may result in excessively
wide cells.</dd>

<dt><a name="adef-width-TH"><samp class="adef">width</samp></a> = <a href= 
"../types.html#type-length"><em>length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd><a href="../conform.html#deprecated"><strong>Deprecated.</strong></a> This
attribute supplies user agents with a recommended cell width.</dd>

<dt><a name="adef-height-TH"><samp class="adef">height</samp></a> = <a href= 
"../types.html#type-length"><em>length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd><a href="../conform.html#deprecated"><strong>Deprecated.</strong></a> This
attribute supplies user agents with a recommended cell height.</dd>
</dl>
</div>

<div class="aref-list">
<p><em>Attributes defined elsewhere</em></p>

<ul>
<li><a href="global.html#adef-id" class="noxref"><samp class="ainst">
id</samp></a>, <a href="global.html#adef-class" class="noxref"><samp class= 
"ainst">class</samp></a> (<a href=
"../struct/global.html#id-and-class">document-wide identifiers</a>)</li>

<li><a href="dirlang.html#adef-lang" class="noxref"><samp class="ainst">
lang</samp></a> (<a href="../struct/dirlang.html#language-info">language
information</a>), <a href="dirlang.html#adef-dir" class="noxref"><samp class= 
"ainst">dir</samp></a> (<a href="../struct/dirlang.html#bidirection">text
direction</a>)</li>

<li><a href="global.html#adef-title" class="noxref"><samp class="ainst">
title</samp></a> (<a href="../struct/global.html#title">element title</a>)</li>

<li><a href="../present/styles.html#adef-style" class="noxref"><samp class= 
"ainst">style</samp></a> (<a href="../present/styles.html#style-element">inline
style information</a> )</li>

<li><a href="../interact/scripts.html#adef-onclick" class="noxref"><samp class= 
"ainst">onclick</samp></a>, <a href="../interact/scripts.html#adef-ondblclick"
class="noxref"><samp class="ainst">ondblclick</samp></a>, <a href= 
"../interact/scripts.html#adef-onmousedown" class="noxref"><samp class="ainst">
onmousedown</samp></a>, <a href="../interact/scripts.html#adef-onmouseup"
class="noxref"><samp class="ainst">onmouseup</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseover" class="noxref"><samp class="ainst">
onmouseover</samp></a>, <a href="../interact/scripts.html#adef-onmousemove"
class="noxref"><samp class="ainst">onmousemove</samp></a>, <a href= 
"../interact/scripts.html#adef-onmouseout" class="noxref"><samp class="ainst">
onmouseout</samp></a>, <a href="../interact/scripts.html#adef-onkeypress"
class="noxref"><samp class="ainst">onkeypress</samp></a>, <a href= 
"../interact/scripts.html#adef-onkeydown" class="noxref"><samp class="ainst">
onkeydown</samp></a>, <a href="../interact/scripts.html#adef-onkeyup" class= 
"noxref"><samp class="ainst">onkeyup</samp></a> (<a href= 
"../interact/scripts.html#events">intrinsic events</a> )</li>

<li><a href="../present/graphics.html#adef-bgcolor" class="noxref"><samp class= 
"ainst">bgcolor</samp></a> (<a href=
"../present/graphics.html#background-color">background color</a>)</li>

<li><a href="tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a>, <a href="tables.html#adef-char" class="noxref"><samp class= 
"ainst">char</samp></a>, <a href="tables.html#adef-charoff" class="noxref">
<samp class="ainst">charoff</samp></a>, <a href="tables.html#adef-valign"
class="noxref"><samp class="ainst">valign</samp></a> (<a href="#alignment">cell
alignment</a>)</li>
</ul>
</div>

<p>Table cells may contain two types of information: <span class="index-inst"
title="table::header cells|header cell::in table"><a name="idx-table-9">header
information</a></span> and <span class="index-inst" title="table::data 
cells|data cell::in table"><a name="idx-table-10">data.</a></span> This
distinction enables user agents to render header and data cells distinctly,
even in the absence of style sheets. For example, visual user agents may
present header cell text with a bold font. Speech synthesizers may render
header information with a distinct voice inflection.</p>

<p>The <a href="tables.html#edef-TH" class="noxref"><samp class="einst">
TH</samp></a> element defines a cell that contains header information. User
agents have two pieces of header information available: the contents of the <a
href="tables.html#edef-TH" class="noxref"><samp class="einst">TH</samp></a>
element and the value of the <a href="tables.html#adef-abbr" class="noxref">
<samp class="ainst">abbr</samp></a> attribute. User agents must render either
the contents of the cell or the value of the <a href="tables.html#adef-abbr"
class="noxref"><samp class="ainst">abbr</samp></a> attribute. For visual media,
the latter may be appropriate when there is insufficient space to render the
full contents of the cell. For non-visual media <a href="tables.html#adef-abbr"
class="noxref"><samp class="ainst">abbr</samp></a> may be used as an
abbreviation for table headers when these are rendered along with the contents
of the cells to which they apply.</p>

<p>The <a href="tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> and <a href="tables.html#adef-scope" class="noxref"><samp
class="ainst">scope</samp></a> attributes also allow authors to help non-visual
user agents process header information. Please consult the section on <a href= 
"#non-visual-rendering">labeling cells for non-visual user agents</a> for
information and examples.</p>

<p>The <a href="tables.html#edef-TD" class="noxref"><samp class="einst">
TD</samp></a> element defines a cell that contains data.</p>

<p>Cells may be empty (i.e., contain no data).</p>

<div class="example">
<p>For example, the following table contains four columns of data, each headed
by a column description.</p>

<pre>
&lt;TABLE summary="This table charts the number of cups
                   of coffee consumed by each senator, the type 
                   of coffee (decaf or regular), and whether 
                   taken with sugar."&gt;
&lt;CAPTION&gt;Cups of coffee consumed by each senator&lt;/CAPTION&gt;
&lt;TR&gt;
   &lt;TH&gt;Name&lt;/TH&gt;
   &lt;TH&gt;Cups&lt;/TH&gt;
   &lt;TH&gt;Type of Coffee&lt;/TH&gt;
   &lt;TH&gt;Sugar?&lt;/TH&gt;
&lt;TR&gt;
   &lt;TD&gt;T. Sexton&lt;/TD&gt;
   &lt;TD&gt;10&lt;/TD&gt;
   &lt;TD&gt;Espresso&lt;/TD&gt;
   &lt;TD&gt;No&lt;/TD&gt;
&lt;TR&gt;
   &lt;TD&gt;J. Dinnen&lt;/TD&gt;
   &lt;TD&gt;5&lt;/TD&gt;
   &lt;TD&gt;Decaf&lt;/TD&gt;
   &lt;TD&gt;Yes&lt;/TD&gt;
&lt;/TABLE&gt;
</pre>

<p>A user agent rendering to a tty device might display this as follows:</p>

<pre>
<strong>Name         Cups       Type of Coffee   Sugar?</strong>
T. Sexton    10         Espresso         No
J. Dinnen    5          Decaf            Yes
</pre>
</div>

<h4><span class="index-inst" title="table::cells that span several
rows/columns"><a name="idx-table-11">Cells that span several rows or
columns</a></span><a name="h-11.2.6.1">&nbsp;</a></h4>

<p>Cells may span several rows or columns. The number of rows or columns
spanned by a cell is set by the <a href="tables.html#adef-rowspan" class=
"noxref"><samp class="ainst">rowspan</samp></a> and <a href= 
"tables.html#adef-colspan" class="noxref"><samp class="ainst">
colspan</samp></a> attributes for the <a href="tables.html#edef-TH" class= 
"noxref"><samp class="einst">TH</samp></a> and <a href="tables.html#edef-TD"
class="noxref"><samp class="einst">TD</samp></a> elements.</p>

<div class="example">
<p>In this table definition, we specify that the cell in row four, column two
should span a total of three columns, including the current column.</p>

<pre>
&lt;TABLE border="1"&gt;
&lt;CAPTION&gt;Cups of coffee consumed by each senator&lt;/CAPTION&gt;
&lt;TR&gt;&lt;TH&gt;Name&lt;TH&gt;Cups&lt;TH&gt;Type of Coffee&lt;TH&gt;Sugar?
&lt;TR&gt;&lt;TD&gt;T. Sexton&lt;TD&gt;10&lt;TD&gt;Espresso&lt;TD&gt;No
&lt;TR&gt;&lt;TD&gt;J. Dinnen&lt;TD&gt;5&lt;TD&gt;Decaf&lt;TD&gt;Yes
&lt;TR&gt;&lt;TD&gt;A. Soria&lt;TD colspan="3"&gt;&lt;em&gt;Not available&lt;/em&gt;
&lt;/TABLE&gt;
</pre>

<p>This table might be rendered on a tty device by a visual user agent as
follows:</p>

<pre>
Cups of coffee consumed by each senator
 --------------------------------------
 |   Name  |Cups|Type of Coffee|Sugar?|
 --------------------------------------
 |T. Sexton|10  |Espresso      |No    |
 --------------------------------------
 |J. Dinnen|5   |Decaf         |Yes   |
 --------------------------------------
 |A. Soria |Not available             |
 --------------------------------------
</pre>
</div>

<div class="example">
<p>The next example illustrates (with the help of table borders) how cell
definitions that span more than one row or column affect the definition of
later cells. Consider the following table definition:</p>

<pre>
&lt;TABLE border="1"&gt;
&lt;TR&gt;&lt;TD&gt;1 &lt;TD rowspan="2"&gt;2 &lt;TD&gt;3
&lt;TR&gt;&lt;TD&gt;4 &lt;TD&gt;6
&lt;TR&gt;&lt;TD&gt;7 &lt;TD&gt;8 &lt;TD&gt;9
&lt;/TABLE&gt;
</pre>

<p>As cell "2" spans the first and second rows, the definition of the second
row will take it into account. Thus, the second <a href="tables.html#edef-TD"
class="noxref"><samp class="einst">TD</samp></a> in row two actually defines
the row's third cell. Visually, the table might be rendered to a tty device
as:</p>

<pre>
-------------
| 1 | 2 | 3 | 
----|   |----
| 4 |   | 6 |
----|---|----
| 7 | 8 | 9 |
-------------
</pre>

<p>while a graphical user agent might render this as:</p>

<p><img src="../images/rowspan.gif" alt="Image of a table with rowspan=2"></p>

<p>Note that if the <a href="tables.html#edef-TD" class="noxref"><samp class= 
"einst">TD</samp></a> defining cell "6" had been omitted, an extra empty cell
would have been added by the user agent to complete the row.</p>

<p>Similarly, in the following table definition:</p>

<pre>
&lt;TABLE border="1"&gt;
&lt;TR&gt;&lt;TD&gt;1 &lt;TD&gt;2 &lt;TD&gt;3
&lt;TR&gt;&lt;TD colspan="2"&gt;4 &lt;TD&gt;6
&lt;TR&gt;&lt;TD&gt;7 &lt;TD&gt;8 &lt;TD&gt;9
&lt;/TABLE&gt;
</pre>

<p>cell "4" spans two columns, so the second <a href="tables.html#edef-TD"
class="noxref"><samp class="einst">TD</samp></a> in the row actually defines
the third cell ("6"):</p>

<pre>
-------------
| 1 | 2 | 3 | 
--------|----
| 4     | 6 |
--------|----
| 7 | 8 | 9 |
-------------
</pre>

<p>A graphical user agent might render this as:</p>

<p><img src="../images/colspan.gif" alt="Image of a table with colspan=2"></p>
</div>

<p>Defining overlapping cells is an error. User agents may vary in how they
handle this error (e.g., rendering may vary).</p>

<div class="illegal-example">
<p>The following illegal example illustrates how one might create overlapping
cells. In this table, cell "5" spans two rows and cell "7" spans two columns,
so there is overlap in the cell between "7" and "9":</p>

<pre>
&lt;TABLE border="1"&gt;
&lt;TR&gt;&lt;TD&gt;1 &lt;TD&gt;2 &lt;TD&gt;3
&lt;TR&gt;&lt;TD&gt;4 &lt;TD rowspan="2"&gt;5 &lt;TD&gt;6
&lt;TR&gt;&lt;TD colspan="2"&gt;7 &lt;TD&gt;9
&lt;/TABLE&gt;
</pre>
</div>

<h2><a name="h-11.3">11.3</a> <span class="index-inst" title="table::visual 
rendering of"><a name="visual-formatting">Table formatting by visual user
agents</a></span></h2>

<div class="note">
<p><em><strong>Note.</strong> The following sections describe the HTML table
attributes that concern visual formatting. When this specification was first
published in 1997, <a rel="biblioentry" href="../references.html#ref-CSS1"
class="informref">[CSS1]</a> did not offer mechanisms to control all aspects of
visual table formatting. Since then, <a rel="biblioentry" href= 
"../references.html#ref-CSS2" class="informref">[CSS2]</a> has added properties
to allow visual formatting of tables.</em></p>
</div>

<p>HTML 4 includes mechanisms to control:</p>

<ul>
<li><a href="#borders">border styles</a></li>

<li><a href="#alignment">horizontal and vertical alignment</a> of cell
contents</li>

<li>and <a href="#margins">cell margins</a></li>
</ul>

<h3><a name="h-11.3.1">11.3.1</a> <span class="index-inst" title= 
"table::borders and rules of|border::around a table|rule::between table cells">
<a name="borders">Borders and rules</a></span></h3>

<p>The following attributes affect a table's external frame and internal
rules.</p>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-frame"><samp class="adef">frame</samp></a> = <samp>
void|above|below|hsides|lhs|rhs|vsides|box|border</samp> <a href= 
"../types.html#case-insensitive">[CI]</a></dt>

<dd>This attribute specifies which sides of the frame surrounding a table will
be visible. Possible values: 

<ul>
<li><samp>void:</samp> No sides. This is the default value.</li>

<li><samp>above:</samp> The top side only.</li>

<li><samp>below:</samp> The bottom side only.</li>

<li><samp>hsides:</samp> The top and bottom sides only.</li>

<li><samp>vsides:</samp> The right and left sides only.</li>

<li><samp>lhs:</samp> The left-hand side only.</li>

<li><samp>rhs:</samp> The right-hand side only.</li>

<li><samp>box:</samp> All four sides.</li>

<li><samp>border:</samp> All four sides.</li>
</ul>
</dd>

<dt><a name="adef-rules"><samp class="adef">rules</samp></a> = <samp>
none|groups|rows|cols|all</samp> <a href="../types.html#case-insensitive">
[CI]</a></dt>

<dd>This attribute specifies which rules will appear between cells within a
table. The rendering of rules is user agent dependent. Possible values: 

<ul>
<li><samp>none:</samp> No rules. This is the default value.</li>

<li><samp>groups:</samp> Rules will appear between row groups (see <a href= 
"tables.html#edef-THEAD" class="noxref"><samp class="einst">THEAD</samp></a>,
<a href="tables.html#edef-TFOOT" class="noxref"><samp class="einst">
TFOOT</samp></a>, and <a href="tables.html#edef-TBODY" class="noxref"><samp
class="einst">TBODY</samp></a>) and column groups (see <a href= 
"tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a> and <a href="tables.html#edef-COL" class="noxref"><samp
class="einst">COL</samp></a>) only.</li>

<li><samp>rows:</samp> Rules will appear between rows only.</li>

<li><samp>cols:</samp> Rules will appear between columns only.</li>

<li><samp>all:</samp> Rules will appear between all rows and columns.</li>
</ul>
</dd>

<dt><a name="adef-border-TABLE"><samp class="adef">border</samp></a> = <a href= 
"../types.html#type-pixels"><em>pixels</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attributes specifies the width (in pixels only) of the frame around a
table (see the Note below for more information about this attribute).</dd>
</dl>
</div>

<div class="example">
<p>To help distinguish the cells of a table, we can set the <a href= 
"tables.html#adef-border-TABLE" class="noxref"><samp class="ainst-TABLE">
border</samp></a> attribute of the <a href="tables.html#edef-TABLE" class= 
"noxref"><samp class="einst">TABLE</samp></a> element. Consider a previous
example:</p>

<pre>
&lt;TABLE border="1" 
       summary="This table charts the number of cups
                of coffee consumed by each senator, the type 
                of coffee (decaf or regular), and whether 
                taken with sugar."&gt;
&lt;CAPTION&gt;Cups of coffee consumed by each senator&lt;/CAPTION&gt;
&lt;TR&gt;
   &lt;TH&gt;Name&lt;/TH&gt;
   &lt;TH&gt;Cups&lt;/TH&gt;
   &lt;TH&gt;Type of Coffee&lt;/TH&gt;
   &lt;TH&gt;Sugar?&lt;/TH&gt;
&lt;TR&gt;
   &lt;TD&gt;T. Sexton&lt;/TD&gt;
   &lt;TD&gt;10&lt;/TD&gt;
   &lt;TD&gt;Espresso&lt;/TD&gt;
   &lt;TD&gt;No&lt;/TD&gt;
&lt;TR&gt;
   &lt;TD&gt;J. Dinnen&lt;/TD&gt;
   &lt;TD&gt;5&lt;/TD&gt;
   &lt;TD&gt;Decaf&lt;/TD&gt;
   &lt;TD&gt;Yes&lt;/TD&gt;
&lt;/TABLE&gt;
</pre>
</div>

<div class="example">
<p>In the following example, the user agent should show borders five pixels
thick on the left-hand and right-hand sides of the table, with rules drawn
between each column.</p>

<pre>
&lt;TABLE border="5" frame="vsides" rules="cols"&gt;
&lt;TR&gt; &lt;TD&gt;1 &lt;TD&gt;2 &lt;TD&gt;3
&lt;TR&gt; &lt;TD&gt;4 &lt;TD&gt;5 &lt;TD&gt;6
&lt;TR&gt; &lt;TD&gt;7 &lt;TD&gt;8 &lt;TD&gt;9
&lt;/TABLE&gt;
</pre>
</div>

<p>The following settings should be observed by user agents for backwards
compatibility.</p>

<ul>
<li>Setting <a href="tables.html#adef-border-TABLE" class="noxref"><samp class= 
"ainst-TABLE">border</samp></a>="0" implies <a href="tables.html#adef-frame"
class="noxref"><samp class="ainst-TABLE">frame</samp></a>="void" and, unless
otherwise specified, <a href="tables.html#adef-rules" class="noxref"><samp
class="ainst-TABLE">rules</samp></a>="none".</li>

<li>Other values of <a href="tables.html#adef-border-TABLE" class="noxref">
<samp class="ainst-TABLE">border</samp></a> imply <a href= 
"tables.html#adef-frame" class="noxref"><samp class="ainst-TABLE">
frame</samp></a>="border" and, unless otherwise specified, <a href= 
"tables.html#adef-rules" class="noxref"><samp class="ainst-TABLE">
rules</samp></a>="all".</li>

<li>The value "border" in the start tag of the <a href="tables.html#edef-TABLE"
class="noxref"><samp class="einst">TABLE</samp></a> element should be
interpreted as the value of the <a href="tables.html#adef-frame" class=
"noxref"><samp class="ainst-TABLE">frame</samp></a> attribute. It implies <a
href="tables.html#adef-rules" class="noxref"><samp class="ainst-TABLE">
rules</samp></a>="all" and some default (non-zero) value for the <a href= 
"tables.html#adef-border-TABLE" class="noxref"><samp class="ainst-TABLE">
border</samp></a> attribute.</li>
</ul>

<div class="example">
<p>For example, the following definitions are equivalent:</p>

<pre>
&lt;TABLE border="2"&gt;
&lt;TABLE border="2" frame="border" rules="all"&gt;
</pre>

<p>as are the following:</p>

<pre>
&lt;TABLE border&gt;
&lt;TABLE frame="border" rules="all"&gt;
</pre>
</div>

<div class="note">
<p><em><strong>Note.</strong> The <a href="objects.html#adef-border-IMG" class= 
"noxref"><samp class="ainst-IMG">border</samp></a> attribute also defines the
border behavior for the <a href="objects.html#edef-OBJECT" class="noxref"><samp
class="einst">OBJECT</samp></a> and <a href="objects.html#edef-IMG" class= 
"noxref"><samp class="einst">IMG</samp></a> elements, but takes different
values for those elements.</em></p>
</div>

<h3><a name="h-11.3.2">11.3.2</a> <span class="index-inst" title= 
"table::alignment of contents|alignment::of table contents"><a name=
"alignment">Horizontal and vertical alignment</a></span></h3>

<p>The following attributes may be set for different table elements (see their
definitions).</p>

<div class="dtd-fragment">
<pre class="dtd-fragment">
&lt;!-- horizontal alignment attributes for cell contents --&gt;
&lt;!ENTITY % cellhalign
  "<a href="tables.html#adef-align-TD" class="noxref"><samp class=
"ainst-TD">align</samp></a>      (left|center|right|justify|char) #IMPLIED
   <a href="tables.html#adef-char" class="noxref"><samp class=
"ainst">char</samp></a>       <a href=
"../sgml/dtd.html#Character">%Character;</a>    #IMPLIED  -- alignment char, e.g. char=':' --
   <a href="tables.html#adef-charoff" class="noxref"><samp class=
"ainst">charoff</samp></a>    <a href=
"../sgml/dtd.html#Length">%Length;</a>       #IMPLIED  -- offset for alignment char --"
  &gt;
&lt;!-- vertical alignment attributes for cell contents --&gt;
&lt;!ENTITY % cellvalign
  "<a href="tables.html#adef-valign" class="noxref"><samp class=
"ainst">valign</samp></a>     (top|middle|bottom|baseline) #IMPLIED"
  &gt;
</pre>
</div>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-align-TD"><samp class="adef">align</samp></a> = <samp>
left|center|right|justify|char</samp> <a href="../types.html#case-insensitive">
[CI]</a></dt>

<dd>This attribute specifies the alignment of data and the justification of
text in a cell. Possible values: 

<ul>
<li><samp>left:</samp> Left-flush data/Left-justify text. This is the default
value for table data.</li>

<li><samp>center:</samp> Center data/Center-justify text. This is the default
value for table headers.</li>

<li><samp>right:</samp> Right-flush data/Right-justify text.</li>

<li><samp>justify:</samp> Double-justify text.</li>

<li><samp>char:</samp> Align text around a specific character. If a user agent
doesn't support character alignment, behavior in the presence of this value is
unspecified.</li>
</ul>
</dd>

<dt><a name="adef-valign"><samp class="adef">valign</samp></a> = <samp>
top|middle|bottom|baseline</samp> <a href="../types.html#case-insensitive">
[CI]</a></dt>

<dd>This attribute specifies the vertical position of data within a cell.
Possible values: 

<ul>
<li><samp>top:</samp> Cell data is flush with the top of the cell.</li>

<li><samp>middle:</samp> Cell data is centered vertically within the cell. This
is the default value.</li>

<li><samp>bottom:</samp> Cell data is flush with the bottom of the cell.</li>

<li><samp>baseline:</samp> All cells in the same row as a cell whose <samp>
valign</samp> attribute has this value should have their textual data
positioned so that the first text line occurs on a baseline common to all cells
in the row. This constraint does not apply to subsequent text lines in these
cells.</li>
</ul>
</dd>

<dt><a name="adef-char"><samp class="adef">char</samp></a> = <a href= 
"../types.html#type-character"><em>character</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies a single character within a text fragment to act
as an axis for alignment. The default value for this attribute is the decimal
point character for the current language as set by the <a href= 
"dirlang.html#adef-lang" class="noxref"><samp class="ainst">lang</samp></a>
attribute (e.g., the period (".") in English and the comma (",") in French).
User agents are not required to support this attribute.</dd>

<dt><a name="adef-charoff"><samp class="adef">charoff</samp></a> = <a href= 
"../types.html#type-length"><em>length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>When present, this attribute specifies the offset to the first occurrence
of the alignment character on each line. If a line doesn't include the
alignment character, it should be horizontally shifted to end at the alignment
position. 

<p>When <a href="tables.html#adef-charoff" class="noxref"><samp class="ainst">
charoff</samp></a> is used to set the offset of an alignment character, the
direction of offset is determined by the current text direction (set by the <a
href="dirlang.html#adef-dir" class="noxref"><samp class="ainst">dir</samp></a>
attribute). In left-to-right texts (the default), offset is from the left
margin. In right-to-left texts, offset is from the right margin. User agents
are not required to support this attribute.</p>
</dd>
</dl>
</div>

<div class="example">
<p>The table in this example aligns a row of currency values along a decimal
point. We set the alignment character to "." explicitly.</p>

<pre>
&lt;TABLE border="1"&gt;
&lt;COLGROUP&gt;
&lt;COL&gt;&lt;COL align="char" char="."&gt;
&lt;THEAD&gt;
&lt;TR&gt;&lt;TH&gt;Vegetable &lt;TH&gt;Cost per kilo
&lt;TBODY&gt;
&lt;TR&gt;&lt;TD&gt;Lettuce        &lt;TD&gt;$1
&lt;TR&gt;&lt;TD&gt;Silver carrots &lt;TD&gt;$10.50
&lt;TR&gt;&lt;TD&gt;Golden turnips &lt;TD&gt;$100.30
&lt;/TABLE&gt;
</pre>

<p>The formatted table may resemble the following:</p>

<pre>
------------------------------
|   Vegetable  |Cost per kilo|
|--------------|-------------|
|Lettuce       |        $1   |
|--------------|-------------|
|Silver carrots|       $10.50|
|--------------|-------------|
|Golden turnips|      $100.30|
------------------------------
</pre>
</div>

<p>When the contents of a cell contain more than one instance of the alignment
character specified by <a href="tables.html#adef-char" class="noxref"><samp
class="ainst">char</samp></a> and the contents wrap, user agent behavior is
undefined. Authors should therefore be attentive in their use of <a href= 
"tables.html#adef-char" class="noxref"><samp class="ainst">char</samp></a>.</p>

<div class="note">
<p><em><strong>Note.</strong> Visual user agents typically render <a href= 
"tables.html#edef-TH" class="noxref"><samp class="einst">TH</samp></a> elements
vertically and horizontally centered within the cell and with a bold font
weight.</em></p>
</div>

<h4><a name="alignment-inheritance">Inheritance of alignment
specifications</a><a name="h-11.3.2.1">&nbsp;</a></h4>

<p>The alignment of cell contents can be specified on a cell by cell basis, or
inherited from enclosing elements, such as the row, column or the table
itself.</p>

<p>The order of precedence (from highest to lowest) for the attributes <a href= 
"tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a>, <a href="tables.html#adef-char" class="noxref"><samp class= 
"ainst">char</samp></a>, and <a href="tables.html#adef-charoff" class="noxref">
<samp class="ainst">charoff</samp></a> is the following:</p>

<ol>
<li>An alignment attribute set on an element within a cell's data (e.g., <a
href="text.html#edef-P" class="noxref"><samp class="einst">P</samp></a>).</li>

<li>An alignment attribute set on a cell (<a href="tables.html#edef-TH" class= 
"noxref"><samp class="einst">TH</samp></a> and <a href="tables.html#edef-TD"
class="noxref"><samp class="einst">TD</samp></a>).</li>

<li>An alignment attribute set on a column grouping element (<a href= 
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a> and <a
href="tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a>). When a cell is part of a multi-column span, the alignment
property is inherited from the cell definition at the beginning of the
span.</li>

<li>An alignment attribute set on a row or row grouping element (<a href= 
"tables.html#edef-TR" class="noxref"><samp class="einst">TR</samp></a>, <a
href="tables.html#edef-THEAD" class="noxref"><samp class="einst">
THEAD</samp></a>, <a href="tables.html#edef-TFOOT" class="noxref"><samp class= 
"einst">TFOOT</samp></a>, and <a href="tables.html#edef-TBODY" class="noxref">
<samp class="einst">TBODY</samp></a>). When a cell is part of a multi-row span,
the alignment property is inherited from the cell definition at the beginning
of the span.</li>

<li>An alignment attribute set on the table (<a href="tables.html#edef-TABLE"
class="noxref"><samp class="einst">TABLE</samp></a>).</li>

<li>The default alignment value.</li>
</ol>

<p>The order of precedence (from highest to lowest) for the attribute <a href= 
"tables.html#adef-valign" class="noxref"><samp class="ainst">valign</samp></a>
(as well as the other inherited attributes <a href="dirlang.html#adef-lang"
class="noxref"><samp class="ainst">lang</samp></a>, <a href= 
"dirlang.html#adef-dir" class="noxref"><samp class="ainst">dir</samp></a>, and
<a href="../present/styles.html#adef-style" class="noxref"><samp class="ainst">
style</samp></a>) is the following:</p>

<ol>
<li>An attribute set on an element within a cell's data (e.g., <a href= 
"text.html#edef-P" class="noxref"><samp class="einst">P</samp></a>).</li>

<li>An attribute set on a cell (<a href="tables.html#edef-TH" class=
"noxref"><samp class="einst">TH</samp></a> and <a href="tables.html#edef-TD"
class="noxref"><samp class="einst">TD</samp></a>).</li>

<li>An attribute set on a row or row grouping element (<a href= 
"tables.html#edef-TR" class="noxref"><samp class="einst">TR</samp></a>, <a
href="tables.html#edef-THEAD" class="noxref"><samp class="einst">
THEAD</samp></a>, <a href="tables.html#edef-TFOOT" class="noxref"><samp class= 
"einst">TFOOT</samp></a>, and <a href="tables.html#edef-TBODY" class="noxref">
<samp class="einst">TBODY</samp></a>). When a cell is part of a multi-row span,
the attribute value is inherited from the cell definition at the beginning of
the span.</li>

<li>An attribute set on a column grouping element (<a href=
"tables.html#edef-COL" class="noxref"><samp class="einst">COL</samp></a> and <a
href="tables.html#edef-COLGROUP" class="noxref"><samp class="einst">
COLGROUP</samp></a>). When a cell is part of a multi-column span, the attribute
value is inherited from the cell definition at the beginning of the span.</li>

<li>An attribute set on the table (<a href="tables.html#edef-TABLE" class= 
"noxref"><samp class="einst">TABLE</samp></a>).</li>

<li>The default attribute value.</li>
</ol>

<p>Furthermore, when rendering cells, horizontal alignment is determined by
columns in preference to rows, while for vertical alignment, rows are given
preference over columns.</p>

<p>The default alignment for cells depends on the user agent. However, user
agents should substitute the default attribute for the current directionality
(i.e., not just "left" in all cases).</p>

<p>User agents that do not support the "justify" value of the <a href= 
"tables.html#adef-align-TD" class="noxref"><samp class="ainst-TD">
align</samp></a> attribute should use the value of the inherited directionality
in its place.</p>

<div class="note"><em><strong>Note.</strong> Note that a cell may inherit an
attribute not from its parent but from the first cell in a span. This is an
exception to the general attribute inheritance rules.</em></div>

<h3><a name="h-11.3.3">11.3.3</a> <span class="index-inst" title="white 
space::around table contents| table::cell margins"><a name="margins">Cell
margins</a></span></h3>

<div class="adef-list">
<p><em>Attribute definitions</em></p>

<dl>
<dt><a name="adef-cellspacing"><samp class="adef">cellspacing</samp></a> = <a
href="../types.html#type-length"><em>length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies how much space the user agent should leave between
the left side of the table and the left-hand side of the leftmost column, the
top of the table and the top side of the topmost row, and so on for the right
and bottom of the table. The attribute also specifies the amount of space to
leave between cells.</dd>

<dt><a name="adef-cellpadding"><samp class="adef">cellpadding</samp></a> = <a
href="../types.html#type-length"><em>length</em></a> <a href= 
"../types.html#case-neutral">[CN]</a></dt>

<dd>This attribute specifies the amount of space between the border of the cell
and its contents. If the value of this attribute is a pixel length, all four
margins should be this distance from the contents. If the value of the
attribute is a percentage length, the top and bottom margins should be equally
separated from the content based on a percentage of the available vertical
space, and the left and right margins should be equally separated from the
content based on a percentage of the available horizontal space.</dd>
</dl>
</div>

<p>These two attributes control spacing between and within cells. The following
illustration explains how they relate:</p>

<p align="center"><img src="../images/cellsppad.gif" alt=
"Image illustrating how cellspacing and cellpadding attributes relate."></p>

<div class="example">
<p>In the following example, the <a href="tables.html#adef-cellspacing" class= 
"noxref"><samp class="ainst">cellspacing</samp></a> attribute specifies that
cells should be separated from each other and from the table frame by twenty
pixels. The <a href="tables.html#adef-cellpadding" class="noxref"><samp class= 
"ainst">cellpadding</samp></a> attribute specifies that the top margin of the
cell and the bottom margin of the cell will each be separated from the cell's
contents by 10% of the available vertical space (the total being 20%).
Similarly, the left margin of the cell and the right margin of the cell will
each be separated from the cell's contents by 10% of the available horizontal
space (the total being 20%).</p>

<pre>
&lt;TABLE cellspacing="20" cellpadding="20%"&gt;
&lt;TR&gt; &lt;TD&gt;Data1 &lt;TD&gt;Data2 &lt;TD&gt;Data3
&lt;/TABLE&gt;
</pre>
</div>

<p>If a table or given column has a fixed width, <a href= 
"tables.html#adef-cellspacing" class="noxref"><samp class="ainst">
cellspacing</samp></a> and <a href="tables.html#adef-cellpadding" class=
"noxref"><samp class="ainst">cellpadding</samp></a> may demand more space than
assigned. User agents may give these attributes precedence over the <a href= 
"tables.html#adef-width-TH" class="noxref"><samp class="ainst-TH">
width</samp></a> attribute when a conflict occurs, but are not required to.</p>

<h2><a name="h-11.4">11.4</a> <span class="index-inst" title="table::non-visual 
rendering of"><a name="non-visual-rendering">Table rendering by non-visual user
agents</a></span></h2>

<h3><a name="h-11.4.1">11.4.1</a> <a name="header-data">Associating header
information with data cells</a></h3>

<p>Non-visual user agents such as speech synthesizers and Braille-based devices
may use the following <a href="tables.html#edef-TD" class="noxref"><samp class= 
"einst">TD</samp></a> and <a href="tables.html#edef-TH" class="noxref"><samp
class="einst">TH</samp></a> element attributes to render table cells more
intuitively:</p>

<ul>
<li>For a given data cell, the <a href="tables.html#adef-headers" class=
"noxref"><samp class="ainst">headers</samp></a> attribute lists which cells
provide pertinent header information. For this purpose, each header cell must
be named using the <a href="global.html#adef-id" class="noxref"><samp class= 
"ainst">id</samp></a> attribute. Note that it's not always possible to make a
clean division of cells into headers or data. You should use the <a href= 
"tables.html#edef-TD" class="noxref"><samp class="einst">TD</samp></a> element
for such cells together with the <a href="global.html#adef-id" class="noxref">
<samp class="ainst">id</samp></a> or <a href="tables.html#adef-scope" class= 
"noxref"><samp class="ainst">scope</samp></a> attributes as appropriate.</li>

<li><span class="index-inst" title="header cell::scope of|scope::of table 
header cell"><a name="idx-header_cell-1">For a given header cell</a></span>,
the <a href="tables.html#adef-scope" class="noxref"><samp class="ainst">
scope</samp></a> attribute tells the user agent the data cells for which this
header provides information. Authors may choose to use this attribute instead
of <a href="tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> according to which is more convenient; the two attributes
fulfill the same function. The <a href="tables.html#adef-headers" class=
"noxref"><samp class="ainst">headers</samp></a> attribute is generally needed
when headers are placed in irregular positions with respect to the data they
apply to.</li>

<li><span class="index-inst" title="header cell::abbreviation">The <a name= 
"idx-header_cell-2" href="tables.html#adef-abbr" class="noxref"><samp class= 
"ainst">abbr</samp></a> attribute</span> specifies an abbreviated header for
header cells so that user agents may render header information more
rapidly.</li>
</ul>

<div class="example">
<p>In the following example, we assign header information to cells by setting
the <a href="tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> attribute. Each cell in the same column refers to the same
header cell (via the <a href="global.html#adef-id" class="noxref"><samp class= 
"ainst">id</samp></a> attribute).</p>

<pre>
&lt;TABLE border="1" 
       summary="This table charts the number of cups
                of coffee consumed by each senator, the type 
                of coffee (decaf or regular), and whether 
                taken with sugar."&gt;
&lt;CAPTION&gt;Cups of coffee consumed by each senator&lt;/CAPTION&gt;
&lt;TR&gt;
   &lt;TH id="t1"&gt;Name&lt;/TH&gt;
   &lt;TH id="t2"&gt;Cups&lt;/TH&gt;
   &lt;TH id="t3" abbr="Type"&gt;Type of Coffee&lt;/TH&gt;
   &lt;TH id="t4"&gt;Sugar?&lt;/TH&gt;
&lt;TR&gt;
   &lt;TD headers="t1"&gt;T. Sexton&lt;/TD&gt;
   &lt;TD headers="t2"&gt;10&lt;/TD&gt;
   &lt;TD headers="t3"&gt;Espresso&lt;/TD&gt;
   &lt;TD headers="t4"&gt;No&lt;/TD&gt;
&lt;TR&gt;
   &lt;TD headers="t1"&gt;J. Dinnen&lt;/TD&gt;
   &lt;TD headers="t2"&gt;5&lt;/TD&gt;
   &lt;TD headers="t3"&gt;Decaf&lt;/TD&gt;
   &lt;TD headers="t4"&gt;Yes&lt;/TD&gt;
&lt;/TABLE&gt;
</pre>

<p>A speech synthesizer might render this table as follows:</p>

<pre>
Caption: Cups of coffee consumed by each senator
Summary: This table charts the number of cups
         of coffee consumed by each senator, the type 
         of coffee (decaf or regular), and whether 
         taken with sugar.
Name: T. Sexton,   Cups: 10,   Type: Espresso,   Sugar: No
Name: J. Dinnen,   Cups: 5,    Type: Decaf,      Sugar: Yes
</pre>

<p>Note how the header "Type of Coffee" is abbreviated to "Type" using the <a
href="tables.html#adef-abbr" class="noxref"><samp class="ainst">abbr</samp></a>
attribute.</p>
</div>

<div class="example">
<p>Here is the same example substituting the <a href="tables.html#adef-scope"
class="noxref"><samp class="ainst">scope</samp></a> attribute for the <a href= 
"tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> attribute. Note the value "col" for the <a href= 
"tables.html#adef-scope" class="noxref"><samp class="ainst">scope</samp></a>
attribute, meaning "all cells in the current column":</p>

<pre>
&lt;TABLE border="1" 
       summary="This table charts the number of cups
                of coffee consumed by each senator, the type 
                of coffee (decaf or regular), and whether 
                taken with sugar."&gt;
&lt;CAPTION&gt;Cups of coffee consumed by each senator&lt;/CAPTION&gt;
&lt;TR&gt;
   &lt;TH scope="col"&gt;Name&lt;/TH&gt;
   &lt;TH scope="col"&gt;Cups&lt;/TH&gt;
   &lt;TH scope="col" abbr="Type"&gt;Type of Coffee&lt;/TH&gt;
   &lt;TH scope="col"&gt;Sugar?&lt;/TH&gt;
&lt;TR&gt;
   &lt;TD&gt;T. Sexton&lt;/TD&gt;
   &lt;TD&gt;10&lt;/TD&gt;
   &lt;TD&gt;Espresso&lt;/TD&gt;
   &lt;TD&gt;No&lt;/TD&gt;
&lt;TR&gt;
   &lt;TD&gt;J. Dinnen&lt;/TD&gt;
   &lt;TD&gt;5&lt;/TD&gt;
   &lt;TD&gt;Decaf&lt;/TD&gt;
   &lt;TD&gt;Yes&lt;/TD&gt;
&lt;/TABLE&gt;
</pre>
</div>

<div class="example" id="course-ex">
<p>Here's a somewhat more complex example illustrating other values for the <a
href="tables.html#adef-scope" class="noxref"><samp class="ainst">
scope</samp></a> attribute:</p>

<pre>
&lt;TABLE border="1" cellpadding="5" cellspacing="2"
  summary="History courses offered in the community of
           Bath arranged by course name, tutor, summary, 
           code, and fee"&gt;
  &lt;TR&gt;
    &lt;TH colspan="5" scope="colgroup"&gt;Community Courses -- Bath Autumn 1997&lt;/TH&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TH scope="col" abbr="Name"&gt;Course Name&lt;/TH&gt;
    &lt;TH scope="col" abbr="Tutor"&gt;Course Tutor&lt;/TH&gt;
    &lt;TH scope="col"&gt;Summary&lt;/TH&gt;
    &lt;TH scope="col"&gt;Code&lt;/TH&gt;
    &lt;TH scope="col"&gt;Fee&lt;/TH&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD scope="row"&gt;After the Civil War&lt;/TD&gt;
    &lt;TD&gt;Dr. John Wroughton&lt;/TD&gt;
    &lt;TD&gt;
       The course will examine the turbulent years in England
       after 1646. &lt;EM&gt;6 weekly meetings starting Monday 13th
      October.&lt;/EM&gt;
    &lt;/TD&gt;
    &lt;TD&gt;H27&lt;/TD&gt;
    &lt;TD&gt;&amp;pound;32&lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD scope="row"&gt;An Introduction to Anglo-Saxon England&lt;/TD&gt;
    &lt;TD&gt;Mark Cottle&lt;/TD&gt;
    &lt;TD&gt;
       One day course introducing the early medieval
       period reconstruction the Anglo-Saxons and
       their society. &lt;EM&gt;Saturday 18th October.&lt;/EM&gt;
    &lt;/TD&gt;
    &lt;TD&gt;H28&lt;/TD&gt;
    &lt;TD&gt;&amp;pound;18&lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD scope="row"&gt;The Glory that was Greece&lt;/TD&gt;
    &lt;TD&gt;Valerie Lorenz&lt;/TD&gt;
    &lt;TD&gt;
     Birthplace of democracy, philosophy, heartland of theater, home of
     argument. The Romans may have done it but the Greeks did it
     first. &lt;EM&gt;Saturday day school 25th October 1997&lt;/EM&gt;
    &lt;/TD&gt;
    &lt;TD&gt;H30&lt;/TD&gt;
    &lt;TD&gt;&amp;pound;18&lt;/TD&gt;
  &lt;/TR&gt;
&lt;/TABLE&gt;
</pre>

<p>A graphical user agent might render this as:</p>

<p><img src="../images/table2.gif" alt="A table with merged cells"></p>

<p>Note the use of the <a href="tables.html#adef-scope" class="noxref"><samp
class="ainst">scope</samp></a> attribute with the "row" value. Although the
first cell in each row contains data, not header information, the <a href= 
"tables.html#adef-scope" class="noxref"><samp class="ainst">scope</samp></a>
attribute makes the data cell behave like a row header cell. This allows speech
synthesizers to provide the relevant course name upon request or to state it
immediately before each cell's content.</p>
</div>

<h3><a name="h-11.4.2">11.4.2</a> <span class="index-inst" title= 
"table::categorization of cells"><a name="multi-dimension">Categorizing
cells</a></span></h3>

<p>Users browsing a table with a speech-based user agent may wish to hear an
explanation of a cell's contents in addition to the contents themselves. One
way the user might provide an explanation is by speaking associated header
information before speaking the data cell's contents (see the section on <a
href="#header-data">associating header information with data cells</a>).</p>

<p>Users may also want information about more than one cell, in which case
header information provided at the cell level (by <a href= 
"tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a>, <a href="tables.html#adef-scope" class="noxref"><samp
class="ainst">scope</samp></a>, and <a href="tables.html#adef-abbr" class= 
"noxref"><samp class="ainst">abbr</samp></a>) may not provide adequate context.
Consider the following table, which classifies expenses for meals, hotels, and
transport in two locations (San Jose and Seattle) over several days:</p>

<p align="center"><img src="../images/table1.gif" alt=
"Image of a table listing travel expenses at two locations: San Jose and Seattle, by date, and category (meals, hotels, and transport), shown with subtitles"
width="399" height="207"></p>

<p>Users might want to extract information from the table in the form of
queries:</p>

<ul>
<li>"What did I spend for all my meals?"</li>

<li>"What did I spend for meals on 25 August?"</li>

<li>"What did I spend for all expenses in San Jose?"</li>
</ul>

<p>Each query involves a computation by the user agent that may involve zero or
more cells. In order to determine, for example, the costs of meals on 25
August, the user agent must know which table cells refer to "Meals" (all of
them) and which refer to "Dates" (specifically, 25 August), and find the
intersection of the two sets.</p>

<p>To accommodate this type of query, the HTML 4 table model allows authors to
place cell headers and data into categories. For example, for the travel
expense table, an author could group the header cells "San Jose" and "Seattle"
into the category "Location", the headers "Meals", "Hotels", and "Transport" in
the category "Expenses", and the four days into the category "Date". The
previous three questions would then have the following meanings:</p>

<ul>
<li>"What did I spend for all my meals?" means "What are all the data cells in
the "Expenses=Meals" category?</li>

<li>"What did I spend for meals on 25 August?" means "What are all the data
cells in the "Expenses=Meals" and "Date=Aug-25-1997" categories?</li>

<li>"What did I spend for all expenses in San Jose?" means "What are all the
data cells in the "Expenses=Meals, Hotels, Transport" and "Location=San Jose"
categories?</li>
</ul>

<p>Authors categorize a header or data cell by setting the <a href= 
"tables.html#adef-axis" class="noxref"><samp class="ainst">axis</samp></a>
attribute for the cell. For instance, in the travel expense table, the cell
containing the information "San Jose" could be placed in the "Location"
category as follows:</p>

<pre class="example">
  &lt;TH id="a6" axis="location"&gt;San Jose&lt;/TH&gt;
</pre>

<p>Any cell containing information related to "San Jose" should refer to this
header cell via either the <a href="tables.html#adef-headers" class="noxref">
<samp class="ainst">headers</samp></a> or the <a href="tables.html#adef-scope"
class="noxref"><samp class="ainst">scope</samp></a> attribute. Thus, meal
expenses for 25-Aug-1997 should be marked up to refer to <a href= 
"global.html#adef-id" class="noxref"><samp class="ainst">id</samp></a>
attribute (whose value here is "a6") of the "San Jose" header cell:</p>

<pre>
  
  &lt;TD headers="a6"&gt;37.74&lt;/TD&gt;
</pre>

<p>Each <a href="tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> attribute provides a list of <a href="global.html#adef-id"
class="noxref"><samp class="ainst">id</samp></a> references. Authors may thus
categorize a given cell in any number of ways (or, along any number of
"headers", hence the name).</p>

<p>Below we mark up the travel expense table with category information:</p>

<pre class="example">
&lt;TABLE border="1"
          summary="This table summarizes travel expenses
                   incurred during August trips to
                   San Jose and Seattle"&gt;
&lt;CAPTION&gt;
  Travel Expense Report
&lt;/CAPTION&gt;
&lt;TR&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TH id="a2" axis="expenses"&gt;Meals&lt;/TH&gt;
  &lt;TH id="a3" axis="expenses"&gt;Hotels&lt;/TH&gt;
  &lt;TH id="a4" axis="expenses"&gt;Transport&lt;/TH&gt;
  &lt;TD&gt;subtotals&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TH id="a6" axis="location"&gt;San Jose&lt;/TH&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TD&gt;&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TD id="a7" axis="date"&gt;25-Aug-97&lt;/TD&gt;
  &lt;TD headers="a6 a7 a2"&gt;37.74&lt;/TD&gt;
  &lt;TD headers="a6 a7 a3"&gt;112.00&lt;/TD&gt;
  &lt;TD headers="a6 a7 a4"&gt;45.00&lt;/TD&gt;
  &lt;TD&gt;&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TD id="a8" axis="date"&gt;26-Aug-97&lt;/TD&gt;
  &lt;TD headers="a6 a8 a2"&gt;27.28&lt;/TD&gt;
  &lt;TD headers="a6 a8 a3"&gt;112.00&lt;/TD&gt;
  &lt;TD headers="a6 a8 a4"&gt;45.00&lt;/TD&gt;
  &lt;TD&gt;&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TD&gt;subtotals&lt;/TD&gt;
  &lt;TD&gt;65.02&lt;/TD&gt;
  &lt;TD&gt;224.00&lt;/TD&gt;
  &lt;TD&gt;90.00&lt;/TD&gt;
  &lt;TD&gt;379.02&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TH id="a10" axis="location"&gt;Seattle&lt;/TH&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TH&gt;&lt;/TH&gt;
  &lt;TD&gt;&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TD id="a11" axis="date"&gt;27-Aug-97&lt;/TD&gt;
  &lt;TD headers="a10 a11 a2"&gt;96.25&lt;/TD&gt;
  &lt;TD headers="a10 a11 a3"&gt;109.00&lt;/TD&gt;
  &lt;TD headers="a10 a11 a4"&gt;36.00&lt;/TD&gt;
  &lt;TD&gt;&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TD id="a12" axis="date"&gt;28-Aug-97&lt;/TD&gt;
  &lt;TD headers="a10 a12 a2"&gt;35.00&lt;/TD&gt;
  &lt;TD headers="a10 a12 a3"&gt;109.00&lt;/TD&gt;
  &lt;TD headers="a10 a12 a4"&gt;36.00&lt;/TD&gt;
  &lt;TD&gt;&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TD&gt;subtotals&lt;/TD&gt;
  &lt;TD&gt;131.25&lt;/TD&gt;
  &lt;TD&gt;218.00&lt;/TD&gt;
  &lt;TD&gt;72.00&lt;/TD&gt;
  &lt;TD&gt;421.25&lt;/TD&gt;
&lt;/TR&gt;
&lt;TR&gt;
  &lt;TH&gt;Totals&lt;/TH&gt;
  &lt;TD&gt;196.27&lt;/TD&gt;
  &lt;TD&gt;442.00&lt;/TD&gt;
  &lt;TD&gt;162.00&lt;/TD&gt;
  &lt;TD&gt;800.27&lt;/TD&gt;
&lt;/TR&gt;
&lt;/TABLE&gt;
</pre>

<p>Note that marking up the table this way also allows user agents to avoid
confusing the user with unwanted information. For instance, if a speech
synthesizer were to speak all of the figures in the "Meals" column of this
table in response to the query "What were all my meal expenses?", a user would
not be able to distinguish a day's expenses from subtotals or totals. By
carefully categorizing cell data, authors allow user agents to make important
semantic distinctions when rendering.</p>

<p>Of course, there is no limit to how authors may categorize information in a
table. In the travel expense table, for example, we could add the additional
categories "subtotals" and "totals".</p>

<p>This specification does not require user agents to handle information
provided by the <a href="tables.html#adef-axis" class="noxref"><samp class= 
"ainst">axis</samp></a> attribute, nor does it make any recommendations about
how user agents may present <a href="tables.html#adef-axis" class="noxref">
<samp class="ainst">axis</samp></a> information to users or how users may query
the user agent about this information.</p>

<p><span class="index-inst" title="table::speaking cell data"><a name= 
"idx-table-18">However, user agents, particularly speech
synthesizers,</a></span> may want to factor out information common to several
cells that are the result of a query. For instance, if the user asks "What did
I spend for meals in San Jose?", the user agent would first determine the cells
in question (25-Aug-1997: 37.74, 26-Aug-1997:27.28), then render this
information. A user agent speaking this information might read it:</p>

<pre class="example">
   Location: San Jose. Date: 25-Aug-1997. Expenses, Meals: 37.74
   Location: San Jose. Date: 26-Aug-1997. Expenses, Meals: 27.28
</pre>

<p>or, more compactly:</p>

<pre class="example">
   San Jose, 25-Aug-1997, Meals: 37.74
   San Jose, 26-Aug-1997, Meals: 27.28
</pre>

<p>An even more economical rendering would factor the common information and
reorder it:</p>

<pre class="example">
   San Jose, Meals, 25-Aug-1997: 37.74
                    26-Aug-1997: 27.28
</pre>

<p>User agents that support this type of rendering should allow user agents a
means to customize rendering (e.g., through style sheets).</p>

<h3><a name="h-11.4.3">11.4.3</a> <span class="index-inst" title= 
"table::algorithm to find heading"><a name="idx-table-19">Algorithm to find
heading information</a></span></h3>

<p>In the absence of header information from either the <a href= 
"tables.html#adef-scope" class="noxref"><samp class="ainst">scope</samp></a> or
<a href="tables.html#adef-headers" class="noxref"><samp class="ainst">
headers</samp></a> attribute, user agents may construct header information
according to the following algorithm. The goal of the algorithm is to find an
ordered list of headers. (In the following description of the algorithm the <a
href="#table-directionality">table directionality</a> is assumed to be
left-to-right.)</p>

<ul>
<li>First, search left from the cell's position to find row header cells. Then
search upwards to find column header cells. The search in a given direction
stops when the edge of the table is reached or when a data cell is found after
a header cell.</li>

<li>Row headers are inserted into the list in the order they appear in the
table. For left-to-right tables, headers are inserted from left to right.</li>

<li>Column headers are inserted after row headers, in the order they appear in
the table, from top to bottom.</li>

<li>If a header cell has the <a href="tables.html#adef-headers" class="noxref">
<samp class="ainst">headers</samp></a> attribute set, then the headers
referenced by this attribute are inserted into the list and the search stops
for the current direction.</li>

<li><a href="tables.html#edef-TD" class="noxref"><samp class="einst">
TD</samp></a> cells that set the <a href="tables.html#adef-axis" class=
"noxref"><samp class="ainst">axis</samp></a> attribute are also treated as
header cells.</li>
</ul>

<h2><a name="h-11.5">11.5</a> <a name="sample">Sample table</a></h2>

<p>This sample illustrates grouped rows and columns. The example is adapted
from "Developing International Software", by Nadine Kano.</p>

<div class="example">
<p>In "ascii art", the following table:</p>

<pre>
&lt;TABLE border="2" frame="hsides" rules="groups"
          summary="Code page support in different versions
                   of MS Windows."&gt;
&lt;CAPTION&gt;CODE-PAGE SUPPORT IN MICROSOFT WINDOWS&lt;/CAPTION&gt;
&lt;COLGROUP align="center"&gt;
&lt;COLGROUP align="left"&gt;
&lt;COLGROUP align="center" span="2"&gt;
&lt;COLGROUP align="center" span="3"&gt;
&lt;THEAD valign="top"&gt;
&lt;TR&gt;
&lt;TH&gt;Code-Page&lt;BR&gt;ID
&lt;TH&gt;Name
&lt;TH&gt;ACP
&lt;TH&gt;OEMCP
&lt;TH&gt;Windows&lt;BR&gt;NT 3.1
&lt;TH&gt;Windows&lt;BR&gt;NT 3.51
&lt;TH&gt;Windows&lt;BR&gt;95
&lt;TBODY&gt;
&lt;TR&gt;&lt;TD&gt;1200&lt;TD&gt;Unicode (BMP of ISO/IEC-10646)&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;*
&lt;TR&gt;&lt;TD&gt;1250&lt;TD&gt;Windows 3.1 Eastern European&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1251&lt;TD&gt;Windows 3.1 Cyrillic&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1252&lt;TD&gt;Windows 3.1 US (ANSI)&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1253&lt;TD&gt;Windows 3.1 Greek&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1254&lt;TD&gt;Windows 3.1 Turkish&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1255&lt;TD&gt;Hebrew&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1256&lt;TD&gt;Arabic&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1257&lt;TD&gt;Baltic&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;1361&lt;TD&gt;Korean (Johab)&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;**&lt;TD&gt;X
&lt;TBODY&gt;
&lt;TR&gt;&lt;TD&gt;437&lt;TD&gt;MS-DOS United States&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;708&lt;TD&gt;Arabic (ASMO 708)&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;709&lt;TD&gt;Arabic (ASMO 449+, BCON V4)&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;710&lt;TD&gt;Arabic (Transparent Arabic)&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;TR&gt;&lt;TD&gt;720&lt;TD&gt;Arabic (Transparent ASMO)&lt;TD&gt;&lt;TD&gt;X&lt;TD&gt;&lt;TD&gt;&lt;TD&gt;X
&lt;/TABLE&gt;
</pre>

<p>would be rendered something like this:</p>

<pre>
                  CODE-PAGE SUPPORT IN MICROSOFT WINDOWS
===============================================================================
Code-Page | Name                         | ACP  OEMCP | Windows Windows Windows
    ID    |                              |            |  NT 3.1 NT 3.51    95
-------------------------------------------------------------------------------
   1200   | Unicode (BMP of ISO 10646)   |            |    X       X       *
   1250   | Windows 3.1 Eastern European |  X         |    X       X       X
   1251   | Windows 3.1 Cyrillic         |  X         |    X       X       X
   1252   | Windows 3.1 US (ANSI)        |  X         |    X       X       X
   1253   | Windows 3.1 Greek            |  X         |    X       X       X
   1254   | Windows 3.1 Turkish          |  X         |    X       X       X
   1255   | Hebrew                       |  X         |                    X
   1256   | Arabic                       |  X         |                    X
   1257   | Baltic                       |  X         |                    X
   1361   | Korean (Johab)               |  X         |            **      X
-------------------------------------------------------------------------------
    437   | MS-DOS United States         |        X   |    X       X       X
    708   | Arabic (ASMO 708)            |        X   |                    X
    709   | Arabic (ASMO 449+, BCON V4)  |        X   |                    X
    710   | Arabic (Transparent Arabic)  |        X   |                    X
    720   | Arabic (Transparent ASMO)    |        X   |                    X
===============================================================================
</pre>

<p>A graphical user agent might render this as:</p>

<p><img src="../images/table3.gif" alt="A table with grouped rows and columns">
</p>

<p>This example illustrates how <a href="tables.html#edef-COLGROUP" class= 
"noxref"><samp class="einst">COLGROUP</samp></a> can be used to group columns
and set the default column alignment. Similarly, <a href=
"tables.html#edef-TBODY" class="noxref"><samp class="einst">TBODY</samp></a> is
used to group rows. The <a href="tables.html#adef-frame" class="noxref"><samp
class="ainst">frame</samp></a> and <a href="tables.html#adef-rules" class= 
"noxref"><samp class="ainst">rules</samp></a> attributes tell the user agent
which borders and rules to render.</p>
</div>

<div class="navbar" align="center">
<hr><a href="lists.html">previous</a> &nbsp; <a href="links.html">next</a>
&nbsp; <a href="../cover.html#minitoc">contents</a> &nbsp; <a href= 
"../index/elements.html">elements</a> &nbsp; <a href=
"../index/attributes.html">attributes</a> &nbsp; <a href="../index/list.html">
index</a></div>
</body>
</html>

END_CODE

eval { $rosyn->insert($code_for_scrolling); };

ok(! $EVAL_ERROR, q{Test text insertion})
    or diag $EVAL_ERROR;

my $exit_button
    = $mw->Button(-text => q{Exit}, -command => sub { exit; })->pack();

if (! $ENV{CPAN_TEST_AUTHOR}) {
    $exit_button->invoke();
}

MainLoop;

