#!/usr/bin/bash

progress() {
	local i=$1
	local len=$2
	local char_len=50
	local perc=$((i * 100 / len))
	local bars=$((perc * char_len / 100))

	local j
	local char='['
	for ((j = 0; j < bars; j++)); do
		char+='#'
	done
	for ((j = bars; j < char_len; j++)); do
		char+='-'
	done
	char+=']'

	echo -ne "$char $i/$len ($perc%)\r"
}

process() {
	local files=("$@")

	sleep .01
}

shopt -s globstar nullglob

echo 'finding files'
find . -name '*cache'

files=(./**/*cache)

len=${#files[@]}

echo "Found: $len file(s)"

batch=1
for ((i= 0; i < len; i +=batch)); do
	progress "$((i+1))" "$len"
	process "${files[@]:i:batch}"
done
process "$len" "$len"

echo
