BASEDIR=~/cross-lfs-book
DUMPDIR=~/cross-lfs-commands
DLLISTDIR=~/cross-lfs-dllist
CHUNK_QUIET=1
JAVA_HOME=/opt/jdk/jdk-precompiled-1.5.0
XSLROOTDIR=/usr/share/xml/docbook/xsl-stylesheets-current
ARCH=x86 x86_64 x86_64-64 sparc sparc64 sparc64-64 mips mips64 mips64-64 ppc alpha

# HTML Rendering Chunked
define HTML_RENDER
	echo "Rendering HTML of $$arch..." ; \
	xsltproc --xinclude --nonet -stringparam profile.condition html \
	  -stringparam chunk.quietly $(CHUNK_QUIET) -stringparam base.dir $(BASEDIR)/$$arch/ \
	  $(PWD)/stylesheets/lfs-chunked.xsl $(PWD)/$$arch-index.xml ; \
	mkdir -p $(BASEDIR)/$$arch/stylesheets ; \
	cp $(PWD)/stylesheets/*.css $(BASEDIR)/$$arch/stylesheets ; \
	cd $(BASEDIR)/$$arch/; sed -i -e "s@../stylesheets@stylesheets@g" *.html ; \
	mkdir -p $(BASEDIR)/$$arch/images ; \
	cp $(XSLROOTDIR)/images/*.png $(BASEDIR)/$$arch/images ; \
	cd $(BASEDIR)/$$arch/; sed -i -e "s@../images@images@g" *.html
endef

# HTML Rendering No Chunks
define HTML_RENDER2
	echo "Rendering Single File HTML of $$arch..." ; \
	xsltproc --xinclude --nonet -stringparam profile.condition html \
	   --output $(BASEDIR)/LFS-BOOK-$$arch.html \
	   $(PWD)/stylesheets/lfs-nochunks.xsl $$arch-index.xml
endef

# PDF Rendering
define PDF_RENDER
	echo "Rendering PDF of $$arch..." ; \
        xsltproc --xinclude --nonet --output $(BASEDIR)/lfs-pdf.fo \
                $(PWD)/stylesheets/lfs-pdf.xsl $$arch-index.xml ; \
        sed -i -e "s/inherit/all/" $(BASEDIR)/lfs-pdf.fo ; \
        fop.sh -q $(BASEDIR)/lfs-pdf.fo -pdf $(BASEDIR)/LFS-BOOK-$$arch.pdf ; \
        rm $(BASEDIR)/lfs-pdf.fo
endef

# Plain Text Rendering
define TEXT_RENDER
        echo "Rendering Text of $$arch..." ; \
        xsltproc --xinclude --nonet --output $(BASEDIR)/lfs-pdf.fo \
                $(PWD)/stylesheets/lfs-pdf.xsl $$arch-index.xml ; \
        sed -i -e "s/inherit/all/" $(BASEDIR)/lfs-pdf.fo ; \
        fop.sh $(BASEDIR)/lfs-pdf.fo -txt $(BASEDIR)/LFS-BOOK-$$arch.txt ; \
        rm $(BASEDIR)/lfs-pdf.fo
endef

# Validation
define VALIDATE
	echo "Validating $$arch..." ; \
        xmllint --xinclude --noout --nonet --postvalid $(PWD)/$$arch-index.xml
endef

# Dump commands
define DUMP
	echo "Extracting commands from $$arch..." ; \
	xsltproc --xinclude --nonet --output $(DUMPDIR)/$$arch/ \
	   $(PWD)/stylesheets/dump-commands.xsl $$arch-index.xml
endef

# Get commands
define DLLIST
	echo "Creating download list for $$arch..." ; \
	xsltproc --xinclude --nonet --output $(DLLISTDIR)/$$arch.dl.list \
	   $(PWD)/stylesheets/wget.xsl $$arch-index.xml
endef

lfs: toplevel render common

toplevel:
	@xsltproc --nonet --output $(BASEDIR)/index.html $(PWD)/stylesheets/top-index.xsl $(PWD)/index.xml

render:
	@for arch in $(ARCH) ; do \
	$(HTML_RENDER) ; \
	done

common:
	@for filename in `find $(BASEDIR) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	  sh obfuscate.sh $$filename; \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;

nochunks: nochunk_render common

nochunk_render:

	@for arch in $(ARCH) ; do \
	$(HTML_RENDER2) ; \
	done

pdf:
	@for arch in $(ARCH) ; do \
	$(PDF_RENDER) ; \
	done

text:
	@for arch in $(ARCH) ; do \
	$(TEXT_RENDER) ; \
	done

validate:
	@for arch in $(ARCH) ; do \
	$(VALIDATE) ; \
	done

dump-commands:
	@for arch in $(ARCH) ; do \
	$(DUMP) ; \
	done

download-list:
	@for arch in $(ARCH) ; do \
	$(DLLIST) ; \
	done

.PHONY: lfs toplevel common render nochunk nochunk_render pdf text validate dump-commands download-list
