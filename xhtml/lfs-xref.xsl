<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xlink"
                version="1.0">

  <!-- This stylesheet fixes English punctuation in xref links
       (as was requested by the publisher) via adding @role propagation
       in xref tags.
       This hack may not work with xref flavours not used in the book.
       For other languages, just remove the xref @role attributes
       in the book XML sources and/or comment-out the inclusion of
       this file in lfs-chunked2.xsl -->

    <!-- xref:
           Added role variable and use it when calling mode xref-to.-->
    <!-- The original template is in {docbook-xsl}/xhtml/xref.xsl -->
  <xsl:template match="xref" name="xref">
    <xsl:param name="xhref" select="@xlink:href"/>
    <!-- is the @xlink:href a local idref link? -->
    <xsl:param name="xlink.idref">
      <xsl:if test="starts-with($xhref,'#') and (not(contains($xhref,'('))
                    or starts-with($xhref, '#xpointer(id('))">
        <xsl:call-template name="xpointer.idref">
          <xsl:with-param name="xpointer" select="$xhref"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:param>
    <xsl:param name="xlink.targets" select="key('id',$xlink.idref)"/>
    <xsl:param name="linkend.targets" select="key('id',@linkend)"/>
    <xsl:param name="target" select="($xlink.targets | $linkend.targets)[1]"/>
      <!-- Added role variable -->
    <xsl:variable name="role" select="@role"/>
    <xsl:variable name="xrefstyle">
      <xsl:choose>
        <xsl:when test="@role and not(@xrefstyle) and $use.role.as.xrefstyle != 0">
          <xsl:value-of select="@role"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@xrefstyle"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="anchor"/>
    <xsl:variable name="content">
      <xsl:choose>
        <xsl:when test="@endterm">
          <xsl:variable name="etargets" select="key('id',@endterm)"/>
          <xsl:variable name="etarget" select="$etargets[1]"/>
          <xsl:choose>
            <xsl:when test="count($etarget) = 0">
              <xsl:message>
                <xsl:value-of select="count($etargets)"/>
                <xsl:text>Endterm points to nonexistent ID: </xsl:text>
                <xsl:value-of select="@endterm"/>
              </xsl:message>
              <xsl:text>???</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="$etarget" mode="endterm"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$target/@xreflabel">
          <xsl:call-template name="xref.xreflabel">
            <xsl:with-param name="target" select="$target"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$target">
          <xsl:if test="not(parent::citation)">
            <xsl:apply-templates select="$target" mode="xref-to-prefix"/>
          </xsl:if>
          <xsl:apply-templates select="$target" mode="xref-to">
            <xsl:with-param name="referrer" select="."/>
            <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
             <!-- Propagate role -->
            <xsl:with-param name="role" select="$role"/>
          </xsl:apply-templates>
          <xsl:if test="not(parent::citation)">
            <xsl:apply-templates select="$target" mode="xref-to-suffix"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>ERROR: xref linking to </xsl:text>
            <xsl:value-of select="@linkend|@xlink:href"/>
            <xsl:text> has no generated link text.</xsl:text>
          </xsl:message>
          <xsl:text>???</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content" select="$content"/>
    </xsl:call-template>
  </xsl:template>

    <!-- sect* mode xref-to:
           Propagate role to mode object.xref.markup -->
    <!-- The original template is in {docbook-xsl}/xhtml/xref.xsl -->
  <xsl:template match="section|simplesect|sect1|sect2|sect3|sect4|sect5|refsect1
                       |refsect2|refsect3|refsection" mode="xref-to">
    <xsl:param name="referrer"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="verbose" select="1"/>
    <xsl:param name="role"/>
    <xsl:apply-templates select="." mode="object.xref.markup">
      <xsl:with-param name="purpose" select="'xref'"/>
      <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
      <xsl:with-param name="referrer" select="$referrer"/>
      <xsl:with-param name="verbose" select="$verbose"/>
      <xsl:with-param name="role" select="$role"/>
    </xsl:apply-templates>
  </xsl:template>

    <!-- mode object.xref.markup:
           Propagate role to named template substitute-markup -->
    <!-- The original template is in {docbook-xsl}/common/gentext.xsl -->
  <xsl:template match="*" mode="object.xref.markup">
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="referrer"/>
    <xsl:param name="verbose" select="1"/>
    <xsl:param name="role"/>
    <xsl:variable name="template">
      <xsl:choose>
        <xsl:when test="starts-with(normalize-space($xrefstyle), 'select:')">
          <xsl:call-template name="make.gentext.template">
            <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
            <xsl:with-param name="purpose" select="$purpose"/>
            <xsl:with-param name="referrer" select="$referrer"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="starts-with(normalize-space($xrefstyle), 'template:')">
          <xsl:value-of select="substring-after(normalize-space($xrefstyle), 'template:')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="object.xref.template">
            <xsl:with-param name="purpose" select="$purpose"/>
            <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
            <xsl:with-param name="referrer" select="$referrer"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="$template = '' and $verbose != 0">
      <xsl:message>
        <xsl:text>object.xref.markup: empty xref template</xsl:text>
        <xsl:text> for linkend="</xsl:text>
        <xsl:value-of select="@id|@xml:id"/>
        <xsl:text>" and @xrefstyle="</xsl:text>
        <xsl:value-of select="$xrefstyle"/>
        <xsl:text>"</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:call-template name="substitute-markup">
      <xsl:with-param name="purpose" select="$purpose"/>
      <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
      <xsl:with-param name="referrer" select="$referrer"/>
      <xsl:with-param name="template" select="$template"/>
      <xsl:with-param name="verbose" select="$verbose"/>
      <xsl:with-param name="role" select="$role"/>
    </xsl:call-template>
  </xsl:template>

    <!-- substitute-markup:
           Propagate role to mode insert.title.markup -->
    <!-- The original template is in {docbook-xsl}/common/gentext.xsl -->
  <xsl:template name="substitute-markup">
    <xsl:param name="template" select="''"/>
    <xsl:param name="allow-anchors" select="'0'"/>
    <xsl:param name="title" select="''"/>
    <xsl:param name="subtitle" select="''"/>
    <xsl:param name="docname" select="''"/>
    <xsl:param name="label" select="''"/>
    <xsl:param name="pagenumber" select="''"/>
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="referrer"/>
    <xsl:param name="verbose"/>
    <xsl:param name="role"/>
    <xsl:choose>
      <xsl:when test="contains($template, '%')">
        <xsl:value-of select="substring-before($template, '%')"/>
        <xsl:variable name="candidate"
                      select="substring(substring-after($template, '%'), 1, 1)"/>
        <xsl:choose>
          <xsl:when test="$candidate = 't'">
            <xsl:apply-templates select="." mode="insert.title.markup">
              <xsl:with-param name="purpose" select="$purpose"/>
              <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
              <xsl:with-param name="role" select="$role"/>
              <xsl:with-param name="title">
                <xsl:choose>
                  <xsl:when test="$title != ''">
                    <xsl:copy-of select="$title"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="." mode="title.markup">
                      <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
                      <xsl:with-param name="verbose" select="$verbose"/>
                    </xsl:apply-templates>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$candidate = 's'">
            <xsl:apply-templates select="." mode="insert.subtitle.markup">
              <xsl:with-param name="purpose" select="$purpose"/>
              <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
              <xsl:with-param name="subtitle">
                <xsl:choose>
                  <xsl:when test="$subtitle != ''">
                    <xsl:copy-of select="$subtitle"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="." mode="subtitle.markup">
                      <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
                    </xsl:apply-templates>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$candidate = 'n'">
            <xsl:apply-templates select="." mode="insert.label.markup">
              <xsl:with-param name="purpose" select="$purpose"/>
              <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
              <xsl:with-param name="label">
                <xsl:choose>
                  <xsl:when test="$label != ''">
                    <xsl:copy-of select="$label"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="." mode="label.markup"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$candidate = 'p'">
            <xsl:apply-templates select="." mode="insert.pagenumber.markup">
              <xsl:with-param name="purpose" select="$purpose"/>
              <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
              <xsl:with-param name="pagenumber">
                <xsl:choose>
                  <xsl:when test="$pagenumber != ''">
                    <xsl:copy-of select="$pagenumber"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="." mode="pagenumber.markup"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$candidate = 'o'">
            <!-- olink target document title -->
            <xsl:apply-templates select="." mode="insert.olink.docname.markup">
              <xsl:with-param name="purpose" select="$purpose"/>
              <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
              <xsl:with-param name="docname">
                <xsl:choose>
                  <xsl:when test="$docname != ''">
                    <xsl:copy-of select="$docname"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="." mode="olink.docname.markup"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$candidate = 'd'">
            <xsl:apply-templates select="." mode="insert.direction.markup">
              <xsl:with-param name="purpose" select="$purpose"/>
              <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
              <xsl:with-param name="direction">
                <xsl:choose>
                  <xsl:when test="$referrer">
                    <xsl:variable name="referent-is-below">
                      <xsl:for-each select="preceding::xref">
                        <xsl:if test="generate-id(.) = generate-id($referrer)">1</xsl:if>
                      </xsl:for-each>
                    </xsl:variable>
                    <xsl:choose>
                      <xsl:when test="$referent-is-below = ''">
                        <xsl:call-template name="gentext">
                          <xsl:with-param name="key" select="'above'"/>
                        </xsl:call-template>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="gentext">
                          <xsl:with-param name="key" select="'below'"/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:message>Attempt to use %d in gentext with no referrer!</xsl:message>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$candidate = '%' ">
            <xsl:text>%</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>%</xsl:text><xsl:value-of select="$candidate"/>
          </xsl:otherwise>
        </xsl:choose>
        <!-- recurse with the rest of the template string -->
        <xsl:variable name="rest"
              select="substring($template,
              string-length(substring-before($template, '%'))+3)"/>
        <xsl:call-template name="substitute-markup">
          <xsl:with-param name="template" select="$rest"/>
          <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
          <xsl:with-param name="title" select="$title"/>
          <xsl:with-param name="subtitle" select="$subtitle"/>
          <xsl:with-param name="docname" select="$docname"/>
          <xsl:with-param name="label" select="$label"/>
          <xsl:with-param name="pagenumber" select="$pagenumber"/>
          <xsl:with-param name="purpose" select="$purpose"/>
          <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
          <xsl:with-param name="referrer" select="$referrer"/>
          <xsl:with-param name="verbose" select="$verbose"/>
          <xsl:with-param name="role" select="$role"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$template"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- insert.title.markup:
           Apply the role value. -->
    <!-- The original template is in {docbook-xsl}/xhtml/xref.xsl -->
  <xsl:template match="*" mode="insert.title.markup">
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="title"/>
    <xsl:param name="role"/>
    <xsl:choose>
      <xsl:when test="$purpose = 'xref' and titleabbrev">
        <xsl:apply-templates select="." mode="titleabbrev.markup"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$title"/>
        <xsl:value-of select="$role"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
