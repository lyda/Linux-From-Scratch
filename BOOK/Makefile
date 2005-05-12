BASEDIR=~/lfs-book
CHUNK_QUIET=0
PDF_OUTPUT=LFS-BOOK-$(ARCH).pdf
NOCHUNKS_OUTPUT=LFS-BOOK-$(ARCH).html
XSLROOTDIR=/usr/share/xml/docbook/xsl-stylesheets-current
ARCH=x86 sparc sparc64 raq2 ppc

# HTML Rendering
define HTML_RENDER
	echo "Rendering $$arch..." ; \
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

# Validation
define VALIDATE
        echo "Validating $$arch..." ; \
        xsltproc --xinclude --nonet --output $(PWD)/index-$$arch.xml \
           ${PWD}/stylesheets/lfs-profile.xsl $(PWD)/$$arch-index.xml ; \
        xmllint --noout --nonet --postvalid $(PWD)/index-$$arch.xml
endef

lfs: toplevel render common cleanup

toplevel:
	@xsltproc --nonet --output $(BASEDIR)/index.html $(PWD)/stylesheets/top-index.xsl $(PWD)/index.xml

render:
	@for arch in $(ARCH) ; do \
	$(HTML_RENDER) ; \
	done 

common:
	for filename in `find $(BASEDIR) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	done;

	for filename in `find $(BASEDIR) -name "*.html"`; do \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;

validate: validation cleanup

validation:
	@for arch in $(ARCH) ; do \
	$(VALIDATE) ; \
	done

cleanup:
	@for arch in $(ARCH) ; do \
	echo "Removing index-$$arch.xml" ; \
	rm -f $(PWD)/index-$$arch.xml ; \
	done

.PHONY: lfs toplevel x86 sparc sparc64 ppc html pdf nochunks validate
