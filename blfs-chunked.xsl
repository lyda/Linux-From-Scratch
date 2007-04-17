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
     <link rel="stylesheet" href="../stylesheets/blfs-print.css" type="text/css"
           media="print"/>
  </xsl:template>

    <!-- Are sections enumerated? 1 = yes, 0 = no
           Note: Activating this will increase a lot rendering time. -->
  <xsl:param name="section.autolabel" select="0"/>

    <!-- Do section labels include the component label? 1 = yes, 0 = no -->
  <xsl:param name="section.label.includes.component.label" select="0"/>

</xsl:stylesheet>
