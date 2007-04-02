<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

   <!-- Stylesheet for FO output used to generate PDF -->

    <!-- Upstream FO templates. Profiled version is not supported by
         xsltproc, thus pofiling must be done in two steps (see Makefile) -->
  <xsl:import href="docbook-xsl-snapshot/fo/docbook.xsl"/>

    <!-- Including our others customized templates -->
  <xsl:include href="pdf/lfs-admon.xsl"/>
  <xsl:include href="pdf/lfs-index.xsl"/>
  <xsl:include href="pdf/lfs-mixed.xsl"/>
  <xsl:include href="pdf/lfs-pagesetup.xsl"/>
  <xsl:include href="pdf/lfs-sections.xsl"/>
  <xsl:include href="pdf/lfs-xref.xsl"/>

    <!-- Activating FOP-1 extensions. We use FOP-0.93 as the FO procesor. -->
  <xsl:param name="fop1.extensions" select="1"/>

    <!-- This file contains our localization strings (for internationalization) -->
  <xsl:param name="local.l10n.xml" select="document('lfs-l10n.xml')"/>

    <!-- Desactivate draft mode at all. -->
  <xsl:param name="draft.mode" select="'no'"/>

   <!-- Paper size -->
  <xsl:param name="paper.type" select="'USletter'"/>

    <!-- Paper size required by the publisher
  <xsl:param name="paper.type" select="'Customized'"/>
  <xsl:param name="page.width">7.25in</xsl:param>
  <xsl:param name="page.height">9.25in</xsl:param>
    -->

    <!-- Is the document to be printed double sided? 1 = yes, 0 = no -->
    <!-- Change "double.sided" to "1" for published versions -->
  <xsl:param name="double.sided" select="0"/>

    <!-- Hyphenate? -->
  <xsl:param name="hyphenate">false</xsl:param>

    <!-- Specify the default text alignment -->
  <xsl:param name="">justify</xsl:param>

    <!-- Specifies the default point size for body text.
         Used for titles size calculation. -->
  <xsl:param name="body.font.master">9</xsl:param>

    <!-- Specifies the default font size for body text -->
  <xsl:param name="body.font.size">12pt</xsl:param>

    <!-- Control generation of ToCs and LoTs -->
  <xsl:param name="generate.toc">
    book      toc
    part      nop
  </xsl:param>

    <!-- How deep should recursive sections appear in the TOC? -->
  <xsl:param name="toc.section.depth">1</xsl:param>

    <!-- Amount of indentation for TOC entries -->
  <xsl:param name="toc.indent.width" select="18"></xsl:param>

    <!-- Turns page numbers in xrefs on and off -->
  <xsl:param name="insert.xref.page.number">no</xsl:param>

    <!-- Display URLs after ulinks? 1 = yes, 0 = no
         Set to 0 tp prevent duplicate e-mails in the Acknowledgments pages -->
  <xsl:param name="ulink.show" select="0"/>

</xsl:stylesheet>
