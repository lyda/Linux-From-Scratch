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

<!-- remove the colspan attribute from the tr elements -->
<xsl:template match="qandadiv">
  <xsl:variable name="preamble" select="*[name(.) != 'title'
                                          and name(.) != 'titleabbrev'
                                          and name(.) != 'qandadiv'
                                          and name(.) != 'qandaentry']"/>

  <xsl:if test="title">
    <tr class="qandadiv">
      <td align="left" valign="top" colspan="2">
        <xsl:call-template name="anchor">
          <xsl:with-param name="conditional" select="0"/>
        </xsl:call-template>
        <xsl:apply-templates select="title"/>
      </td>
    </tr>
  </xsl:if>

  <xsl:variable name="toc.params">
    <xsl:call-template name="find.path.params">
      <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:if test="contains($toc.params, 'toc')">
    <tr class="toc">
      <td align="left" valign="top" colspan="2">
        <xsl:call-template name="process.qanda.toc"/>
      </td>
    </tr>
  </xsl:if>
  <xsl:if test="$preamble">
    <tr class="toc">
      <td align="left" valign="top" colspan="2">
        <xsl:apply-templates select="$preamble"/>
      </td>
    </tr>
  </xsl:if>
  <xsl:apply-templates select="qandadiv|qandaentry"/>
</xsl:template>

</xsl:stylesheet>
