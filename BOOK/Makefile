BASEDIR=/home/macana/tmp/test-book-LFS/

lfs:
	xsltproc --xinclude --nonet --stringparam base.dir $(BASEDIR) \
	  stylesheets/lfs-chunked.xsl index.xml

	mkdir -p $(BASEDIR)stylesheets && \
	cp stylesheets/*.css $(BASEDIR)stylesheets

	mkdir -p $(BASEDIR)images && \
	cp /usr/share/xml/docbook/xsl-stylesheets-1.65.1/images/*.png \
	  $(BASEDIR)images

	cd $(BASEDIR); sed -i -e "s@../stylesheets@stylesheets@g" \
	  *.html
	cd $(BASEDIR); sed -i -e "s@../images@images@g" \
	  *.html

	cd $(BASEDIR); goTidy

pdf:
	xsltproc --xinclude --nonet --stringparam profile.condition print --output $(BASEDIR)lfs-pdf.xml \
    stylesheets/lfs-profile.xsl index.xml
	xsltproc --nonet --output $(BASEDIR)lfs-pdf.fo stylesheets/lfs-pdf.xsl $(BASEDIR)lfs-pdf.xml
	cd $(BASEDIR); sed -i -e "s@inherit@all@" lfs-pdf.fo
	cd $(BASEDIR); JAVA_HOME=/opt/java/jre1.3.1_02 FOP_HOME=/home/macana/tmp/fop \
  /home/macana/tmp/fop/fop.sh lfs-pdf.fo lfs-pdf.pdf

nochunks:
	xsltproc --xinclude --nonet --output $(BASEDIR)lfs-nochunk.html \
	  stylesheets/lfs-nochunks.xsl index.xml
	tidy -config tidy.conf $(BASEDIR)lfs-nochunk.html || true

validate:
	xmllint --noout --nonet --xinclude --postvalid index.xml
 

