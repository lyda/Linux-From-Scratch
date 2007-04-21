<?xml version='1.0' encoding='ISO-8859-1'?>

<!--
$LastChangedBy$
$Date$
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

    <!-- LFS top-level chunk templates. -->
  <xsl:import href="lfs-pdf.xsl"/>

    <!-- The LFS book type to be processed (lfs, blfs, clfs, or hlfs) -->
  <xsl:param name="book-type">blfs</xsl:param>

    <!-- Are sections enumerated? 1 = yes, 0 = no
           Note: Activating this will increase a lot rendering time. -->
  <xsl:param name="section.autolabel" select="0"/>

    <!-- Do section labels include the component label? 1 = yes, 0 = no -->
  <xsl:param name="section.label.includes.component.label" select="0"/>

</xsl:stylesheet>
