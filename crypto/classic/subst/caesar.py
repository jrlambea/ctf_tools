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
	parser.add_argument ("text", help = "message to encrypt/decrypt", type = str)
	parser.add_argument ("-d", "--displacement", help = "number of positions to displace", type = int, default = 3)
	parser.add_argument ("-a", "--alphabet", help = "alphabet to use", type = str, default = 'abcdefghijklmnopqrstuvwxyz')
	args = parser.parse_args()

	alphabet = args.alphabet
	d = args.displacement
	text = args.text

	for c in text:
		if c in alphabet:
			char = alphabet [(alphabet.index (c) + d) % len(alphabet)]
			print ("%s" % char, end = "")
		else:
			print ("%s" % c, end = "")

	print ()

if __name__ == "__main__":
    main()
