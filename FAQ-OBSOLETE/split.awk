#!/usr/bin/awk -f

# usage: split.awk faq.xml
# produces: faq.lfs-dev.xml, faq.lfs-support.xml, faq.lfs-compile.xml,
#	faq.blfs-support.xml, and faq.new.xml, using comments in faq.xml
#
# this thing has no concept of a syntax error, so if you've updated the faq
# and something is wrong, enable DEBUG and pipe the output to less.
#
# the faq may provide enough examples to learn this script's use, and
# the source itself should be simple enough, but some documentation here
# is in order anyway. first, an example, and then comments:
#
# <!-- dlist: ,lfs-dev,lfs-support,lfs-compile,blfs-support,new -->
# <qandadiv><title>The Deeper Questions</title>
# <!-- elist: ,lfs-support,blfs-support -->
# <qandaentry>
# <question><para>Why?</para></question>
# <answer><para>Because.</para></answer>
# </qandaentry>
# <!-- elist: ,lfs-dev --><!-- they mustn't know that we know...
# <qandaentry>
# <question><para>Who are "they"?</para></question>
# <answer><para>You really don't want to know.</para></answer>
# <qandaentry>
# </qandadiv>
# -->
#
# + it's not a comma separated list of lists. each marker starts with a comma.
# + never forget to mark the qandadiv for inclusion in every list it has
#   a qandaentry marked for.
# + never mark a qandadiv for inclusion in a list it doesn't have a qandaentry
#   marked for.
# + carefully observe how the entry above is commented out. other ways may
#   produce errors depending on whether the commented section is included
#   in the current part.

BEGIN {
	DEBUG=0

	dd=0
	d["d", dd]=d["s", dd]=d["c", dd]=d["b", dd]=d["n", dd]=1
	e["d"]=e["s"]=e["c"]=e["b"]=e["n"]=1

	# d[] is for qandadiv
	# dd  is for qandadiv depth
	# e[] is for qandaentry
	# "d" is for lfs-dev
	# "s" is for lfs-support
	# "c" is for lfs-compile
	# "b" is for blfs-support
	# "n" is for new
	# d[] and e[] are handled differently because qandaentry doesn't nest while
	# qandadiv does. d[] is a stack (ex: d["?", d]) while e[] isn't. actually,
	# they could be handled similarly, but it would be confusing to handle e[]
	# like a stack but not use it as one.

	printf "" > "faq.lfs-dev.xml"
	printf "" > "faq.lfs-support.xml"
	printf "" > "faq.lfs-compile.xml"
	printf "" > "faq.blfs-support.xml"
	printf "" > "faq.new.xml"
}
{
	if (DEBUG) {
		printf "dd%i d[d%02i s%02i c%02i b%02i n%02i] e[d%02i s%02i c%02i b%02i n%02i] ",
		dd, d["d", dd], d["s", dd], d["c", dd], d["b", dd], d["n", dd],
		e["d"], e["s"], e["c"], e["b"], e["n"]
	}
	if (d["d", dd] > 0 && e["d"] > 0) {
		if (DEBUG) { printf "d" }
		print $0 >> "faq.lfs-dev.xml"
	}
	if (d["s", dd] > 0 && e["s"] > 0) {
		if (DEBUG) { printf "s" }
		print $0 >> "faq.lfs-support.xml"
	}
	if (d["c", dd] > 0 && e["c"] > 0) {
		if (DEBUG) { printf "c" }
		print $0 >> "faq.lfs-compile.xml"
	}
	if (d["b", dd] > 0 && e["b"] > 0) {
		if (DEBUG) { printf "b" }
		print $0 >> "faq.blfs-support.xml"
	}
	if (d["n", dd] > 0 && e["n"] > 0) {
		if (DEBUG) { printf "n" }
		print $0 >> "faq.new.xml"
	}
	if (DEBUG) { printf ": %s\n", $0 }
}
/^<!-- elist: / {
	if (DEBUG) {
		print "+++ e set +++++++++++++++++++++++++++++++++++++++++++++++++"
	}
	e["d"]=index($0, ",lfs-dev")
	e["s"]=index($0, ",lfs-support")
	e["c"]=index($0, ",lfs-compile")
	e["b"]=index($0, ",blfs-support")
	e["n"]=index($0, ",new")
}
/^<!-- dlist: / {
	dd++
	d["d", dd]=index($0, ",lfs-dev")
	d["s", dd]=index($0, ",lfs-support")
	d["c", dd]=index($0, ",lfs-compile")
	d["b", dd]=index($0, ",blfs-support")
	d["n", dd]=index($0, ",new")
	if (DEBUG) {
		printf "+-+ d set %i +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n",
		dd 
	}
}
/<\/qandaentry>$/ {
	if (DEBUG) { 
		print "--- e reset -----------------------------------------------"
	}
	e["d"]=e["s"]=e["c"]=e["b"]=e["n"]=1
}
/<\/qandadiv>/ {
	dd--
	if (DEBUG) { 
		printf "=-= d reset %i =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n",
		dd
	}
}
