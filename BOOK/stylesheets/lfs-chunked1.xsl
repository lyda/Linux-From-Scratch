<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

  <xsl:import href="http://docbook.sourceforge.net/release/xsl/1.67.2/xhtml/profile-chunk-code.xsl"/> 

  <xsl:key name="id" match="*" use="@xml:id"/>
  

  <xsl:template match="/">
    <xslo:variable xmlns:xslo="http://www.w3.org/1999/XSL/Transform" name="profiled-content">
      <xslo:apply-templates select="." mode="profile"/>
    </xslo:variable>
    <xslo:variable xmlns:xslo="http://www.w3.org/1999/XSL/Transform" name="profiled-nodes" 
            select="exsl:node-set($profiled-content)"/>
    <xsl:choose>
      <xsl:when test="namespace-uri(*[1]) = 'http://docbook.org/docbook-ng'">
        <xsl:variable name="nons">
          <xsl:apply-templates select="$profiled-nodes" mode="stripNS"/>
        </xsl:variable>
        <xsl:apply-templates select="exsl:node-set($nons)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$rootid != ''">
            <xsl:choose>
              <xsl:when test="count($profiled-nodes//*[@id=$rootid]) = 0">
                <xsl:message terminate="yes">
                  <xsl:text>ID '</xsl:text>
                  <xsl:value-of select="$rootid"/>
                  <xsl:text>' not found in document.</xsl:text>
                </xsl:message>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$collect.xref.targets = 'yes' or                         $collect.xref.targets = 'only'">
                  <xsl:apply-templates select="key('id', $rootid)" mode="collect.targets"/>
                </xsl:if>
                <xsl:if test="$collect.xref.targets != 'only'">
                  <xsl:apply-templates select="$profiled-nodes//*[@id=$rootid]" mode="process.root"/>
                  <xsl:if test="$tex.math.in.alt != ''">
                    <xsl:apply-templates select="$profiled-nodes//*[@id=$rootid]" mode="collect.tex.math"/>
                  </xsl:if>
                  <xsl:if test="$generate.manifest != 0">
                    <xsl:call-template name="generate.manifest">
                      <xsl:with-param name="node" select="key('id',$rootid)"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$collect.xref.targets = 'yes' or                     $collect.xref.targets = 'only'">
              <xsl:apply-templates select="$profiled-nodes" mode="collect.targets"/>
            </xsl:if>
            <xsl:if test="$collect.xref.targets != 'only'">
              <xsl:apply-templates select="$profiled-nodes" mode="process.root"/>
              <xsl:if test="$tex.math.in.alt != ''">
                <xsl:apply-templates select="$profiled-nodes" mode="collect.tex.math"/>
              </xsl:if>
              <xsl:if test="$generate.manifest != 0">
                <xsl:call-template name="generate.manifest"/>
              </xsl:if>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="stripNS">
    <xsl:choose>
       <xsl:when test="namespace-uri(.) = 'http://docbook.org/docbook-ng'">
         <xsl:element name="{local-name(.)}">
           <xsl:copy-of select="@*"/>
           <xsl:apply-templates mode="stripNS"/>
         </xsl:element>
       </xsl:when>
       <xsl:otherwise>
         <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:apply-templates mode="stripNS"/>
         </xsl:copy>
       </xsl:otherwise>
     </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

