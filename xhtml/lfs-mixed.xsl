<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <!-- This stylesheet contains misc templates for output formating.
       This file is for that templates that don't fit in other files
       and that not afect the chunk algorithm. -->

  <!-- Individual elements templates -->

    <!-- para:
           Added a choose to skip empty "Home page" in packages.xml -->
    <!-- The original template is in {docbook-xsl}/xhtml/block.xsl -->
  <xsl:template match="para">
    <xsl:choose>
      <xsl:when test="child::ulink[@url=' ']"/>
      <xsl:otherwise>
        <xsl:call-template name="paragraph">
          <xsl:with-param name="class">
            <xsl:if test="@role and $para.propagates.style != 0">
              <xsl:value-of select="@role"/>
            </xsl:if>
          </xsl:with-param>
          <xsl:with-param name="content">
            <xsl:if test="position() = 1 and parent::listitem">
              <xsl:call-template name="anchor">
                <xsl:with-param name="node" select="parent::listitem"/>
              </xsl:call-template>
            </xsl:if>
            <xsl:call-template name="anchor"/>
            <xsl:apply-templates/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- screen:
           Changed class attribute asignament to fit our look needs.
           Removed unused line numbering support. -->
    <!-- The original template is in {docbook-xsl}/xhtml/verbatim.xsl
         It match also programlisting and synopsis. The code for that tags
         is unchanged. -->
  <xsl:template match="screen">
    <xsl:choose>
      <xsl:when test="child::* = userinput">
        <pre class="userinput">
            <xsl:apply-templates/>
        </pre>
      </xsl:when>
      <xsl:otherwise>
        <pre class="{name(.)}">
          <xsl:apply-templates/>
        </pre>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- userinput:
           Using a customized output when inside screen.
           In other cases, use the original template. -->
    <!-- The original template is in {docbook-xsl}/xhtml/inline.xsl -->
  <xsl:template match="userinput">
    <xsl:choose>
      <xsl:when test="ancestor::screen">
        <kbd class="command">
          <xsl:apply-templates/>
        </kbd>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- seg in segementedlist:
           Added a span around seg text to can match it with CSS code. -->
    <!-- The original template is in {docbook-xsl}/xhtml/lists.xsl -->
  <xsl:template match="seg">
    <xsl:variable name="segnum" select="count(preceding-sibling::seg)+1"/>
    <xsl:variable name="seglist" select="ancestor::segmentedlist"/>
    <xsl:variable name="segtitles" select="$seglist/segtitle"/>
      <!-- Note: segtitle is only going to be the right thing in a well formed
      SegmentedList.  If there are too many Segs or too few SegTitles,
      you'll get something odd...maybe an error -->
    <div class="seg">
      <strong>
        <span class="segtitle">
          <xsl:apply-templates select="$segtitles[$segnum=position()]" mode="segtitle-in-seg"/>
          <xsl:text>: </xsl:text>
        </span>
      </strong>
      <span class="seg">
        <xsl:apply-templates/>
      </span>
    </div>
  </xsl:template>

    <!-- variablelist:
           If it have a role attribute, wrap the default output into a div with
           a class attribute matching that role attribute.
           Apply the original template in all cases. -->
    <!-- The original template is in {docbook-xsl}/xhtml/lists.xsl -->
  <xsl:template match="variablelist">
    <xsl:choose>
      <xsl:when test="@role">
        <div class="{@role}">
          <xsl:apply-imports/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- Named formating templates -->

    <!-- Body attributes:
           Add to the body XHTML output tag an id attribute with the book type
           and a class atribute with the book version. -->
    <!-- The original template is in {docbook-xsl}/xhtml/docbook.xsl -->
  <xsl:template name="body.attributes">
    <xsl:attribute name="id">
      <xsl:text>lfs</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="class">
      <xsl:value-of select="substring-after(/book/bookinfo/subtitle, ' ')"/>
    </xsl:attribute>
  </xsl:template>

    <!-- inline.monoseq:
           The code xhtml tag have look issues in some browsers.
           We will use tt instead. -->
    <!-- The original template is in {docbook-xsl}/xhtml/inline.xsl -->
  <xsl:template name="inline.monoseq">
    <xsl:param name="content">
      <xsl:call-template name="anchor"/>
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>
    <tt>
      <xsl:apply-templates select="." mode="class.attribute"/>
      <xsl:call-template name="dir"/>
      <xsl:call-template name="generate.html.title"/>
      <xsl:copy-of select="$content"/>
      <xsl:call-template name="apply-annotations"/>
    </tt>
  </xsl:template>

    <!-- inline.boldmonoseq:
           The code xhtml tag have look issues in some browsers.
           We will use tt instead. -->
    <!-- The original template is in {docbook-xsl}/xhtml/inline.xsl -->
  <xsl:template name="inline.boldmonoseq">
    <xsl:param name="content">
      <xsl:call-template name="anchor"/>
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>
    <!-- don't put <strong> inside figure, example, or table titles
         or other titles that may already be represented with <strong>'s. -->
    <xsl:choose>
      <xsl:when test="local-name(..) = 'title' and (local-name(../..) = 'figure'
                      or local-name(../..) = 'example' or local-name(../..) = 'table'
                      or local-name(../..) = 'formalpara')">
        <tt>
          <xsl:apply-templates select="." mode="class.attribute"/>
          <xsl:call-template name="generate.html.title"/>
          <xsl:call-template name="dir"/>
          <xsl:copy-of select="$content"/>
          <xsl:call-template name="apply-annotations"/>
        </tt>
      </xsl:when>
      <xsl:otherwise>
        <strong>
          <xsl:apply-templates select="." mode="class.attribute"/>
          <tt>
            <xsl:call-template name="generate.html.title"/>
            <xsl:call-template name="dir"/>
            <xsl:copy-of select="$content"/>
          </tt>
        </strong>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- inline.italicmonoseq:
           The code xhtml tag have look issues in some browsers.
           We will use tt instead. -->
    <!-- The original template is in {docbook-xsl}/xhtml/inline.xsl -->
  <xsl:template name="inline.italicmonoseq">
    <xsl:param name="content">
      <xsl:call-template name="anchor"/>
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>
    <em>
      <xsl:apply-templates select="." mode="class.attribute"/>
      <tt>
        <xsl:call-template name="generate.html.title"/>
        <xsl:call-template name="dir"/>
        <xsl:copy-of select="$content"/>
        <xsl:call-template name="apply-annotations"/>
      </tt>
    </em>
  </xsl:template>

</xsl:stylesheet>
