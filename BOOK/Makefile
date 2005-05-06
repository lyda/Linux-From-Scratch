BASEDIR=~/lfs-book
CHUNK_QUIET=0
PDF_OUTPUT=LFS-BOOK-$(ARCH).pdf
NOCHUNKS_OUTPUT=LFS-BOOK-$(ARCH).html
XSLROOTDIR=/usr/share/xml/docbook/xsl-stylesheets-current
ARCH=x86

lfs:
# top-level index.html
	xsltproc --nonet --output $(BASEDIR)/index.html stylesheets/top-index.xsl prologue/bookinfo.xml

# x86
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch x86 \
	  -stringparam chunk.quietly $(CHUNK_QUIET)  -stringparam base.dir $(BASEDIR)/x86/ \
		stylesheets/lfs-chunked.xsl index.xml

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

# sparc
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch sparc \
	  -stringparam chunk.quietly $(CHUNK_QUIET)  -stringparam base.dir $(BASEDIR)/sparc/ \
		stylesheets/lfs-chunked.xsl index.xml

	if [ ! -e $(BASEDIR)/sparc/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/sparc/stylesheets; \
	fi;
	cp stylesheets/*.css $(BASEDIR)/sparc/stylesheets

	if [ ! -e $(BASEDIR)/sparc/images ]; then \
	  mkdir -p $(BASEDIR)/sparc/images; \
	fi;
	cp $(XSLROOTDIR)/images/*.png \
	  $(BASEDIR)/sparc/images
	cd $(BASEDIR)/sparc/; sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR)/sparc/; sed -i -e "s@../images@images@g" \
	  *.html

# ppc
	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch ppc \
	  -stringparam chunk.quietly $(CHUNK_QUIET)  -stringparam base.dir $(BASEDIR)/ppc/ \
		stylesheets/lfs-chunked.xsl index.xml

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

# raq2
#	xsltproc --xinclude --nonet -stringparam profile.condition html -stringparam profile.arch raq2 \
#	  -stringparam chunk.quietly $(CHUNK_QUIET)  -stringparam base.dir $(BASEDIR)/raq2/ \
#		stylesheets/lfs-chunked.xsl index.xml
#
#	if [ ! -e $(BASEDIR)/raq2/stylesheets ]; then \
#	  mkdir -p $(BASEDIR)/raq2/stylesheets; \
#	fi;
#	cp stylesheets/*.css $(BASEDIR)/raq2/stylesheets

#	if [ ! -e $(BASEDIR)/raq2/images ]; then \
#	  mkdir -p $(BASEDIR)/raq2/images; \
#	fi;
#	cp $(XSLROOTDIR)/images/*.png \
#	  $(BASEDIR)/raq2/images
#	cd $(BASEDIR)/raq2/; sed -i -e "s@../stylesheets@stylesheets@g" \
#	  *.html
#	cd $(BASEDIR)/raq2/; sed -i -e "s@../images@images@g" \
#	  *.html

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
	  -stringparam chunk.quietly $(CHUNK_QUIET)  -stringparam base.dir $(BASEDIR)/$(ARCH)/ \
		stylesheets/lfs-chunked.xsl index.xml

	if [ ! -e $(BASEDIR)/$(ARCH)/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/$(ARCH)/stylesheets; \
	fi;
	cp stylesheets/*.css $(BASEDIR)/$(ARCH)/stylesheets

	if [ ! -e $(BASEDIR)/$(ARCH)/images ]; then \
	  mkdir -p $(BASEDIR)/$(ARCH)/images; \
	fi;
	cp $(XSLROOTDIR)/images/*.png \
	  $(BASEDIR)/$(ARCH)/images
	cd $(BASEDIR)/$(ARCH)/; sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR)/$(ARCH)/; sed -i -e "s@../images@images@g" \
	  *.html

	for filename in `find $(BASEDIR)/$(ARCH) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	done;

	for filename in `find $(BASEDIR)/$(ARCH)/ -name "*.html"`; do \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;

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
	  --output  $(BASEDIR)/$(NOCHUNKS_OUTPUT) stylesheets/lfs-nochunks.xsl index.xml

	tidy -config tidy.conf $(BASEDIR)/$(NOCHUNKS_OUTPUT) || true

	sed -i -e "s@text/html@application/xhtml+xml@g"  \
	  $(BASEDIR)/$(NOCHUNKS_OUTPUT)

validate:
# x86
	xsltproc --xinclude --nonet -stringparam profile.arch x86 \
		 --output index-x86.xml stylesheets/lfs-profile.xsl index.xml
	xmllint --noout --nonet --postvalid index-x86.xml

# sparc
	xsltproc --xinclude --nonet -stringparam profile.arch sparc \
		 --output index-sparc.xml stylesheets/lfs-profile.xsl index.xml
	xmllint --noout --nonet --postvalid index-alpha.xml

# ppc
	xsltproc --xinclude --nonet -stringparam profile.arch ppc \
		 --output index-ppc.xml stylesheets/lfs-profile.xsl index.xml
	xmllint --noout --nonet --postvalid index-ppc.xml

# raq2
#	xsltproc --xinclude --nonet -stringparam profile.arch raq2 \
#		 --output index-raq2.xml stylesheets/lfs-profile.xsl index.xml
#	xmllint --noout --nonet --postvalid index-raq2.xml

# clean-up
	rm index-x86.xml index-sparc.xml index-ppc.xml index-raq2.xml

