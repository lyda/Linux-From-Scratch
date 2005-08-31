<?xml version='1.0' encoding='ISO-8859-1'?>
<!DOCTYPE xsl:stylesheet [
 <!ENTITY % general-entities SYSTEM "../general.ent">
  %general-entities;
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <xsl:output method="html" encoding="iso-8859-1"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          Linux From Scratch
        </title>
        <style type="text/css">
          <xsl:text>
body {
  font-family: sans-serif;
  text-align: left;
  background: #fff;
  color: #333;
  margin: 1em;
  padding: 0;
  font-size: 1em;
  line-height: 1.2em
}

a:link { color: #22b; }
a:visited { color: #7e4988; }
a:hover, a:focus { color: #d30e08; }
a:active { color: #6b77b1;}

h1, h2 {
  color: #000;
  font-weight: bold;
}

h3, h4, h5, h6 {
  color: #222;
}

h1 { font-size: 173%; text-align: center; }
h2 { font-size: 144%;  text-align: center; }
h3 { font-size: 120%; padding-top: 0.2em; margin-top: 0.3em; }
h4 { font-size: 110%;}

div.toc {
  padding-left: 1em;
  margin-top: 1em;
}

div.toc ul li h3, div.toc ul li h4 {
  margin: .4em;
}

div.book {
  padding-bottom: 0.5em;
}

div.book h1 {
  background: #f5f6f7;
  margin: 0px auto;
  padding: 0.5em;
}

div.book h2 {
  background: #dbddec;
  margin: 0px auto;
  padding: 0.2em;
}
div.authorgroup, div p.copyright {
  background: #f5f6f7;
  margin: 0px auto;
  padding:  1em 0.5em;
}

hr {
  background: #dbddec;
  height: .3em;
  border: 0px;
  margin: 0px auto;
  padding: 0;
}
          </xsl:text>
        </style>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="bookinfo">
    <div class="book">
      <div class="titlepage">
        <xsl:apply-templates/>
        <hr/>
      </div>
      <div class="toc">
        <h3>
          <xsl:text>32 Bit Builds</xsl:text>
        </h3>
        <ul>
	  <h3>
	    <xsl:text>Working. Testers and comments welcomed.</xsl:text>
          </h3>
          <li>
            <h4>
              <a href="x86">
                <xsl:text>Intel/AMD x86</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
              <a href="ppc">
                <xsl:text>PowerPC</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
              <a href="mips">
                <xsl:text>MIPS</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
              <a href="sparc">
                <xsl:text>Sparc</xsl:text>
              </a>
            </h4>
          </li>
	</ul>
        <h3>
          <xsl:text>64 Bit Builds</xsl:text>
        </h3>
	<ul>
          <h3>
            <xsl:text>This is experimental. Bootloaders do not work.</xsl:text>
          </h3>
          <li>
            <h4>
              <a href="x86_64-64">
                <xsl:text>x86_64</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
              <a href="mips64-64">
                <xsl:text>MIPS</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
             <a href="sparc64-64">
                <xsl:text>Sparc/UltraSPARC</xsl:text>
             </a>
            </h4>
          </li>
          <li>
            <h4>
             <a href="alpha">
                <xsl:text>Alpha</xsl:text>
             </a>
            </h4>
          </li>
	</ul>
        <h3>
          <xsl:text>Multilib Builds</xsl:text>
        </h3>
	<ul>
          <h3>
             <xsl:text>Working. Testers and comments welcomed.</xsl:text>
          </h3>
          <li>
            <h4>
              <a href="x86_64">
                <xsl:text>x86_64</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
              <a href="mips64">
                <xsl:text>MIPS</xsl:text>
              </a>
            </h4>
          </li>
          <li>
            <h4>
             <a href="sparc64">
                <xsl:text>Sparc/UltraSPARC</xsl:text>
             </a>
            </h4>
          </li>
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="title">
    <div>
      <h1 class="title">
        <xsl:value-of select="."/>
      </h1>
    </div>
    <div>
      <h2 class="subtitle">
        <xsl:text>Version &version;</xsl:text>
      </h2>
    </div>
  </xsl:template>

  <xsl:template match="authorgroup">
    <div class="authorgroup">
      <h3 class="author">
        <xsl:value-of select="author/firstname"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="author/surname"/>
      </h3>
    </div>
  </xsl:template>

  <xsl:template match="copyright">
    <div>
      <p class="copyright">
        <xsl:text>Copyright (c)</xsl:text>
        <xsl:apply-templates/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="year">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="holder">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="subtitle|author|firstname|surname|legalnotice"/>

</xsl:stylesheet>
