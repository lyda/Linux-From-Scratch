BASEDIR=~/lfs-book
CHUNK_QUIET=0
PDF_OUTPUT=LFS-BOOK.pdf
NOCHUNKS_OUTPUT=LFS-BOOK.html
XSLROOTDIR=/usr/share/xml/docbook/xsl-stylesheets-current
ARCH=x86

lfs:
# top-level index.html
	xsltproc --nonet --output $(BASEDIR)/index.html stylesheets/top-index.xsl prologue/bookinfo.xml

# x86
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch x86 \
	  --output $(BASEDIR)/lfs-html.xml stylesheets/lfs-profile.xsl index.xml

	xsltproc --nonet -stringparam chunk.quietly $(CHUNK_QUIET) \
	  -stringparam base.dir $(BASEDIR)/x86/ stylesheets/lfs-chunked.xsl \
	  $(BASEDIR)/lfs-html.xml

	if [ ! -e $(BASEDIR)/x86/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/x86/stylesheets; \
	fi;
	cp stylesheets/*.css $(BASEDIR)/x86/stylesheets

	if [ ! -e $(BASEDIR)/x86/images ]; then \
	  mkdir -p $(BASEDIR)/x86/images; \
	fi;
	cp $(XSLROOTDIR)/images/*.png \
	  $(BASEDIR)/x86/images
	cd $(BASEDIR)/x86/; sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR)/x86/; sed -i -e "s@../images@images@g" \
	  *.html

	rm $(BASEDIR)/lfs-html.xml

# raq2
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch raq2 \
	  --output $(BASEDIR)/lfs-html.xml stylesheets/lfs-profile.xsl index.xml

	xsltproc --nonet -stringparam chunk.quietly $(CHUNK_QUIET) \
	  -stringparam base.dir $(BASEDIR)/raq2/ stylesheets/lfs-chunked.xsl \
	  $(BASEDIR)/lfs-html.xml

	if [ ! -e $(BASEDIR)/raq2/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/raq2/stylesheets; \
	fi;
	cp stylesheets/*.css $(BASEDIR)/raq2/stylesheets

	if [ ! -e $(BASEDIR)/raq2/images ]; then \
	  mkdir -p $(BASEDIR)/raq2/images; \
	fi;
	cp $(XSLROOTDIR)/images/*.png \
	  $(BASEDIR)/raq2/images
	cd $(BASEDIR)/raq2/; sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR)/raq2/; sed -i -e "s@../images@images@g" \
	  *.html

	rm $(BASEDIR)/lfs-html.xml

# ppc
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch ppc \
	  --output $(BASEDIR)/lfs-html.xml stylesheets/lfs-profile.xsl index.xml

	xsltproc --nonet -stringparam chunk.quietly $(CHUNK_QUIET) \
	  -stringparam base.dir $(BASEDIR)/ppc/ stylesheets/lfs-chunked.xsl \
	  $(BASEDIR)/lfs-html.xml

	if [ ! -e $(BASEDIR)/ppc/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/ppc/stylesheets; \
	fi;
	cp stylesheets/*.css $(BASEDIR)/ppc/stylesheets

	if [ ! -e $(BASEDIR)/ppc/images ]; then \
	  mkdir -p $(BASEDIR)/ppc/images; \
	fi;
	cp $(XSLROOTDIR)/images/*.png \
	  $(BASEDIR)/ppc/images
	cd $(BASEDIR)/ppc/; sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR)/ppc/; sed -i -e "s@../images@images@g" \
	  *.html

	rm $(BASEDIR)/lfs-html.xml


# common stuff
	for filename in `find $(BASEDIR) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	done;

	for filename in `find $(BASEDIR) -name "*.html"`; do \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;

html:
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch $(ARCH) \
	  --output $(BASEDIR)/lfs-html.xml stylesheets/lfs-profile.xsl index.xml

	xsltproc --nonet -stringparam chunk.quietly $(CHUNK_QUIET) \
	  -stringparam base.dir $(BASEDIR)/ stylesheets/lfs-chunked.xsl \
	  $(BASEDIR)/lfs-html.xml

	if [ ! -e $(BASEDIR)/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/stylesheets; \
	fi;
	cp stylesheets/*.css $(BASEDIR)/stylesheets

	if [ ! -e $(BASEDIR)/images ]; then \
	  mkdir -p $(BASEDIR)/images; \
	fi;
	cp $(XSLROOTDIR)/images/*.png \
	  $(BASEDIR)/images
	cd $(BASEDIR)/; sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR)/; sed -i -e "s@../images@images@g" \
	  *.html

	rm $(BASEDIR)/lfs-html.xml

	for filename in `find $(BASEDIR) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	done;

	for filename in `find $(BASEDIR) -name "*.html"`; do \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;

#
# This is the old "pdf" target. The old "print" target below has been   
# renamed to "pdf" and will be used. This commented out previous_pdf
# target can be removed eventually. It'll remain here for a bit for
# historical reasons
#
#previous_pdf:
#	xsltproc --xinclude --nonet --output $(BASEDIR)/lfs.fo stylesheets/lfs-pdf.xsl \
#	  index.xml
#	sed -i -e "s/inherit/all/" $(BASEDIR)/lfs.fo
#	fop.sh $(BASEDIR)/lfs.fo $(BASEDIR)/$(PDF_OUTPUT)
#	rm lfs.fo

pdf:
	xsltproc --xinclude --nonet --stringparam profile.condition pdf -stringparam profile.arch $(ARCH) \
		--output $(BASEDIR)/lfs-pdf.xml stylesheets/lfs-profile.xsl index.xml
	xsltproc --nonet --output $(BASEDIR)/lfs-pdf.fo stylesheets/lfs-pdf.xsl \
		$(BASEDIR)/lfs-pdf.xml
	sed -i -e "s/inherit/all/" $(BASEDIR)/lfs-pdf.fo
	fop.sh $(BASEDIR)/lfs-pdf.fo $(BASEDIR)/$(PDF_OUTPUT)
	rm $(BASEDIR)/lfs-pdf.xml $(BASEDIR)/lfs-pdf.fo

nochunks:
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch $(ARCH) \
	  --output $(BASEDIR)/lfs-nochunk.xml stylesheets/lfs-profile.xsl index.xml

	xsltproc --nonet --output $(BASEDIR)/$(NOCHUNKS_OUTPUT) \
	  stylesheets/lfs-nochunks.xsl $(BASEDIR)/lfs-nochunk.xml

	rm $(BASEDIR)/lfs-nochunk.xml

	tidy -config tidy.conf $(BASEDIR)/$(NOCHUNKS_OUTPUT) || true

	sed -i -e "s@text/html@application/xhtml+xml@g"  \
	  $(BASEDIR)/$(NOCHUNKS_OUTPUT)

validate:
	xmllint --noout --nonet --xinclude --postvalid index.xml

