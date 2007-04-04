<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">


  <!-- This stylesheet contains misc params, attribute sets and templates
       for output formating.
       This file is for that templates that don't fit in other files. -->

    <!-- What space do you want between normal paragraphs. -->
  <xsl:attribute-set name="normal.para.spacing">
    <xsl:attribute name="space-before.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.8em</xsl:attribute>
    <xsl:attribute name="orphans">2</xsl:attribute>
    <xsl:attribute name="widows">2</xsl:attribute>
  </xsl:attribute-set>

    <!-- Properties associated with verbatim text. -->
  <xsl:attribute-set name="verbatim.properties">
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
    <xsl:attribute name="keep-with-previous.within-column">always</xsl:attribute>
    <xsl:attribute name="space-before.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.8em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
    <xsl:attribute name="white-space-collapse">false</xsl:attribute>
    <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
  </xsl:attribute-set>

    <!-- Should verbatim environments be shaded? 1 =yes, 0 = no -->
  <xsl:param name="shade.verbatim" select="1"/>

    <!-- Properties that specify the style of shaded verbatim listings -->
  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="background-color">#E9E9E9</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-width">1pt</xsl:attribute>
    <xsl:attribute name="border-color">#050505</xsl:attribute>
    <xsl:attribute name="padding-start">5pt</xsl:attribute>
    <xsl:attribute name="padding-top">2pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
  </xsl:attribute-set>

    <!-- para:
           Skip empty "Home page" in packages.xml.
           Allow forced line breaks inside paragraphs emulating literallayout.
           Removed vertical space in pakages and patches pages. -->
    <!-- The original template is in {docbook-xsl}/fo/block.xsl -->
 <xsl:template match="para">
    <xsl:choose>
      <xsl:when test="child::ulink[@url=' ']"/>
      <xsl:when test="./@remap='verbatim'">
        <fo:block xsl:use-attribute-sets="verbatim.properties">
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:when>
      <xsl:when test="ancestor::variablelist/@role = 'materials'">
        <fo:block>
          <xsl:attribute name="space-before.optimum">0.1em</xsl:attribute>
          <xsl:attribute name="space-before.minimum">0em</xsl:attribute>
          <xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="normal.para.spacing">
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- literal:
           Be sure that literal will use allways normal font weight. -->
    <!-- The original template is in {docbook-xsl}/fo/inline.xsl -->
  <xsl:template match="literal">
    <fo:inline  font-weight="normal">
      <xsl:call-template name="inline.monoseq"/>
    </fo:inline>
  </xsl:template>

    <!-- Show URLs in italic font -->
  <xsl:template match="ulink" name="ulink">
    <fo:inline font-style="italic">
      <fo:basic-link xsl:use-attribute-sets="xref.properties">
        <xsl:attribute name="external-destination">
          <xsl:call-template name="fo-external-image">
            <xsl:with-param name="filename" select="@url"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="count(child::node())=0">
            <xsl:call-template name="hyphenate-url">
              <xsl:with-param name="url" select="@url"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:basic-link>
    </fo:inline>
    <xsl:if test="count(child::node()) != 0
                  and string(.) != @url
                  and $ulink.show != 0">
      <!-- yes, show the URI -->
      <xsl:choose>
        <xsl:when test="$ulink.footnotes != 0 and not(ancestor::footnote)">
          <xsl:text>&#xA0;</xsl:text>
          <fo:footnote>
            <xsl:call-template name="ulink.footnote.number"/>
            <fo:footnote-body font-family="{$body.fontset}"
                              font-size="{$footnote.font.size}">
              <fo:block>
                <xsl:call-template name="ulink.footnote.number"/>
                <xsl:text> </xsl:text>
                <fo:inline>
                  <xsl:value-of select="@url"/>
                </fo:inline>
              </fo:block>
            </fo:footnote-body>
          </fo:footnote>
        </xsl:when>
        <xsl:otherwise>
          <fo:inline hyphenate="false">
            <xsl:text> [</xsl:text>
            <xsl:call-template name="hyphenate-url">
              <xsl:with-param name="url" select="@url"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
          </fo:inline>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

    <!-- How is rendered by default a variablelist -->
  <xsl:param name="variablelist.as.blocks" select="1"/>
  <xsl:param name="variablelist.max.termlength">32</xsl:param>

    <!-- Adding space before segmentedlist -->
  <xsl:template match="segmentedlist">
    <!--<xsl:variable name="presentation">
      <xsl:call-template name="pi-attribute">
        <xsl:with-param name="pis"
                        select="processing-instruction('dbfo')"/>
        <xsl:with-param name="attribute" select="'list-presentation'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$presentation = 'table'">
        <xsl:apply-templates select="." mode="seglist-table"/>
      </xsl:when>
      <xsl:when test="$presentation = 'list'">
        <fo:block space-before.minimum="0.4em" space-before.optimum="0.6em"
                space-before.maximum="0.8em">
          <xsl:apply-templates/>
        </fo:block>
      </xsl:when>
      <xsl:when test="$segmentedlist.as.table != 0">
        <xsl:apply-templates select="." mode="seglist-table"/>
      </xsl:when>
      <xsl:otherwise>-->
        <fo:block space-before.minimum="0.4em" space-before.optimum="0.6em"
                space-before.maximum="0.8em">
          <xsl:apply-templates/>
        </fo:block>
      <!--</xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>

    <!-- Left alingnament for itemizedlist -->
  <xsl:template match="itemizedlist">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <xsl:variable name="label-width">
      <xsl:call-template name="dbfo-attribute">
        <xsl:with-param name="pis"
                        select="processing-instruction('dbfo')"/>
        <xsl:with-param name="attribute" select="'label-width'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="title">
      <xsl:apply-templates select="title" mode="list.title.mode"/>
    </xsl:if>
    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates
        select="*[not(self::listitem
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::listitem)]
                |processing-instruction()[not(preceding-sibling::listitem)]"/>
    <fo:list-block id="{$id}" xsl:use-attribute-sets="list.block.spacing"
                  provisional-label-separation="0.2em" text-align="left">
      <xsl:attribute name="provisional-distance-between-starts">
        <xsl:choose>
          <xsl:when test="$label-width != ''">
            <xsl:value-of select="$label-width"/>
          </xsl:when>
          <xsl:otherwise>1.5em</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates
            select="listitem
                    |comment()[preceding-sibling::listitem]
                    |processing-instruction()[preceding-sibling::listitem]"/>
    </fo:list-block>
  </xsl:template>

    <!-- Addibg a bullet, and left alignament, for packages and paches list. -->

  <xsl:template match="varlistentry" mode="vl.as.blocks">
    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="ancestor::variablelist/@role = 'materials'">
        <fo:block id="{$id}" xsl:use-attribute-sets="list.item.spacing"
            keep-together.within-column="always"
            keep-with-next.within-column="always" text-align="left">
          <xsl:text>&#x2022;   </xsl:text>
          <xsl:apply-templates select="term"/>
        </fo:block>
        <fo:block margin-left="1.4pc" text-align="left">
          <xsl:apply-templates select="listitem"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block id="{$id}" xsl:use-attribute-sets="list.item.spacing"
            keep-together.within-column="always"
            keep-with-next.within-column="always">
          <xsl:apply-templates select="term"/>
        </fo:block>
        <fo:block margin-left="0.25in">
          <xsl:apply-templates select="listitem"/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- Total packages size calculation -->

    <!-- returnvalue:
            If the tag is not empty, apply the original template.
            Otherwise apply the calculation template. -->
    <!-- The original template is in {docbook-xsl}/fo/inline.xsl -->
  <xsl:template match="returnvalue">
    <xsl:choose>
      <xsl:when test="count(*)&gt;0">
        <xsl:apply-imports/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="calculation">
          <xsl:with-param name="scope" select="../../variablelist"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="calculation">
    <xsl:param name="scope"/>
    <xsl:param name="total">0</xsl:param>
    <xsl:param name="position">1</xsl:param>
    <xsl:variable name="tokens" select="count($scope/varlistentry)"/>
    <xsl:variable name="token" select="$scope/varlistentry[$position]/term/token"/>
    <xsl:variable name="size" select="substring-before($token,' KB')"/>
    <xsl:variable name="rawsize">
      <xsl:choose>
        <xsl:when test="contains($size,',')">
          <xsl:value-of select="concat(substring-before($size,','),substring-after($size,','))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$size"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$position &lt;= $tokens">
        <xsl:call-template name="calculation">
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="position" select="$position +1"/>
          <xsl:with-param name="total" select="$total + $rawsize"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$total &lt; '1000'">
            <xsl:value-of select="$total"/>
            <xsl:text>  KB</xsl:text>
          </xsl:when>
          <xsl:when test="$total &gt; '1000' and $total &lt; '5000'">
            <xsl:value-of select="substring($total,1,1)"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="substring($total,2)"/>
            <xsl:text>  KB</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="round($total div 1024)"/>
            <xsl:text>  MB</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
