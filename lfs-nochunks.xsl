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
           No label in preface. -->
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
            <xsl:if test="not(ancestor::preface)">
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
                 to h* values-->
    <!-- The original template is in {docbook-xsl}/xhtml/docbook.xsl -->
  <xsl:template name='user.head.content'>
    <style type="text/css">
      <xsl:text>
/* Global settings */
body {
  font-family: sans-serif;
  text-align: left;
  background: #fff;
  color: #333;
  margin: 1em;
  padding: 0;
  font-size: 1em;
  line-height: 1.2em
}

a:link { color: #22b; }
a:visited { color: #7e4988; }
a:hover, a:focus { color: #d30e08; }
a:active { color: #6b77b1;}

/* External links in italic font */
a.ulink { font-style: italic; }

/* Headers */
h1, h2, b, strong {
  color: #000;
  font-weight: bold;
}

h3, h4, h5, h6 {
  color: #222;
}

h1 { font-size: 173%; text-align: center; line-height: 1.2em; }
h2 { font-size: 144%; line-height: 1.2em; }
h2.subtitle { text-align: center; line-height: 1.2em; }
h3 { font-size: 120%; padding-top: 0.2em; margin-top: 0.3em; line-height: 1.2em; }
h4 { font-size: 110%; line-height: 1.2em;}
h5, h6 { font-size: 110%; font-style: italic; line-height: 1.2em; }

/* TOC and Index*/

div.toc ul, div.index ul, div.navheader ul, div.navfooter ul {
  list-style: none;
}

div.toc, div.dedication {
  padding-left: 1em;
}

li.preface, li.appendix {
  margin-left: 1em;
}

div.toc ul li h3, div.toc ul li h4 {
  margin: .4em;
}

.item {
    width: 17em;
    float: left;
}

.secitem {
    font-weight: normal;
    width: 16em;
    float: left;
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
  margin: 1.5em auto;
  color: #600;
  font-size: larger;
}

div.important h3, div.warning h3, div.caution h3 {
  color: #900;
}

h3.admontitle {
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

div.important tt, div.warning tt, div.caution tt {
  font-weight: bold;
}

div.important tt.literal, div.warning tt.literal, div.caution tt.literal {
  font-weight: normal;
}

/* variablelist and segmentedlist */
dl {
  margin: 0;
  padding: 0;
}

dt {
  display: list-item;
  font-weight: bold;
  margin: .33em 0 0 1em;
  padding: 0;
}

dd  {
  margin: 0 0 1em 3em;
  padding: 0;
}

table {
  width: auto;
  margin-left: 1em;
}

td {
  vertical-align: top;
}

td span, td p {
  margin: 0.3em;
}

span.term {
  display: block;
}

div.variablelist dd {
  margin-bottom: 1em;
}

div.variablelist dd p {
  margin-top: 0px;
  margin-bottom: 0px;
  padding-top: 0px;
  padding-bottom: 0px;
}

dl.materials dd {
  margin-left: 0px;
}

div.package div.seg {
  margin-bottom: 0em;
  margin-top: 0em;
  clear: left;
}

div.package span.segtitle, div.appendix span.segtitle {
  float: left;
}

div.package span.seg, div.appendix span.seg {
  display: block;
  padding-left: 14em;
}

div.appendix div.segmentedlist {
  padding-left: 1em;
}

div.appendix h3 {
  font-size: 133%;
  margin-top: 1em;
  margin-bottom: 0.2em;
}

div.content div.seg {
  margin-bottom: 1em;
  margin-top: 1em;
  clear: left;
}

div.content span.segtitle {
  float: left;
}

div.content span.seg {
  display: block;
  padding-left: 12em;
}

/* itemizedlist */

div.itemizedlist {
  margin-left: 1em;
}

ul[compact="compact"] {
  list-style: none;
}

ul[compact="compact"] li {
  margin: 0em;
  padding: 0em;
}

ul[compact="compact"] li p {
  padding: 0.3em;
  margin: 0em;
}

/*table */

div.table {
  text-align: center;
}

div.table table {
  margin-left: auto;
  margin-right: auto;
  text-align: center;
}

div.table table th, div.table table td {
  padding: 0.2em 2em 0.2em 2em;
}

/* Indented blocks */
p, ul, dl, code, blockquote {
  padding-left: 1em;
}

/* Monospaced elements */
tt, code, kbd, pre, .command {
  font-family: monospace;
}

tt.systemitem {
  font-style: italic;
}

pre.userinput {
  color: #101310;
  background-color: #e5e5e5;
  border: 1px solid #050505;
  padding: .5em 1em;
  margin: 0 2em;
  font-weight: bold;
}

.literal {
  font-weight: normal;
}

pre.screen {
  color: #000;
  background-color: #e9e9e9;
  border: 1px solid #050505;
  padding: .5em 1em;
  margin: 0 2em;
}

/* Sections */
div.wrap h2 {
  background: #f5f6f7;
  padding: 1em 0 0.5em 0;
  margin: 0px auto;
}

div.package {
  background: #f5f6f7;
  border-bottom: 0.2em solid #dbddec;
  padding: 0.5em 0.5em 0.3em 0.5em;
  margin: 0px auto;
}

div.installation {
  padding: 0 0.5em 0.3em 0.5em;
  margin: 0.5em 0 0.5em 0;
}

div.configuration {
  background:   #fefefe;
  border-top: 0.2em solid #dbddec;
  padding: 0.5em;
  margin: 0.5em 0 .5em 0;
}

div.content {
  background: #f5f6f7;
  border-top: 0.2em solid #dbddec;
  border-bottom: 0.2em solid #dbddec;
  padding: 0.5em 0.5em 1em 0.5em;
  margin: 0.5em 0 .5em 0;
}

div.installation h3.title, div.content h3.title {
  padding-top: 0.3em;
  margin: 0;
}

div.book, div.preface, div.part, div.chapter, div.sect1, div.appendix, div.index {
  padding-bottom: 0.5em;
}

div.preface h2, div.part h1, div.chapter h2, div.sect1 h2, div.appendix h2, div.index h1 {
  background: #f5f6f7;
  border-bottom: .2em solid #dbddec;
  border-top: .2em solid #dbddec;
  margin-top 1em;
  padding: .5em;
  text-align: center;
}

div.book h1 {
  background: #f5f6f7;
  margin: 0px auto;
  padding: 0.5em;
}

div.book h2.subtitle {
  background: #dbddec;
  margin: 0px auto;
  padding: 0.2em;
}
div.authorgroup, div p.copyright, div.abstract {
  background: #f5f6f7;
  margin: 0px auto;
  padding:  1em 0.5em;
}

hr {
  background: #dbddec;
  height: .3em;
  border: 0px;
  margin: 0px auto;
  padding: 0;
}
      </xsl:text>
    </style>
  </xsl:template>

</xsl:stylesheet>
