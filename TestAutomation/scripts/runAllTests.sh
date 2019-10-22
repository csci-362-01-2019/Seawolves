#! bash

# AJ, Shaina, David via Seawolves
# call explicitly from TestAutomation Folder with "bash ./scripts/runAllTests.sh" from testCasesExcecutables
# chmod 755 the script if it doesn't run
# runs every test in the testCase folder and outputs an html document with results available in reports folder

# **********
#might need to know output type
#fix array problems

# goto testCases
#cd ..
cd testCases

# array where the files of the testCases are kept
testCaseArray=($(ls))

#echo ${testCaseArray[*]}
#echo ${testCaseArray[4]}
# array where results of tests are stored
results=()
failures=()
failures+=("<h1>Failures:</h1>")

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
	else 
		result=("FAIL!")
		#failures+=("testCase$testCase --- $driverMethod<br>input:$testInput<br>output:$driverOutput<br>oracle:$oracle<br><br>")
	fi
	# compare strings use = instead
	# result="whatever"
	# store results
	results+=("<tr><td>$testCase</td><td>$requirement</td><td>$driverMethod</td><td>$testInput</td><td>$driverOutput</td><td>$oracle</td><td>$result</td></td>")

	#goto cases folder
	cd ..
	cd ..
	cd testCases
done

# goto results folder, I didn't here. I went to script
cd ..
cd reports

# Don't show failures heading if there are none
f=${#failures[@]}
if [ $f -eq 1 ]
	then failures=()
fi

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
	<table border="1" style="table-layout: fixed; width: 100%">
		<tr><th>Test Case</th><th>Requirement</th><th>Method</th><th>Input</th><th>Output</th><th>Oracle</th><th>Result</th></tr>
		${results[*]}
	</table>
	</body>
	</html>
_Output

xdg-open $FILENAME

