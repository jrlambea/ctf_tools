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
	parser.add_argument ("text", help = "Message to encrypt/decrypt", type = str)
	parser.add_argument ("-d", "--displacement", help = "Number of positions to displace", type = int, default = 3)
	parser.add_argument ("-a", "--alphabet", help = "Alphabet to use", type = str, default = 'abcdefghijklmnopqrstuvwxyz')
	parser.add_argument ("-b", "--brute-force", help = "Encode the given text for all the chars given in alphabet", action = "count", default = 0)
	args = parser.parse_args()

	alphabet = args.alphabet
	d = args.displacement
	text = args.text

	if args.brute_force > 0:
		for l in alphabet:
			d = alphabet.index (l)
			
			for c in text:
				if c in alphabet:
					char = alphabet [(alphabet.index (c) + d) % len (alphabet)]
					print ("%s" % char, end = "")
				else:
					print ("%s" % c, end = "")
			print (" -- Using key: %c (%i)" % (l, d))

		sys.exit (0)


	for c in text:
		if c in alphabet:
			char = alphabet [(alphabet.index (c) + d) % len (alphabet)]
			print ("%s" % char, end = "")
		else:
			print ("%s" % c, end = "")

	print ()

if __name__ == "__main__":
    main()
