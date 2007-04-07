<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

  <!-- This stylesheet controls page margins, header content and titles size. -->

    <!-- The inner page margin. -->
  <xsl:param name="page.margin.inner" select="'0.5in'"/>

    <!-- The outer page margin. -->
  <xsl:param name="page.margin.outer" select="'0.375in'"/>

    <!-- The bottom margin of the page. -->
  <xsl:param name="page.margin.bottom" select="'0.375in'"/>

    <!-- The top margin of the page. -->
  <xsl:param name="page.margin.top" select="'0.375in'"/>

    <!-- The bottom margin of the body text. -->
  <xsl:param name="body.margin.bottom" select="'0.4in'"/>

    <!-- The top margin of the body text. -->
  <xsl:param name="body.margin.top" select="'0.4in'"/>

    <!-- Specifies the height of the header. -->
  <xsl:param name="region.before.extent" select="'0.25in'"/>

    <!-- Specifies the height of the footer. -->
  <xsl:param name="region.after.extent" select="'0.25in'"/>

    <!-- The start-indent for the body text. -->
  <xsl:param name="body.start.indent" select="'0pc'"/>

    <!-- Adjust the left margin for titles. -->
  <xsl:param name="title.margin.left">-0.8pc</xsl:param>

    <!-- Rule under headers? 1 =yes, 0 = no -->
  <xsl:param name="header.rule" select="0"/>

    <!-- Rule over footers? 1 =yes, 0 = no -->
  <xsl:param name="footer.rule" select="0"></xsl:param>

    <!-- Control depth of sections shown in running headers or footers.
         Be sure that no uneeded fo:marker are generated. -->
  <xsl:param name="marker.section.level" select="-1"></xsl:param>

    <!-- Dropping a blank page after book title. -->
  <xsl:template name="book.titlepage.separator"/>

    <!-- book title:
          Centered the title and removed unused code. -->
    <!-- The original template is in {docbook-xsl}/fo/titlepage.templates.xsl -->
  <xsl:template name="book.titlepage">
    <fo:block margin-top="3in">
      <fo:block>
        <xsl:call-template name="book.titlepage.before.recto"/>
        <xsl:call-template name="book.titlepage.recto"/>
      </fo:block>
      <fo:block>
        <xsl:call-template name="book.titlepage.before.verso"/>
        <xsl:call-template name="book.titlepage.verso"/>
      </fo:block>
      <xsl:call-template name="book.titlepage.separator"/>
    </fo:block>
  </xsl:template>

    <!-- book title:
           Drop a blank page after book title. -->
    <!-- The original template is in {docbook-xsl}/fo/titlepage.templates.xsl -->
  <xsl:template name="book.titlepage.separator"/>

    <!-- part title:
          Centered the title and removed unused code. -->
    <!-- The original template is in {docbook-xsl}/fo/titlepage.templates.xsl -->
  <xsl:template name="part.titlepage">
    <fo:block>
      <fo:block margin-top="3.5in">
        <xsl:call-template name="part.titlepage.before.recto"/>
        <xsl:call-template name="part.titlepage.recto"/>
      </fo:block>
      <fo:block>
        <xsl:call-template name="part.titlepage.before.verso"/>
        <xsl:call-template name="part.titlepage.verso"/>
      </fo:block>
      <xsl:call-template name="part.titlepage.separator"/>
    </fo:block>
  </xsl:template>

    <!-- chapter title:
          Small font size and left alignament. -->
    <!-- The original template is in {docbook-xsl}/fo/titlepage.templates.xsl -->
  <xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
    <fo:block xsl:use-attribute-sets="chapter.titlepage.recto.style"
              font-size="21pt" font-weight="bold" text-align="left">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

   <!-- header.table:
          Re-made template to not generate a fo:table in the header,
          allowing a more simple header.content custonization. -->
    <!-- The original template is in {docbook-xsl}/fo/pagesetup.xsl -->
  <xsl:template name="header.table">
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="gentext-key" select="''"/>
    <xsl:choose>
      <xsl:when test="$gentext-key = 'book' or $sequence = 'blank'"/>
      <xsl:otherwise>
        <xsl:call-template name="header.content">
          <xsl:with-param name="sequence" select="$sequence"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- header.content
           Re-made template to show the book title and version on all pages. -->
    <!-- The original template is in {docbook-xsl}/fo/pagesetup.xsl -->
  <xsl:template name="header.content">
    <xsl:param name="sequence" select="''"/>
    <fo:block>
      <xsl:attribute name="text-align">
        <xsl:choose>
          <xsl:when test="$sequence = 'first' or $sequence = 'odd'">right</xsl:when>
          <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="/book/bookinfo/title"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="/book/bookinfo/subtitle"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
