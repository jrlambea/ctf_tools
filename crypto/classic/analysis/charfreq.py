#!/usr/bin/env python3

__author__ = "JR. Lambea"
__copyright__ = "Copyright 2015"
__credits__ = ["JR. Lambea"]
__license__ = "GPL"
__version__ = "1.0.0"
__maintainer__ = "JR. Lambea"
__email__ = "jr.lambea@yahoo.com"
__status__ = ""

import sys
import argparse

def main():

	parser = argparse.ArgumentParser()
	parser.add_argument ("text", help = "Message to analyze", type = str)
	parser.add_argument ("-a", "--alphabet", help = "Create an alphabet with the supplied text", action="count", default = 0)
	parser.add_argument ("-q", "--quiet", help = "Does not show the char statistics", action="count", default = 0)
	args = parser.parse_args()

	alphabet = ""
	text = args.text
	d = {}

	for c in text:
		if c not in d:
			d[c] = 0

		d[c] = (d[c] + 1)

	for o in sorted(d, key=d.get, reverse=True):
		percent = 100 / len(text) * d[o]
		if args.quiet < 1:
			print ("\"%s\" (%i): %i%%" % (o, d[o], percent), file = sys.stderr)
		alphabet = alphabet + o

	if args.alphabet >= 1:
		print ("%s" % alphabet)

if __name__ == "__main__":
    main()
