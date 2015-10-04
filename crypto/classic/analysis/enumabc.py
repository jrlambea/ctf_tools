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
	parser.add_argument (
		"-l",
		"--language",
		help = "Filter the output by language",
		choices = ["en", "fr", "de", "es", "pt", "eo", "it", "tr", "sv", "pl", "nl", "da", "is", "fi", "cs"],
		default = "all"
		)

	args = parser.parse_args()

	abc = {
		"en" : "etaoinshrdlcumwfgypbvkjxqz",
		"fr" : "esaitnruoldcmpvqfbghjxzeyw",
		"de" : "ensriatdhulgcomwbfkzvpjyxq",
		"es" : "eaosrnidltcmupbgvyqhfjzxwk",
		"pt" : "aeosridmntculpvgqbfhzjxwky",
		"eo" : "aieonlsrtkjudmpvgfbczhqxwy",
		"it" : "eaionlrtscdpumvgzfbhqwyjkx",
		"tr" : "aeinrlkdmytusobzcghvpfjqwx",
		"sv" : "eanrtsildomkgvhfupbcyjxwzq",
		"pl" : "aieonwrszcdyklmtpujbghfvxq",
		"nl" : "enatirodslgvhkmubpwjzcfxyq",
		"da" : "erntaidslogkmfvbuphjycwzxq",
		"is" : "arniestulgmkfvohdjbypxcwzq",
		"fi" : "aintesloukmrvjhpydgbcfwzxq",
		"cs" : "aeonitvsrldkmupzjhybcgfxwq"
	}


	if args.language != "all":
		print ("%s" % abc[args.language])
	else:
		for a in abc:
			print ("%s: %s" % (a, abc [a]))


if __name__ == "__main__":
    main()
