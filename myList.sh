#! bash

# myList.sh variable.html - creates html document, variable, listing the top 
# call explicitly with "bash ./myList.sh variable.html"

#Seawolves
#AJ, Shaina, David

filename=$1
i=1
numOfSlashes=0
slash="/"

#getting top
#Attempt to count slashes, subtract 2 to get number of traversals to parent necessary
#Only problem seems to be identifying slashes-- or the first loop doesnt run correctly
thisPath=$(pwd)
length=$(expr length $thisPath)
echo $thisPath
echo $slash
for i in {1..$length}
do
	echo $i
	letter=$(expr substr $thisPath $i 1)
	echo $letter
	if [ "$letter" == "$slash" ]
	then
		numOfSlashes=$(($numOfSlashes + 1))
	fi
done
numOfTraversals=$(($numOfSlashes - 2))
echo $numOfTraversals
i=0
for i in {0..$numOfTraversals}
do
	echo "in loop"
	cd ..
done

#get contents
contents=$(ls)

#could format contents?

#creating and writing html file--everything below here is 100%
cat <<- _Output > $filename
	<html>
	<head>
		<title>
		myList Results
		</title>
	</head>

	<body>
	<h1>Results:</h1>
	The current path is $thisPath.<br>
	Contents of Top Level:<br>
	$contents
	</body>
	</html>
_Output

#opening created html file
xdg-open $filename
