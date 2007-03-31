<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

   <!-- REVISED -->

  <!-- This stylesheet controls the h* xhtml tags used for several titles -->

    <!-- preface.titlepage:
           Uses h1 and removed a lot of unneeded code.
           No label in preface. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="preface.titlepage">
    <div class="titlepage">
      <h1 class="{name(.)}">
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- part.titlepage:
           Uses h1 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="part.titlepage">
    <div class="titlepage">
      <h1 class="{name(.)}">
        <xsl:apply-templates select="." mode="label.markup"/>
        <xsl:text>. </xsl:text>
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- appendix.titlepage:
           Uses h1 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="appendix.titlepage">
    <div class="titlepage">
      <h1 class="{name(.)}">
        <xsl:apply-templates select="." mode="label.markup"/>
        <xsl:text>. </xsl:text>
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- chapter.titlepage:
           Uses h1 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="chapter.titlepage">
    <div class="titlepage">
      <h1 class="{name(.)}">
        <xsl:apply-templates select="." mode="label.markup"/>
        <xsl:text>. </xsl:text>
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- sect1.titlepage:
           Uses h1 except for the first section, and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="sect1.titlepage">
    <xsl:choose>
        <!-- I should find a better test, but if chapter TOC is readded
             h1 will be used always, thus no need to worry for now. -->
      <xsl:when test="position() = 4">
        <div class="titlepage">
          <xsl:if test="@id">
            <a id="{@id}" name="{@id}"/>
          </xsl:if>
          <h2 class="{name(.)}">
            <xsl:apply-templates select="." mode="label.markup"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="title"/>
          </h2>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="titlepage">
          <h1 class="{name(.)}">
            <xsl:apply-templates select="." mode="label.markup"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="title"/>
          </h1>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- sect2.titlepage:
           Uses h2 and removed a lot of unneeded code.
           Skip empty titles.
           No label in preface. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="sect2.titlepage">
    <xsl:choose>
      <xsl:when test="string-length(title) = 0"/>
      <xsl:otherwise>
        <div class="titlepage">
          <xsl:if test="@id">
            <a id="{@id}" name="{@id}"/>
          </xsl:if>
          <h2 class="{name(.)}">
            <xsl:if test="not(ancestor::preface)">
              <xsl:apply-templates select="." mode="label.markup"/>
              <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:value-of select="title"/>
          </h2>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- bridgehead:
           When use always renderas attributes and want the output h* level
           matching the defined sect* level. -->
    <!-- The original template is in {docbook-xsl}/xhtml/sections.xsl -->
  <xsl:template match="bridgehead">
    <xsl:variable name="hlevel">
      <xsl:choose>
        <xsl:when test="@renderas = 'sect1'">1</xsl:when>
        <xsl:when test="@renderas = 'sect2'">2</xsl:when>
        <xsl:when test="@renderas = 'sect3'">3</xsl:when>
        <xsl:when test="@renderas = 'sect4'">4</xsl:when>
        <xsl:when test="@renderas = 'sect5'">5</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="h{$hlevel}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="anchor">
        <xsl:with-param name="conditional" select="0"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
