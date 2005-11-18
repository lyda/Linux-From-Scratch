#!/bin/bash

# This script is used to help prepare a release of the LFS Book.
# Original concept by Matt Burgess <matthew AT linuxfromscratch D0T org>
# Written by Archaic <archaic AT linuxfromscratch D0T org>
#
# To keep this script simple, assumptions were made that require this script to
# be run on belgarath.
#
# Exit Codes:  9 - make     failed
#             19 - tar      failed
#             29 - bzip2    failed
#             39 - xsltproc failed

# First setup a sane environment

set -e                         # Die on all errors
umask 022                      # Set a sane environment
host=`hostname -s`             # Ensure we are building on belg
date=`date +%s`                # Used only for a unique identifier
norm="\e[0;39m"                # Color codes are just for eye candy :)
grn="\e[01;32m"
white="\e[1;37m"
red="\e[01;31m"
yel="\e[1;33m"
export JAVA_HOME=/opt/javabin/java-1.4.2
export FOP_HOME=/opt/javabin/fop-0.20.5
export PATH=$PATH:$JAVA_HOME/bin:$FOP_HOME/bin

#######################
# These are the biggies
stable=n                      # Is this the final release? 'y' or 'n' only
version=6.1-testrelease       # x.y[.z-preX]
#######################

workarea=~/RELEASE-${version} # This is where you will do all your work
testarea=~/public_html/test   # This is where you will view the product
book=LFS-BOOK-${version}      # I'm lazy, hence the shorthand :)
group=lfswww                  # Which group will own the files after copying

# Where the books are to be copied to
view=/home/httpd/www.linuxfromscratch.org/lfs/view
downloads=/home/httpd/www.linuxfromscratch.org/lfs/downloads
archives=/home/httpd/archives.linuxfromscratch.org/lfs-museum

if [ "$host" != "belgarath" ]; then
  echo -e "\n${red}*${white} This script must be run on ${red}belgarath${white}."
  exit 1
fi

# Now prep the $workarea and $testarea

if [ -d "$workarea" ]; then
  echo -e "\n${red}*${grn} $workarea${white} ${red}already exists${white}."
  echo -e "${red}*${white} Moving to ${grn}$workarea-$date${white}...${norm}"
  mv $workarea $workarea-$date
fi
if [ -d "$testarea" ]; then
  echo -e "\n${red}*${grn} $testarea${white} ${red}already exists${white}."
  echo -e "${red}*${white} Moving to ${grn}$testarea-$date${white}...${norm}"
  mv $testarea $testarea-$date
fi

echo -e "\n${grn}*${white} Creating directory ${grn}$workarea${white}...${norm}"
install -d $workarea
cd $workarea
echo -e "${grn}*${white} Checking out the sources...${norm}"
svn export svn://svn.linuxfromscratch.org/LFS/tags/$version/BOOK original >/dev/null
cd $workarea/original

##############
# BIG NOTE!!!!
##############

# A bug in libxml2 (http://bugs.gnome.org/show_bug.cgi?id=309616) causes certain
# failures to still exit with a value of 0. To work around this, stderr must be
# allowed to output to screen and the person running this script must _WATCH_
# for errors. At this stage of the release cycle, there is no excuse for
# validation errors, but never assume they aren't there.

echo -e "${grn}*${white} Validating the sources...${norm}\n"
make validate > $workarea/validate.log || exit 9

# XML is the easiest, so let's do it first.

echo -e "${grn}*${white} Preparing ${grn}$book-XML${white}...${norm}"
cd $workarea
cp -a original $book-XML
tar cWf $book-XML.tar $book-XML || exit 19
bzip2 $book-XML.tar || exit 29
rm -rf $book-XML
echo -e "${grn}*${yel} Successful!${norm}\n"

# Next is regular HTML

echo -e "${grn}*${white} Preparing ${grn}$book-HTML${white}...${norm}"
cd $workarea/original
make BASEDIR=$workarea/$book-HTML >$workarea/html.log 2>&1 || exit 9
cd $workarea
tar cWf $book-HTML.tar $book-HTML || exit 19
bzip2 $book-HTML.tar || exit 29
rm -rf $book-HTML
echo -e "${grn}*${yel} Successful!${norm}\n"

# Next is NOCHUNKS

echo -e "${grn}*${white} Preparing ${grn}$book-NOCHUNKS${white}...${norm}"
cd $workarea/original
make BASEDIR=$workarea NOCHUNKS_OUTPUT=$book-NOCHUNKS.html nochunks \
  >$workarea/nochunks.log 2>&1 || exit 9
cd $workarea
# Before bzipping the NOCHUNKS, create a text dump
lynx -dump $book-NOCHUNKS.html >$book.txt
sed -i.bak -e "/^   [0-9]\. /d" -e "/^  [0-9][0-9]\. /d" \
  -e "/^ [0-9][0-9][0-9]\. /d" -e "/^[0-9][0-9][0-9][0-9]\. /d" \
  $book.txt
bzip2 $book.txt
bzip2 $book-NOCHUNKS.html || exit 29
rm -rf images
echo -e "${grn}*${yel} Successful!${norm}\n"

# Finally, the PDF

echo -e "${grn}*${white} Preparing ${grn}$book.pdf${white}...${norm}"
cd $workarea/original
make BASEDIR=$workarea PDF_OUTPUT=$book.pdf pdf >$workarea/pdf.log 2>&1 || exit 9
echo -e "${grn}*${yel} Successful!${norm}\n"

# Now that the books are finished, create the script that will copy all patches
# to their proper location.

echo -e "${grn}*${white} Creating ${grn}copy-lfs-patches.sh ${white}...${norm}"
cd $workarea/original
xsltproc --xinclude stylesheets/patcheslist.xsl index.xml \
  >$workarea/copy-lfs-patches.sh || exit 39

# Now to create a temporary area inside the $workarea to inspect the compressed
# files

echo -e "${grn}*${white} Unpacking compressed files into ${grn}$testarea${white}...${norm}"
install -d -m 0755 $testarea
cd $testarea
tar jxf $workarea/$book-XML.tar.bz2
tar jxf $workarea/$book-HTML.tar.bz2
bzcat $workarea/$book-NOCHUNKS.html.bz2 >$book-NOCHUNKS.html
bzcat $workarea/$book.txt.bz2 >$book.txt
cp $workarea/$book.pdf .

# Now to cleanup
echo -e "\n${grn}*${white} Cleaning up...${norm}"
cd $workarea
rm -rf original

cat >copy-book.sh << EOF
#!/bin/bash

############################################
# DO NOT EDIT!! THIS IS A GENERATED SCRIPT!!
############################################
#
# This script is used to copy already prepared LFS Books into their proper
# website locations. It is assumed the script and the books are in the current
# directory.

set -e          # Die on all errors
umask 002       # Set a sane environment
stable=$stable        # Don't touch this! It is set in release-script.sh

# First make sure everything is as it should be

groups | grep $group >/dev/null || { echo "You need to be a member of the lfswww group to run this script"; exit 1; }

if [ -d "$view/$version" ]; then
  echo "The $view/$version directory already exists. Halting."
  exit 1
fi

if [ -d "$downloads/$version" ]; then
  echo "The $downloads/$version directory already exists. Halting."
  exit 1
fi

if [ -d "$archives/$version" ]; then
  echo "The $archives/$version directory already exists. Halting."
  exit 1
fi

# Create the new directories

install -dv -m 0775 -g $group $downloads/$version
echo
install -dv -m 0775 -g $group $archives/$version
echo

# If this is a final release, recreate the needed symlinks

if [ "\$stable" = "y" ]; then
  # The archive's stable link is fixed. Don't recreate it.
  rm -f $view/stable
  rm -f $downloads/stable
  ln -sv $version $view/stable
  echo
  ln -sv $version $downloads/stable
  echo
  chgrp $group $view/stable $downloads/stable
fi

# Copy the books

for dir in $downloads $archives; do
  install -v -m 0664 -g $group $book-XML.tar.bz2 \$dir/$version
  echo
  install -v -m 0664 -g $group $book-HTML.tar.bz2 \$dir/$version
  echo
  install -v -m 0664 -g $group $book-NOCHUNKS.html.bz2 \$dir/$version
  echo
  install -v -m 0664 -g $group $book.txt.bz2 \$dir/$version
  echo
  install -v -m 0664 -g $group $book.pdf \$dir/$version
  echo
done

# Now untar a copy in both archives and in view

# NOTE: Tar sucks. They change the names of arguments and I can't be arsed to
# put in code to check for the installed version. Therefore, this script will
# remain agnostic and do things the old-fashioned (and very inefficient) way.
# But hey, it works.

cd $archives/$version
tar jxf $book-HTML.tar.bz2
chmod -R g+w $book-HTML
chgrp -R $group $book-HTML

cd $view
tar jxf $downloads/$version/$book-HTML.tar.bz2
mv $book-HTML $version
chmod -R g+w $version
chgrp -R $group $version

exit 0
EOF

echo -e "\n${grn}*${white} All Finished!${norm}"
echo -e "\n${grn}* *${white} Please verify ${yel}all${white} log files in ${grn}$workarea${white}."
echo -e "\n${grn}* *${white} and ${yel}all${white} files in ${grn}$testarea${white}."
echo -e "\n${grn}* *${white} The ${yel}text ${white}version of the book specifically \
needs to be inspected to ensure that"
echo -e "${grn}* * ${yel}all${white} and ${yel}only${white} the desired stuff was removed (references).${norm}"

exit 0
