<?xml version='1.0' encoding='ISO-8859-1'?>

<!--
$LastChangedBy$
$Date$
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

    <!-- LFS top-level chunk templates. -->
  <xsl:import href="lfs-chunked.xsl"/>

    <!-- The LFS book type to be processed (lfs, blfs, clfs, or hlfs) -->
  <xsl:param name="book-type">blfs</xsl:param>

    <!-- The CSS Stylesheets. We set here relative path from sub-dirs HTML files.
    The path from top-level HTML files (index.html, partX.html, etc) MUST be
    fixed via a sed in the Makefile-->
    <!-- Master CSS Stylesheet -->
  <xsl:param name="html.stylesheet" select="'../stylesheets/blfs.css'"/>
    <!-- Print CSS Stylesheet -->
    <!-- The original template is in {docbook-xsl}/xhtml/docbook.xsl -->
  <xsl:template name='user.head.content'>
     <link rel="stylesheet" href="../stylesheets/blfs-print.css" type="text/css" media="print"/>
  </xsl:template>

    <!-- Are sections enumerated? 1 = yes, 0 = no -->
  <xsl:param name="section.autolabel" select="0"/>

    <!-- Do section labels include the component label? 1 = yes, 0 = no -->
  <xsl:param name="section.label.includes.component.label" select="0"/>

    <!-- Handle name and date in info section as a footnote -->

  <xsl:template name="process.footnotes">
    <xsl:variable name="footnotes" select=".//footnote"/>
    <xsl:variable name="fcount">
      <xsl:call-template name="count.footnotes.in.this.chunk">
        <xsl:with-param name="node" select="."/>
        <xsl:with-param name="footnotes" select="$footnotes"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- Only bother to do this if there's at least one non-table footnote -->
    <xsl:if test="$fcount &gt; 0">
      <div class="footnotes">
        <br/>
        <hr width="100" align="left"/>
        <xsl:call-template name="process.footnotes.in.this.chunk">
          <xsl:with-param name="node" select="."/>
          <xsl:with-param name="footnotes" select="$footnotes"/>
        </xsl:call-template>
      </div>
    </xsl:if>

    <!-- Add this to the footnotes -->
    <xsl:apply-templates select='prefaceinfo|chapterinfo|sect1info|./sect1[1]/sect1info' mode='attribution'/>
  </xsl:template>

  <xsl:template match='prefaceinfo|chapterinfo|sect1info' mode='attribution'>
    <p class='updated'> Last updated <!-- by
      <xsl:apply-templates select="othername" mode='attribution'/> -->
      on
      <xsl:apply-templates select="date" mode='attribution'/>
    </p>
  </xsl:template>

  <xsl:template match='othername' mode='attribution'>
     <xsl:variable name='author'>
          <xsl:value-of select='.'/>
     </xsl:variable>
     <xsl:variable name='nameonly'>
          <xsl:value-of select='substring($author,16)'/>
     </xsl:variable>
     <xsl:value-of select="substring-before($nameonly,'$')" />
  </xsl:template>

  <xsl:template match='date' mode='attribution'>
      <xsl:variable name='date'>
         <xsl:value-of select='.'/>
      </xsl:variable>
      <xsl:value-of select="substring($date,7,26)" />
  </xsl:template>

</xsl:stylesheet>
