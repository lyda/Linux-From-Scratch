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

    <!-- Are sections enumerated? 1 = yes, 0 = no -->
  <xsl:param name="section.autolabel" select="1"/>

    <!-- Do section labels include the component label? 1 = yes, 0 = no -->
  <xsl:param name="section.label.includes.component.label" select="1"/>

    <!-- sect1 label.markup:
           Use lowercase roman numbers for sect1 in preface. -->
    <!-- The original template is in {docbook-xsl}/common/labels.xsl -->
  <xsl:template match="sect1" mode="label.markup">
    <!-- if the parent is a component, maybe label that too -->
    <xsl:variable name="parent.is.component">
      <xsl:call-template name="is.component">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="component.label">
      <xsl:if test="$section.label.includes.component.label != 0
                    and $parent.is.component != 0">
        <xsl:variable name="parent.label">
          <xsl:apply-templates select=".." mode="label.markup"/>
        </xsl:variable>
        <xsl:if test="$parent.label != ''">
          <xsl:apply-templates select=".." mode="label.markup"/>
          <xsl:apply-templates select=".." mode="intralabel.punctuation"/>
        </xsl:if>
      </xsl:if>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@label">
        <xsl:value-of select="@label"/>
      </xsl:when>
      <xsl:when test="$section.autolabel != 0">
        <xsl:copy-of select="$component.label"/>
        <xsl:choose>
          <xsl:when test="ancestor::preface">
            <xsl:number format="i" count="sect1"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:number format="1" count="sect1"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
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