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

def validate_key (key):

	c = len(key)

	for i in range(c):
		if str(i) not in key:
			return False

	return True

def print_block (block, key):

	for c in range(len(block)):
		print ("%c" % block[int(key[c])], end = "")

def main ():

	parser = argparse.ArgumentParser()
	parser.add_argument ("text", help = "Message to encrypt/decrypt", type = str)
	parser.add_argument ("key", help = "Key to do the encryption", type = str)
	parser.add_argument ("-p", "--padding-character", help = "Key to do the encryption", type = str, default = " ")
	parser.add_argument ("-r", "--remove-spaces", help = "Avoid the spaces.", action = "count", default = 0)
	args = parser.parse_args()

	key = args.key.split(",")
	count = len(key)
	block = ""

	if args.remove_spaces > 0:
		text = args.text.replace(" ", "")
	else:
		text = args.text

	if not validate_key (key):
		print ("The key is invalid")
		sys.exit (5)

	for i in range(len(text) % len(key)):
		text += args.padding_character

	for c in text:
		block += c
		
		if len(block) == len(key):
			print_block (block, key)
			print (" ", end = "")
			block = ""
		
	print ()

if __name__ == "__main__":
    main()
