BASEDIR=~/lfs-book/

lfs:
	./entResolver output
	cd ../output && xsltproc --xinclude --nonet -stringparam base.dir \
	$(BASEDIR) stylesheets/lfs-chunked.xsl index.xml

	if [ ! -e $(BASEDIR)/stylesheets ]; then \
	  mkdir -p $(BASEDIR)/stylesheets; \
	fi;
	cp ../output/stylesheets/lfs.css $(BASEDIR)/stylesheets

	if [ ! -e $(BASEDIR)/images ]; then \
	  mkdir -p $(BASEDIR)/images; \
	fi;
	cp /usr/share/xml/docbook/xsl-stylesheets-1.65.0/images/*.png \
	  $(BASEDIR)/images
	sed -i -e "s@../stylesheets@stylesheets@" \
	  $(BASEDIR)/{index,pt01,pt02,pt03,pt04}.html
	sed -i -e "s@../images@images@g" \
	  $(BASEDIR)/{index,pt01,pt02,pt03,pt04}.html
