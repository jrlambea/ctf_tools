#!/bin/bash

#############################################
#
# Bacon Cipher
#
# 01_baconing.sh -e "hola" "estaeslamascaraausar"
# 01_baconing.sh -d "ERTNYECPD"


function encrypt
{
	bacon=""
	typeset -l bacon
	bacon="$encrypted"
	abc="agntbhovcipwdkqxelryfmsz"
	abcbacon="AAAAA AABBA ABBAA BAABA AAAAB AABBB ABBAB BAABB AAABA ABAAA ABBBA BABAA AAABB ABAAB ABBBB BABAB AABAA ABABA BAAAA BABBA AABAB ABABB BAAAB BABBB"
	
	bacon=$(echo $bacon | sed 's/j/i/g' | sed 's/u/v/g')

	for (( i = 0; i < $len; i++ )); do
		((c=$i+1))
		char="$(echo $bacon | cut -c$c )"
		index="`expr index $abc $char`"
		mask="$mask`echo $abcbacon | cut -d" " -f$index`"

	done

	echo $mask
	echo $mascara

	lowercase=""
	uppercase=""
	output=""

	typeset -l lowercase
	typeset -u uppercase

	((len=$len*5))

	for (( i = 0; i < $len; i++ )); do
		((c=$i+1))
		mchar="`echo $mask | cut -c$c`"

		if [[ $mchar == "A" ]]; then
			lowercase="`echo $mascara | cut -c$c`"
			output="$output$lowercase"
		elif [[ $mchar == "B" ]]; then
			uppercase="`echo $mascara | cut -c$c`"
			output="$output$uppercase"
		fi

	done

	echo $output

}

function decrypt
{
	bacon=""
	typeset -u bacon
	bacon="$(echo $encrypted | sed 's/[a-z]/a/g' | sed 's/[A-Z]/B/g' | sed 's/ //g')"
	len="$( echo $bacon | wc -c )"

	bacon_full=""

	for (( i = 1; i < $len; i++ )); do
		nextChar="$( echo $bacon | cut -c$i)"
		echo -n "$nextChar"
		bacon_full="$bacon_full$nextChar"
		
		(( mod=$i%5 ))

		if (( $mod == 0 )); then
			echo -n " "
			bacon_full="$bacon_full "
		fi

	done

	echo

	index=1
	
	for b in "AAAAA" "AABBA" "ABBAA" "BAABA" "AAAAB" "AABBB" "ABBAB" "BAABB" "AAABA" "ABAAA" "ABBBA" "BABAA" "AAABB" "ABAAB" "ABBBB" "BABAB" "AABAA" "ABABA" "BAAAA" "BABBA" "AABAB" "ABABB" "BAAAB" "BABBB"
	do
		
		abc="agntbhovcipwdkqxelryfmsz"
		bacon_full="$(echo $bacon_full | sed 's/'$b'/'"$(echo $abc | cut -c$index)"'/g')"
		((index=$index+1))

	done

	echo

	echo $bacon_full
}

encrypted="$2"
mascara="$3"

if ( ! echo $cols | grep "^[0-9]*$" > /dev/null ); then
	echo "USO: 01_baconing.sh -e \"ENCRYPTED\""
 	echo "     01_baconing.sh -d \"ERTNYECPD\""
	exit 2
fi

len="$( echo $encrypted | wc -c )"
((len=$len-1))


case $1 in
	"-e" )	echo "Encrypt..."
			encrypt
		;;
	"-d" )	echo "Decrypt..."
			decrypt
		;;
	* ) 	echo "USO: 01_baconing.sh -e \"ENCRYPTED\""
 			echo "     01_baconing.sh -d \"ERTNYECPD\""
			exit 2
esac
