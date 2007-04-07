<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <!-- This stylesheet controls how sections are handled -->

    <!-- Chunk the first top-level section? 1 = yes, 0 = no
         If chapters TOC are generated, this must be 1.
         See also sect1.titlepage template in lfs-titles.xsl -->
  <xsl:param name="chunk.first.sections" select="1"></xsl:param>

    <!-- sect1:
           When there is a role attibute, use it as the class value.
           Removed unused code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/sections.xsl -->
  <xsl:template match="sect1">
    <div>
      <xsl:choose>
        <xsl:when test="@role">
          <xsl:attribute name="class">
            <xsl:value-of select="@role"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="class.attribute"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="language.attribute"/>
      <xsl:call-template name="sect1.titlepage"/>
      <xsl:apply-templates/>
      <xsl:call-template name="process.chunk.footnotes"/>
    </div>
  </xsl:template>

    <!-- sect2:
           When there is a role attibute, use it as the class value.
           Removed unused code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/sections.xsl -->
  <xsl:template match="sect2">
    <div>
      <xsl:choose>
        <xsl:when test="@role">
          <xsl:attribute name="class">
            <xsl:value-of select="@role"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">
            <xsl:value-of select="name(.)"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="language.attribute"/>
      <xsl:call-template name="sect2.titlepage"/>
      <xsl:apply-templates/>
      <xsl:call-template name="process.chunk.footnotes"/>
    </div>
  </xsl:template>

</xsl:stylesheet>
