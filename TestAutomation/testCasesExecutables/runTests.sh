#! bash

# AJ, Shaina, David from Seawolves
# call explicitly with "bash ./runTests.sh" from testCasesExcecutables
# chmod 755 the script if it doesn't run
# runs every test in the testCase folder and outputs an html document with results

# **********
#might need to know output type
#fix array problems

# goto testCases
cd ..
cd testCases

# array where the files of the testCases are kept
testCaseArray=($(ls))

#echo ${testCaseArray[*]}
#echo ${testCaseArray[4]}
# array where results of tests are stored
results=()

i=0
length=${#testCaseArray[@]}

# loops through test cases with i
for ((i=0;i<length;i++))
do
	input=${testCaseArray[$i]}
	# input=testCase0.txt if you only want to do a specific case

	j=0
	# reading lines of testCase
	while IFS= read -r line
	do
		if [ $j -eq 0 ]
			then testCase=$line
		fi
		if [ $j -eq 1 ]
			then requirement=$line
		fi
		if [ $j -eq 2 ]
			then driver=$line
		fi
		if [ $j -eq 3 ]
			then driverMethod=$line
		fi
		if [ $j -eq 4 ]
			then testInput=$line
		fi
		if [ $j -eq 5 ]
			then oracle=$line
		fi
		j=$((j+1))
	done < "$input"
	
	# goto python file folder
	cd ..
	cd project
	cd src

	# run driver or python file directly
	driverOutput=$(python -c "import $driver; print($driverMethod($testInput))")
	# echo $driverOutput

	# compare numbers
	if [ $driverOutput = $oracle ]
		then result=("Pass")
	else result=("FAIL!")
	fi
	# compare strings use = instead
	# result="whatever"
	# store results
	results+=("testCase$testCase --- $driverMethod --- out - $driverOutput - oracle - $oracle --- $result <br>")

	#goto cases folder
	cd ..
	cd ..
	cd testCases
done

# goto results folder, I didn't here. I went to script
cd ..
#cd testCasesExcecutables

# produce html document
FILENAME=testResults.html
cat <<- _Output > $FILENAME
	<html>
	<head>
		<title>
		Test Results
		</title>
	</head>

	<body>
	<h1>Test Results:</h1>
	${results[*]}
	</body>
	</html>
_Output

xdg-open $FILENAME

