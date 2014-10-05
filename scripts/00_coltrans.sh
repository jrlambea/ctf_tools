#!/bin/bash

#############################################
#
# Columnar Transposition
#
#  ENC
#  RYP = ERTNYECPD
#  TED
#
# 00_coltrans.sh -e "ENCRYPTED" 3
# 00_coltrans.sh -d "ERTNYECPD" 3


function encrypt
{
	x=1

	for (( i = 1; i <= $cols; i++ )); do

		for (( x=$i; x <= $len; ((x=$x+$cols)) )); do

			nya="$( echo -n $encrypted | cut -c$x )"
			echo -n "$nya"

		done

	done

	echo
}

function decrypt
{
	((modulus=$len%$cols))
	((division=$len/$cols))
	echo "Modulus: $modulus"
	echo "Div: $division"
	decrypted=""
	index=1

	#if (( $modulus > 0 )); then
	#	(( division=$division+1 ))
	#fi

	dlen=1
	x=$modulus

	nextChar="$(echo ${encrypted} | cut -c$index)"
	echo -n "$nextChar"

	while (( $dlen < $len ))
	do

		(( dlen=$dlen+1 ))
		
		if (( $x > 0 )); then
			sum=1
			(( x=$x-1 ))
		else
			sum=0
		fi
		
		(( index=$index+$division+$sum ))
		#echo $index

		if (( $index > $len )); then
			
			if (( $modulus == 0 )); then
				
				(( index=$index-$len+1 ))

			else
				x=$modulus
				(( index=$index-$len+1 ))
			fi
		fi

		nextChar="$(echo ${encrypted} | cut -c$index)"
		echo -n "$nextChar"

	done

	echo

}

encrypted="$2"
cols=$3

if ( ! echo $cols | grep "^[0-9]*$" > /dev/null ); then
	echo "USO: 00_coltrans.sh -e \"ENCRYPTED\" 3"
 	echo "     00_coltrans.sh -d \"ERTNYECPD\" 3"
	exit 2
fi

len="$( echo $encrypted | wc -c )"
((len=$len-1))

if (( $len <= $cols ));then
	echo "El numero de columna no puede ser mayor que la longitud del cripto!"
	exit 3
fi


case $1 in
	"-e" )	echo "Encrypt..."
			encrypt
		;;
	"-d" )	echo "Decrypt..."
			decrypt
		;;
	* ) echo "USO: 00_coltrans.sh -e \"ENCRYPTED\" 3"
 		echo "     00_coltrans.sh -d \"ERTNYECPD\" 3"
		exit 2
		;;
esac
