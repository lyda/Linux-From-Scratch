
SOURCEDIR=.

# The default is to generate HTML with XSLT using xsltproc. The OpenJade output
# is seriously broken.

# To install the tools for this,
#  1) Install libxslt and its dependencies according to their instructions.
#     You should now have a working xsltproc command.
#  2) Extract, move, and rename
#     http://www.oasis-open.org/docbook/xml/4.2/docbook-xml-4.2.zip
#     so that /usr/share/docbook/docbookx.dtd exists.
#  3) Extract, move, and rename
#     http://unc.dl.sourceforge.net/sourceforge/docbook/docbook-xsl-1.57.0.tar.gz
#     so that /usr/share/xsl/docbook/html/docbook.xsl exists

faq.html: $(SOURCEDIR)/*.xml $(SOURCEDIR)/*.ent
	xsltproc --output faq.html /usr/share/xsl/docbook/html/docbook.xsl $(SOURCEDIR)/faq.xml

clean:
	rm -rf faq.html faq.openjade.html

.PHONY: clean

# To set up openjade, see the INSTALL file under
# http://cvs.linuxfromscratch.org/index.cgi/LFS/BOOK/

faq.openjade.html: $(SOURCEDIR)/*.xml $(SOURCEDIR)/*.ent
	/usr/bin/openjade -t xml -V nochunks -d \
	/usr/share/dsssl/docbook/html/lfs.dsl \
	/usr/share/dsssl/docbook/dtds/decls/xml.dcl \
	$(SOURCEDIR)/faq.xml > faq.openjade.html

