BASEDIR=~/lfs-book/

lfs:
	xsltproc --xinclude --nonet -stringparam base.dir $(BASEDIR) \
	  stylesheets/lfs-chunked.xsl index.xml

	if [ ! -e $(BASEDIR)stylesheets ]; then \
	  mkdir -p $(BASEDIR)stylesheets; \
	fi;
	cp stylesheets/lfs.css $(BASEDIR)stylesheets

	if [ ! -e $(BASEDIR)images ]; then \
	  mkdir -p $(BASEDIR)images; \
	fi;
	cp /usr/share/xml/docbook/xsl-stylesheets-1.65.1/images/*.png \
	  $(BASEDIR)images
	sed -i -e "s@../stylesheets@stylesheets@" \
	  $(BASEDIR){index,part1,part2,part3,part4}.html
	sed -i -e "s@../images@images@g" \
	  $(BASEDIR){index,part1,part2,part3,part4}.html

pdf:
	xsltproc --xinclude --nonet --output lfs.fo stylesheets/lfs-pdf.xsl \
	  index.xml
	fop.sh lfs.fo lfs.pdf
