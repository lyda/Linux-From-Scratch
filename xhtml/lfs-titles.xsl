<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <!-- This stylesheet controls the h* xhtml tags used for several titles -->

    <!-- preface.titlepage:
           Uses h1 and removed a lot of unneeded code.
           No label in preface. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="preface.titlepage">
    <div class="titlepage">
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <h1 class="{name(.)}">
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- part.titlepage:
           Uses h1 and removed a lot of unneeded code.
           When sections are not labeled, we want the part label in TOC
           but not in titlepage. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="part.titlepage">
    <div class="titlepage">
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <h1 class="{name(.)}">
        <xsl:if test="$section.autolabel != 0">
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- partintro.titlepage:
           Uses h2 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="partintro.titlepage">
    <xsl:if test="title">
      <div class="partintrotitle">
        <xsl:if test="@id">
          <a id="{@id}" name="{@id}"/>
        </xsl:if>
        <h2 class="{name(.)}">
          <xsl:value-of select="title"/>
        </h2>
      </div>
    </xsl:if>
  </xsl:template>

    <!-- appendix.titlepage:
           Uses h1 and removed a lot of unneeded code.
           When sections are not labeled, we want the appendix label in TOC
           but not in titlepage. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="appendix.titlepage">
    <div class="titlepage">
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <h1 class="{name(.)}">
        <xsl:if test="$section.autolabel != 0">
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- chapter.titlepage:
           Uses h1 and removed a lot of unneeded code.
           When sections are not labeled, we want the chapter label in TOC
           but not in titlepage. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="chapter.titlepage">
    <div class="titlepage">
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <h1 class="{name(.)}">
        <xsl:if test="$section.autolabel != 0">
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="title"/>
      </h1>
    </div>
  </xsl:template>

    <!-- sect1.titlepage:
           Uses h1 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="sect1.titlepage">
    <div class="titlepage">
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <h1 class="{name(.)}">
        <xsl:if test="$section.autolabel != 0">
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="title"/>
      </h1>
    </div>
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
            <xsl:if test="not(ancestor::preface) and $section.autolabel != 0">
              <xsl:apply-templates select="." mode="label.markup"/>
              <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:value-of select="title"/>
          </h2>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- sect3.titlepage:
           Uses h3 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="sect3.titlepage">
    <div class="titlepage">
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <h3 class="{name(.)}">
        <xsl:if test="$section.autolabel != 0">
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="title"/>
      </h3>
    </div>
  </xsl:template>

    <!-- dedication.titlepage:
           Uses h2 and removed a lot of unneeded code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/titlepage.templates.xsl -->
  <xsl:template name="dedication.titlepage">
    <div class="titlepage">
      <h2 class="{name(.)}">
        <xsl:value-of select="title"/>
      </h2>
    </div>
  </xsl:template>

    <!-- bridgehead:
           When use always renderas attributes and want the output h* level
           matching the defined sect* level.
           Create the anchor only if there is an @id. -->
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
      <xsl:if test="@id">
        <a id="{@id}" name="{@id}"/>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
