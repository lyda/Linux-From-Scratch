<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:import href="/usr/share/xml/docbook/xsl-stylesheets-1.64.1/xhtml/chunk.xsl"/>

  <xsl:param name="html.stylesheet" select="'../stylesheets/lfs.css'"/>
  <xsl:param name="generate.legalnotice.link" select="1"/>

  <xsl:param name="generate.toc">
    appendix  toc
    book      toc,title,figure,table,example,equation
    chapter   nop
    part      toc
    preface   nop
    qandadiv  nop
    qandaset  nop  
    reference nop
    sect1     nop
    sect2     nop
    sect3     nop
    sect4     nop
    sect5     nop
    section   nop
    set       nop
  </xsl:param>
  <xsl:param name="toc.section.depth">3</xsl:param>
  <xsl:param name="toc.max.depth">3</xsl:param>
</xsl:stylesheet>
