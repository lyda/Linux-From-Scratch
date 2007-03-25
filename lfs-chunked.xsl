<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

   <!-- REVISED -->

    <!-- Our master non-chunking presentation templates -->
  <xsl:import href="lfs-chunked2.xsl"/>

    <!-- Upstream chunk code named templates -->
  <xsl:import href="docbook-xsl-snapshot/xhtml/chunk-common.xsl"/>

    <!-- Upstream chunk code match templates -->
  <xsl:include href="docbook-xsl-snapshot/xhtml/profile-chunk-code.xsl"/>

    <!-- Including our customized chunks templates -->
  <xsl:include href="xhtml/lfs-legalnotice.xsl"/>
  <xsl:include href="xhtml/lfs-index.xsl"/>
  <xsl:include href="xhtml/lfs-navigational.xsl"/>

</xsl:stylesheet>
