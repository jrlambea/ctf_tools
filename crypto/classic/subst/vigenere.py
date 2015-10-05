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
	parser.add_argument ("key", help = "Key to encrypt/decrypt", type = str)
	parser.add_argument ("-a", "--alphabet", help = "Alphabet to use", type = str, default = 'abcdefghijklmnopqrstuvwxyz')
	parser.add_argument ("-c", "--case-insensitive", help = "Does not distinguish between lower and uppercase.", action = "count", default = 0)
	args = parser.parse_args()

	case_insensitive = args.case_insensitive

	if case_insensitive > 0:
		text = args.text.lower()
		alphabet = args.alphabet.lower()
		key = args.key.lower()

	else:
		text = args.text
		alphabet = args.alphabet
		key = args.key


	k = 0
	i = 0

	for c in text:
		if k == len(key):
			k = 0

		d = alphabet.index (key[k])

		if c in alphabet:
			char = alphabet [(alphabet.index (c) + d) % len (alphabet)]
			print ("%s" % char, end = "")
		else:
			print ("%s" % c, end = "")

		k += 1

	print ()

if __name__ == "__main__":
    main()
