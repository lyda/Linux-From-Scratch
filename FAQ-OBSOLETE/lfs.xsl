<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:import href="file:///usr/share/xsl/docbook/html/docbook.xsl"/>

<!-- override the xsl:output element to include a version attribute
     so it generates a doctype declaration -->
<xsl:output method="html"
            version="4.01"
            encoding="ISO-8859-1"
            indent="no"/>

</xsl:stylesheet>
