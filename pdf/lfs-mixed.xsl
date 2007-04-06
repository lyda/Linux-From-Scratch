<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

   <!-- REVISED -->


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
           Removed vertical space in vaiablelist. -->
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
      <xsl:when test="ancestor::variablelist">
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

    <!-- Show external URLs in italic font -->
  <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="font-style">
      <xsl:choose>
        <xsl:when test="self::ulink">italic</xsl:when>
        <xsl:otherwise>inherit</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>


  <!-- Lists -->

    <!-- What spacing do you want before and after lists? -->
  <xsl:attribute-set name="list.block.spacing">
    <xsl:attribute name="space-before.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.8em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
  </xsl:attribute-set>

    <!-- What spacing do you want between list items? -->
  <xsl:attribute-set name="list.item.spacing">
    <xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.6em</xsl:attribute>
  </xsl:attribute-set>

    <!-- Properties that apply to each list-block generated by itemizedlist. -->
  <xsl:attribute-set name="itemizedlist.properties"
                     use-attribute-sets="list.block.properties">
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

    <!-- Format variablelists lists as blocks? 1 = yes, 0 = no
           Default variablelist format. We override it when necesary
           using the list-presentation processing instruction. -->
  <xsl:param name="variablelist.as.blocks" select="1"/>

    <!-- Specifies the longest term in variablelists.
         Used when list-presentation = list -->
  <xsl:param name="variablelist.max.termlength">32</xsl:param>

    <!-- varlistentry mode block:
           Addibg a bullet, left alignament, and @kepp-*.* attributes
           for packages and paches list. -->
    <!-- The original template is in {docbook-xsl}/fo/list.xsl -->
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
        <fo:block margin-left="1.4pc" text-align="left"
                  keep-together.within-column="always"
                  keep-with-previous.within-column="always">
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

    <!-- segmentedlist:
           Making it an actual FO list to can indent items. -->
    <!-- The original template is in {docbook-xsl}/fo/list.xsl -->
  <xsl:template match="segmentedlist">
    <fo:list-block provisional-distance-between-starts="12em"
                   provisional-label-separation="1em"
                   xsl:use-attribute-sets="list.block.spacing"
                   keep-together.within-column="always">
      <xsl:apply-templates select="seglistitem/seg"/>
    </fo:list-block>
  </xsl:template>

    <!-- seg:
           Self-made template based on the original seg template
           found in {docbook-xsl}/fo/list.xsl
           Making segmentedlist an actual FO list to can indent items. -->
  <xsl:template match="seglistitem/seg">
    <xsl:variable name="segnum" select="count(preceding-sibling::seg)+1"/>
    <xsl:variable name="seglist" select="ancestor::segmentedlist"/>
    <xsl:variable name="segtitles" select="$seglist/segtitle"/>
    <fo:list-item xsl:use-attribute-sets="compact.list.item.spacing">
      <fo:list-item-label end-indent="label-end()" text-align="start">
        <fo:block>
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="$segtitles[$segnum=position()]"
                                 mode="segtitle-in-seg"/>
            <xsl:text>:</xsl:text>
          </fo:inline>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
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
