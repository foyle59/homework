#!/bin/bash

file="/tmp/foobar2"
TestList=("Foo" "Bar" "FooBar")
opt="Foo"
expected_value="10"

if [ -f "$file" ]; then
	rm $file
fi

function FillFooBar() {
	for (( i=0; i<100; i++ ))
	do
		rN=$((0 + $RANDOM % 3))
		case ${TestList[$rN]} in
			Foo)
				randomFoo=$((0 + $RANDOM % 20))
				echo "Foo = $randomFoo">>$file
				;;
			Bar)
				echo "Bar=\"hello world\"">>$file
				;;
			FooBar)
				echo "FooBar=0">>$file
				;;
		esac
	done
}

function get_digit() {
        IFS=$'\n' 
	n=0
        for string in $(sed '/^#/d' $file|sed 's/ = /=/g')
        do
                param=${string%%=*}
                if [ "$param" = "$opt" ]; then
                	let n++
                        eval $string
                fi
        done
	echo "Entrys of Foo in $file: " $n
	echo "Value of last Foo is: " $Foo
        if [ $Foo -ge $expected_value ]; then
                return 0
        else
                return 1
        fi
}

function foobar_foo_gte_10() {
        file="/tmp/foobar2"
        assert_msg="Option '$opt' is greater than or equal to '$expected_value' in '$file'"

        if get_digit; then
                echo "PASS - last value of Foo:" $Foo
                return 0
        else
                echo "FAIL - last value of Foo:" $Foo
                return 1
        fi
}

FillFooBar
foobar_foo_gte_10
