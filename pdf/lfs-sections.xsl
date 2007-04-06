<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

   <!-- REVISED -->

  <!-- This stylesheet controls how sections are handled -->

    <!-- Are sections enumerated? 1 = yes, 0 = no -->
  <xsl:param name="section.autolabel" select="1"/>

    <!-- Do section labels include the component label? 1 = yes, 0 = no -->
  <xsl:param name="section.label.includes.component.label" select="1"/>

     <!-- Force sect1 onto a new page -->
  <xsl:attribute-set name="section.level1.properties">
    <xsl:attribute name="break-after">
      <xsl:choose>
        <xsl:when test="not(position()=last())">
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

    <!-- sect2 label.markup:
           Skip numeration for sect2 with empty title -->
    <!-- The original template is in {docbook-xsl}/common/labels.xsl
         It match also sect3, sect4, and sect5, that are unchanged. -->
  <xsl:template match="sect2" mode="label.markup">
    <xsl:if test="string-length(title) > 0">
      <!-- label the parent -->
      <xsl:variable name="parent.section.label">
        <xsl:call-template name="label.this.section">
          <xsl:with-param name="section" select=".."/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$parent.section.label != '0'">
        <xsl:apply-templates select=".." mode="label.markup"/>
        <xsl:apply-templates select=".." mode="intralabel.punctuation"/>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@label">
          <xsl:value-of select="@label"/>
        </xsl:when>
        <xsl:when test="$section.autolabel != 0">
          <xsl:choose>
            <!-- If the first sect2 isn't numbered, renumber the remainig sections -->
            <xsl:when test="string-length(../sect2[1]/title) = 0">
              <xsl:variable name="totalsect2">
                <xsl:number count="sect2"/>
              </xsl:variable>
              <xsl:number value="$totalsect2 - 1"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:number count="sect2"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>label.markup: this can't happen!</xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
