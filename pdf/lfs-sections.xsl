<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

  <!-- This stylesheet controls how sections are handled -->

     <!-- Force sect1 onto a new page -->
  <xsl:attribute-set name="section.level1.properties">
    <xsl:attribute name="break-before">
      <xsl:choose>
        <xsl:when test="not(. = //*/sect1[1])">
          <xsl:text>page</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>auto</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

    <!-- sect2:
           Skip sect2.titlepage run when title is empty.
           Removed unused code. -->
    <!-- The original template is in {docbook-xsl}/fo/sections.xsl -->
  <xsl:template match="sect2">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <fo:block xsl:use-attribute-sets="section.level2.properties">
      <xsl:attribute name="id">
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:if test="not(string-length(title)=0)">
        <xsl:call-template name="sect2.titlepage"/>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
