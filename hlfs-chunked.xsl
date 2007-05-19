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
  <xsl:param name="book-type">hlfs</xsl:param>

    <!-- List of strings used inside @role attributes for additional features.
         The list must start and end with a "," -->
  <xsl:param name="hlfs-features">,ssp,aslr,pax,hardened_tmp,warnings,misc,blowfish,</xsl:param>

</xsl:stylesheet>
