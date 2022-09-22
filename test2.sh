#!/bin/bash


function get_digit() {
	IFS=$'\n' 
	for string in $(sed '/^#/d' $file|sed 's/ = /=/g')
	do
		param=${string%%=*}
		if [ "$param" = "$opt" ]; then
			eval $string
		fi
	done
	if [ $Foo -ge $expected_value ]; then
		return 0
	else
		return 1
	fi
}

function foobar_foo_gte_10() {
	file="/tmp/foobar2"
	opt="Foo"
	expected_value="10"
	assert_msg="Option '$opt' is greater than or equal to '$expected_value' in '$file'"

	if get_digit; then
		echo "PASS - $assert_msg"
		return 0
	else
		echo "FAIL - $assert_msg"
		return 1
	fi
}

foobar_foo_gte_10
