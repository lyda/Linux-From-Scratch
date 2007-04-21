<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

   <!-- Stylesheet for non-chunked XHTML output
        Replaces {docbook-xsl}/xhtml/profile-docbook.xsl -->

    <!-- Upstream XHTML profiled templates -->
  <xsl:import href="docbook-xsl-snapshot/xhtml/profile-docbook.xsl"/>

    <!-- Fix encoding issues with default UTF-8 output of the xhtml stylesheet -->
  <xsl:output method="html" encoding="ISO-8859-1" indent="no" />

   <!-- Including our others customized templates -->
  <xsl:include href="lfs-common.xsl"/>
  <xsl:include href="xhtml/lfs-index.xsl"/>
  <xsl:include href="xhtml/lfs-mixed.xsl"/>
  <xsl:include href="xhtml/lfs-sections.xsl"/>
  <xsl:include href="xhtml/lfs-toc.xsl"/>
  <xsl:include href="xhtml/lfs-xref.xsl"/>

    <!-- The LFS book type to be processed (lfs, blfs, clfs, or hlfs) -->
  <xsl:param name="book-type">lfs</xsl:param>

    <!-- Control generation of ToCs and LoTs -->
  <xsl:param name="generate.toc">
    book      toc,title
    preface   nop
    part      nop
    chapter   nop
    appendix  nop
    sect1     nop
    sect2     nop
    sect3     nop
    sect4     nop
    sect5     nop
    section   nop
  </xsl:param>

    <!-- How deep should recursive sections appear in the TOC? -->
  <xsl:param name="toc.section.depth">1</xsl:param>

    <!-- How maximaly deep should be each TOC? -->
  <xsl:param name="toc.max.depth">3</xsl:param>

    <!-- Dropping some unwanted style attributes -->
  <xsl:param name="ulink.target" select="''"></xsl:param>
  <xsl:param name="css.decoration" select="0"></xsl:param>

    <!-- Don't use graphics in admonitions -->
  <xsl:param name="admon.graphics" select="0"/>

    <!-- Changing the admonitions output tagging:
           Removed $admon.style support
           Hardcoded $admon.textlabel feature -->
    <!-- The original template is in {docbook-xsl}/xhtml/admon.xsl -->
  <xsl:template name="nongraphical.admonition">
    <div class="{name(.)}">
      <div class ="admonhead">
        <h3 class="admontitle">
          <xsl:apply-templates select="." mode="object.title.markup"/>
        </h3>
      </div>
      <div class="admonbody">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

    <!-- sect2.titlepage:
           Removed a lot of unneeded code.
           Skip empty titles.
           No label in preface (actualy, skip the hardcoded dot). -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="sect2.titlepage">
    <xsl:choose>
      <xsl:when test="string-length(title) = 0"/>
      <xsl:otherwise>
        <div class="titlepage">
          <xsl:if test="@id">
            <a id="{@id}" name="{@id}"/>
          </xsl:if>
          <h3 class="{name(.)}">
            <xsl:if test="not(ancestor::preface) and $section.autolabel != 0">
              <xsl:apply-templates select="." mode="label.markup"/>
              <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:value-of select="title"/>
          </h3>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- The CSS Stylesheet:
           Note: there is a few diferences with lfs.css code releated
                 to h* values. -->
    <!-- The original template is in {docbook-xsl}/xhtml/docbook.xsl -->
  <xsl:template name='user.head.content'>
    <style type="text/css">
      <xsl:text>
/* Global settings */
body {
  font-family: verdana, tahoma, helvetica, arial, sans-serif;
  text-align: left;
  background: #fff;
  color: #222;
  margin: 1em;
  padding: 0;
  font-size: 1em;
  line-height: 1.2em
}


/* Links */
a:link { color: #22b; }
a.ulink:link { font-weight: bold; color: #55f; }
a:visited { color: #7e4988 ! important; }
a:hover, a:focus { color: #d30e08 ! important; }
a:active { color: #6b77b1 ! important;}


/* Book titlepage */
.book {
  margin: 0px auto;
  padding: 0 1em;
}

.book h1, .book .authorgroup, .book .copyright, .book .legalnotice .revhistory {
  background: #f5f6f7;
  margin: 0px auto;
  padding: .1em 1em;
}

.book hr {
  background: #dbddec;
  height: .3em;
  border: 0px;
  margin: 0;
  padding: 0;
}

div.dedication .titlepage {
  background: #fff;
}

div.dedication p {
  padding-left: 2em;
}


/* Sections */
div.sect1, div.appendix {
  padding-left: .3em;
}

.package, .kernel, .installation, .commands, .testing, .configuration, .content {
  padding: 0 .5em .2em 0;
  margin: 0;
}

.lfs .package {
  background: #f5f6f7;
  border-bottom: 0.2em solid #dbddec;
  padding-top: .1em;
  margin-top: 0;
}

.lfs .configuration {
  background:   #fefefe;
  border-top: 0.2em solid #dbddec;
}

.lfs .content {
  background: #f5f6f7;
  border-top: 0.2em solid #dbddec;
  border-bottom: 0.2em solid #dbddec;
  padding-bottom: .1em;
  margin-bottom: 0;
}


/* Headers */
h1, h2, h3, h4, h5, h6, b, .strong {
  color: #000;
  font-weight: bold;
  line-height: 1em;
}

h1 {
  font-size: 173%;
  text-align: center;
}

.book h1 {
  margin: 0;
  padding: 0.4em;
}

h1.title sup {
  font-size: small;
}

h2 {
  font-size: 144%;
}

.preface h2, .part h1, .chapter h2, .appendix h2, .index h1, .sect1 h2 {
  background: #f5f6f7;
  border-top: .2em solid #dbddec;
  border-bottom: .2em solid #dbddec;
  margin-bottom: 1em;
  margin-top: 1em;
  padding: .4em;
  text-align: center;
}

.sect1 h2, .appendix h2 {
  margin-left: -.2em;
}

.wrap h2 {
  background: #f5f6f7;
  border-bottom: 0;
  margin-top: 1em;
  margin-bottom: 0;
  padding-top: .4em;
}

.book h2.subtitle {
  text-align: center;
  background: #dbddec;
  margin: 0;
  padding: 0.2em;
}

h3 {
  font-size: 120%;
}

.appendix h3 {
  font-size: 133%;
  margin-top: .8em;
  margin-bottom: 0.2em;
}

h4 {
  font-size: 110%;
}

.package h4, h5, h6 {
  font-size: 100%;
  font-style: italic;
}


/* TOC */
div.toc ul, div.index ul, div.navheader ul, div.navfooter ul {
  list-style: none;
}

div.toc {
  padding-left: 1em;
}

li.preface, .part li.appendix {
  margin-left: 1em;
}

div.toc h3 {
  margin: 1em 0 .3em 0;
}

li.appendix h3, li.glossary h3, li.index h3 {
  margin: .5em
}

div.toc h4 {
  margin: .6em 0 .2em 0;
}

li.chapter h4 a {
  display: block;
  margin-bottom: .4em
}

.dummy {
  display: block;
  font-weight: bold;
  font-size: 110%;
  margin: .6em 0 .2em 0;
}


/* Index */
.item {
    float: left;
}

.secitem {
    font-weight: normal;
    float: left;
}

.lfs .item + .indexref {
    margin-left: 18em;
}

.lfs .secitem + .indexref {
    margin-left: 17em;
}

.blfs .indexref {
    margin-left: 26em;
}


/* Admonitions */
div.note, div.tip {
  background-color: #fffff6;
  border: 2px solid #dbddec;
  width: 90%;
  margin: .5em auto;
}

div.important, div.warning, div.caution {
  background-color: #fffff6;
  border: medium solid #400;
  width: 90%;
  margin: .5em auto;
  color: #600;
}

div.important h3, div.warning h3, div.caution h3 {
  color: #900;
}

div.admonhead h3 {
  padding-left: 2.5em;
  padding-top: 1em;
}

div.admonbody {
  margin: .5em;
}

div.important em, div.warning em, div.caution em {
  color: #000;
  font-weight: bold;
}


/* table */
.table p.title {
  text-align: center;
  margin-top: 0;
  margin-bottom: .3em;
}

.table table {
  margin-left: auto;
  margin-right: auto;
}

.table table th, .table table td {
  padding: 0.2em 2em 0.2em 2em;
  text-align: left;
}

div.revhistory {
  padding-left: 1em;
}

div.revhistory th {
  line-height: 2em;
  text-align: left;
}

div.revhistory td {
  padding-right: 1em;
}


/* variablelist as table */
.variablelist table {
  width: auto;
  margin: 0 1em 0 1em;
}

.variablelist td {
  vertical-align: top;
}

.variablelist td span, td p {
  margin: 0.25em;
}

.variablelist td p {
  margin-top: 0;
}


/* variablelist as list */
dl {
  padding-left: 1em
}

dt {
  font-weight: bold;
  margin-left: 1em;
}

dd {
  margin-bottom: .6em;
  margin-left: 1em;
}

dd p {
  margin-top: 0;
  margin-bottom: 0;
  padding-top: 0;
  padding-bottom: 0;
}

div.materials dt {
  display: list-item;
}

div.materials dd {
  margin-left: 0;
  padding-left: 0;
}


/* segmentedlist */
.appendix .segmentedlist {
  padding-left: 1em;
}

.package .seg {
  margin-bottom: 0em;
  margin-top: 0em;
  clear: left;
}

.content .seg {
  margin-bottom: .4em;
  margin-top: .4em;
  clear: left;
}

.segtitle {
  float: left;
}

.package .segbody, .appendix .segbody {
  display: block;
  padding-left: 14em;
}

.content .segbody {
  display: block;
  padding-left: 12em;
}


/* itemizedlist */
ul {
  padding-left: 1em
}

.itemizedlist ul {
  margin-left: 1em
}

.itemizedlist li ul {
  margin-bottom: 1.2em;
}

.itemizedlist li ul li p {
  margin-top: .2em;
  margin-bottom: .2em;
}

.itemizedlist li ul li:first-child p:first-child {
  margin-top: -.6em;
}

ul[compact="compact"] {
  list-style: none;
}

.blfs ul[compact="compact"] {
  list-style: disc;
}

ul[compact="compact"] li {
  margin: 0em;
  padding: 0em;
}

ul[compact="compact"] li p {
  padding: 0.3em;
  margin: 0em;
}

.blfs ul[compact="compact"] li p {
  background-color: #f0fff0;
}


/* Indented blocks */
p, blockquote {
  padding-left: 1em;
  padding-right: 1em;
}


/* Monospaced elements */
tt, code, kbd, pre, .command {
  font-family: monospace;
}

.systemitem {
  font-style: italic;
}

pre.userinput {
  color: #101310;
  background-color: #e5e5e5;
  border: 1px solid #050505;
  padding: .5em 1em;
  margin: 0 2em .5em 2em;
  font-weight: bold;
}

pre.root {
  color: #101310;
  background-color: #e5e5e5;
  border: 1px solid #11a;
  padding: .5em 1em;
  margin: 0 2em;
  font-weight: bold;
}

pre.screen {
  color: #000;
  background-color: #e9e9e9;
  border: 1px solid #050505;
  padding: .5em 1em;
  margin: 0 2em;
}

.literal, .prompt {
  font-weight: normal;
}


/* Mixed tags */
p.usernotes {
  margin-left: -1em;
  font-size: small;
  font-weight: bold;
  font-style: italic;
}

.simplelist {
  background-color: #f0fff0;
}

.underlined {
  text-decoration: underline;
}


/* Last edited info */
p.updated {
  font-size: small;
  font-weight: bold;
  font-style: italic;
}
      </xsl:text>
    </style>
  </xsl:template>

</xsl:stylesheet>
