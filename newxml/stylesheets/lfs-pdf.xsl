<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <!-- We use FO and FOP as the processor -->
  <xsl:import href="/usr/share/xml/docbook/xsl-stylesheets-1.65.0/fo/docbook.xsl"/>
  <xsl:param name="fop.extensions" select="1"/>
  <xsl:param name="draft.mode" select="'no'"/>
  <!-- Probably want to make the paper size configurable -->
  <xsl:param name="paper.type" select="'A4'"/>

  <!--TOC stuff-->
  <xsl:param name="generate.toc">
    book      toc
    part      nop
  </xsl:param>
  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="generate.section.toc.level" select="-1"></xsl:param>
  <xsl:param name="toc.indent.width" select="18"></xsl:param>

  <!-- Force section1's onto a new page -->
  <xsl:attribute-set name="section.level1.properties">
    <xsl:attribute name="break-after">page</xsl:attribute>
  </xsl:attribute-set>

  <!-- Don't hyphenate -->
  <xsl:param name="hyphenate">false</xsl:param>
  <xsl:param name="alignment">left</xsl:param>

</xsl:stylesheet>
