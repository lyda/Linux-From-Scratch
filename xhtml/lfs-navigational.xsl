<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <!-- This stylesheet controls how page header and navigational links
       are generated. -->

    <!-- html.head:
           Drop all navigational links from inside head xhtml output. -->
    <!-- The original template is in {docbook-xsl}/xhtml/chunk-common.xsl -->
  <xsl:template name="html.head">
    <head>
      <xsl:call-template name="system.head.content"/>
      <xsl:call-template name="head.content"/>
      <xsl:call-template name="user.head.content"/>
    </head>
  </xsl:template>

    <!-- header.navigation:
           Self-made template that full replaces the original one -->
    <!-- The original template is in {docbook-xsl}/xhtml/chunk-common.xsl -->
  <xsl:template name="header.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:variable name="up" select="parent::*"/>
    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="row" select="count($prev) &gt; 0 or (count($up) &gt; 0
            and generate-id($up) != generate-id($home)) or count($next) &gt; 0"/>
      <!-- Don't generate the header in index.html -->
    <xsl:if test="$row and $home != .">
      <div class="navheader">
          <!-- Add common titles -->
        <div class="headertitles">
           <!-- Book title and version -->
          <h4>
            <xsl:apply-templates select="$home" mode="object.title.markup"/>
            <xsl:text> - </xsl:text>
            <xsl:apply-templates select="$home" mode="object.subtitle.markup"/>
          </h4>
            <!-- Except for preface, part, and index, add the title of the parent -->
          <xsl:if test="$up != $home">
            <h3>
              <xsl:apply-templates select="$up" mode="object.title.markup"/>
            </h3>
          </xsl:if>
        </div>
          <!-- Create header navigational links -->
        <xsl:call-template name="navigational.links">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="up" select="$up"/>
          <xsl:with-param name="home" select="$home"/>
        </xsl:call-template>
      </div>
    </xsl:if>
  </xsl:template>

    <!-- footer.navigation:
           Self-made template that full replaces the original one -->
    <!-- The original template is in {docbook-xsl}/xhtml/chunk-common.xsl -->
  <xsl:template name="footer.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:variable name="up" select="parent::*"/>
    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="row" select="count($prev) &gt; 0 or count($up) &gt; 0
            or count($next) &gt; 0 or generate-id($home) != generate-id(.)"/>
    <xsl:if test="$row">
      <div class="navfooter">
          <!-- Create footer navigational links -->
        <xsl:call-template name="navigational.links">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="up" select="$up"/>
          <xsl:with-param name="home" select="$home"/>
        </xsl:call-template>
      </div>
    </xsl:if>
  </xsl:template>

    <!-- navigational.links:
           Self-made template to generate navigational links.
           Most of the code come from the original header.navigation and
           footer.navigation templates, with this changes:
             Changed the output format from table to ul.
             Placed the same links on both header and footer.
             Added a title attribute to the link containing the target title
               (it content is displayed when placing the mouse over the link)
             For "Prev" and "Next" links, added the target title under it.
             When "Next" target is the Index, added gentext support for the
               Index title.
             Skip links to dummy sect1. -->
  <xsl:template name="navigational.links">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="up"/>
    <xsl:param name="home"/>
    <ul>
      <xsl:if test="count($prev)&gt;0 and $prev != $home">
        <li class="prev">
          <xsl:choose>
            <xsl:when test="$prev[@role='dummy'] and
                            count(preceding-sibling::sect1)=1">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select=".."/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="../title"/>
                </xsl:attribute>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'prev'"/>
                </xsl:call-template>
              </a>
              <p>
                <xsl:value-of select="../title"/>
              </p>
            </xsl:when>
            <xsl:when test="$prev[@role='dummy'] and
                            count(preceding-sibling::sect1)&gt;1">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="preceding-sibling::sect1[position()=2]"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="preceding-sibling::sect1[position()=2]/title"/>
                </xsl:attribute>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'prev'"/>
                </xsl:call-template>
              </a>
              <p>
                <xsl:value-of select="preceding-sibling::sect1[position()=2]/title"/>
              </p>
            </xsl:when>
            <xsl:otherwise>
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="$prev/title"/>
                </xsl:attribute>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'prev'"/>
                </xsl:call-template>
              </a>
              <p>
                <xsl:value-of select="$prev/title"/>
              </p>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </xsl:if>
      <xsl:if test="count($next)&gt;0">
        <li class="next">
          <xsl:choose>
            <xsl:when test="$next[@role='dummy'] and local-name(.) = 'sect1'">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="following-sibling::sect1[position()=2]"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="following-sibling::sect1[position()=2]/title"/>
                </xsl:attribute>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'next'"/>
                </xsl:call-template>
              </a>
              <p>
                <xsl:value-of select="following-sibling::sect1[position()=2]/title"/>
              </p>
            </xsl:when>
            <xsl:when test="$next[@role='dummy'] and local-name(.) = 'chapter'">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="descendant::sect1[position()=2]"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="descendant::sect1[position()=2]/title"/>
                </xsl:attribute>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'next'"/>
                </xsl:call-template>
              </a>
              <p>
                <xsl:value-of select="descendant::sect1[position()=2]/title"/>
              </p>
            </xsl:when>
            <xsl:otherwise>
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:choose>
                    <xsl:when test="local-name($next)='index'">
                      <xsl:call-template name="gentext">
                        <xsl:with-param name="key">Index</xsl:with-param>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$next/title"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'next'"/>
                </xsl:call-template>
              </a>
              <p>
                <xsl:choose>
                  <xsl:when test="local-name($next)='index'">
                    <xsl:call-template name="gentext">
                      <xsl:with-param name="key">Index</xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$next/title"/>
                  </xsl:otherwise>
                </xsl:choose>
              </p>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </xsl:if>
      <li class="up">
        <xsl:choose>
          <xsl:when test="count($up)&gt;0 and $up != $home">
            <a accesskey="u">
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$up"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:attribute name="title">
                <xsl:apply-templates select="$up" mode="object.title.markup"/>
              </xsl:attribute>
              <xsl:call-template name="navig.content">
                <xsl:with-param name="direction" select="'up'"/>
              </xsl:call-template>
            </a>
          </xsl:when>
            <!-- Hack to let the CSS code do its work when there is no up link -->
          <xsl:otherwise>
            <xsl:text>.</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </li>
      <li class="home">
        <xsl:choose>
          <xsl:when test="$home != .">
            <a accesskey="h">
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$home"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:attribute name="title">
                <xsl:value-of select="$home/bookinfo/title"/>
                <xsl:text> - </xsl:text>
                <xsl:value-of select="$home/bookinfo/subtitle"/>
              </xsl:attribute>
              <xsl:call-template name="navig.content">
                <xsl:with-param name="direction" select="'home'"/>
              </xsl:call-template>
            </a>
          </xsl:when>
            <!-- Hack to let the CSS code do its work when there is no home link -->
          <xsl:otherwise>
            <xsl:text>.</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </li>
    </ul>
  </xsl:template>

</xsl:stylesheet>
