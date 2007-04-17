<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <!-- This stylesheet controls how sections are handled -->

    <!-- Chunk the first top-level section? 1 = yes, 0 = no
         If chapters TOC are generated, this must be 1. -->
  <xsl:param name="chunk.first.sections" select="1"/>

    <!-- sect1:
           When there is a role attibute, use it as the class value.
           Process the SVN keywords found in sect1info as a footnote.
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
      <xsl:apply-templates select="sect1info" mode="svn-keys"/>
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
    </div>
  </xsl:template>

    <!-- sect1info mode svn-keys:
           Self-made template to process SVN keywords found in sect1info. -->
  <xsl:template match="sect1info" mode="svn-keys">
    <p class="updated">Last updated <!-- by
      <xsl:apply-templates select="othername" mode="svn-keys"/> -->
      on
      <xsl:apply-templates select="date" mode="svn-keys"/>
    </p>
  </xsl:template>

    <!-- othername mode svn-keys:
           Self-made template to process the $LastChangedBy SVN keyword. -->
  <xsl:template match="othername" mode="svn-keys">
    <xsl:variable name="author">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:variable name="nameonly">
      <xsl:value-of select="substring($author,16)"/>
    </xsl:variable>
    <xsl:value-of select="substring-before($nameonly,'$')"/>
  </xsl:template>

    <!-- date mode svn-keys:
           Self-made template to process the $Date SVN keyword. -->
  <xsl:template match="date" mode="svn-keys">
    <xsl:variable name="date">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:value-of select="substring($date,7,26)"/>
  </xsl:template>

</xsl:stylesheet>
