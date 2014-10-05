#!/bin/bash
abc='abcdefghijklmnopqrstuvwxyz'
w="$3"
t="$2"
f="$1"

if (( $# != 3 )); then
	echo "USO: $0 [-d|-e] [plaintext|crypto] passphrase"
	exit 5
fi

if ( ! $( echo $w | grep '^[a-z,A-Z,0-9]*$' > /dev/null ) );then
	echo "La passphrase sólo puede tener carácteres alfabéticos."
	exit 2
fi

len="`echo -n $abc | wc -c`"
len_w="`echo -n $w | wc -c`"
len_t="`echo -n $t | wc -c`"
r="$w"

(( mod=$len_t % $len_w ))

if (( $mod != 0 )); then
	echo "La longitud del texto debe ser divisible por la longitud de la passphrase. Mod = $mod."
	exit 3
fi

for (( i = 1; i < $len; i++ )); do
	char="`echo $abc | cut -c$i`"
	r="`echo $r | sed 's/'$char'//'`"
done

if [[ $r != "" ]]; then
	echo "Hay carácteres repetidos o no ASCII en la passphrase."
	exit 4
fi

function encriptar {
	for (( i = 1; i <= $len_w; i++ )); do
		char="`echo $w | cut -c$i`"
		values=$values`printf '%d ' "'$char"`
	done

	code="`echo $values | tr ' ' '\n' | nl | sort -nk2 | cut -f1`"

	echo "Utilizando clave: "$code

	(( chunks=$len_t/$len_w ))

	echo "En total hay $chunks chunks."
	for (( i = 0; i < $chunks; i++ )); do

		if (( $i == 0 )); then
			m=1
		else
			((m=$i*$len_w+1))
		fi

		((l=$m+$len_w-1))

		chunk="`echo $t | cut -c$m-$l`"
		#echo "Chunk $i: $chunk"

		for a in $code
		do
			c="`echo -n $chunk | cut -c$a`"
			echo -n $c
		done

	done

	echo
}

function desencriptar {
	for (( i = 1; i <= $len_w; i++ )); do
		char="`echo $w | cut -c$i`"
		values=$values`printf '%d ' "'$char"`
	done

	code="`echo $values | tr ' ' '\n' | nl | sort -nk2 | cut -f1`"

	echo "Utilizando clave: "$code

	(( chunks=$len_t/$len_w ))

	echo "En total hay $chunks chunks."
	for (( i = 0; i < $chunks; i++ )); do

		if (( $i == 0 )); then
			m=1
		else
			((m=$i*$len_w+1))
		fi

		((l=$m+$len_w-1))

		chunk="`echo $t | cut -c$m-$l`"
		#echo "Chunk $i: $chunk"

		x=1
		c=""
		for a in $code
		do
			c="$c;$a `echo -n $chunk | cut -c$x`"
			((x=$x+1))
		done
		
		result="$result"`echo -n $c | tr ";" "\n" | sort -nk1 | cut -d" " -f2`

	done

	echo $result | tr " " "\0"
}

case $f in
	"-e" ) 	echo "Encriptando..."
			encriptar
		;;
	"-d" )	echo "Desencriptando..."
			desencriptar
		;;
	*	 ) 	echo "USO: $0 [-d|-e] [plaintext|crypto] passphrase"
			exit 5
		;;
esac

