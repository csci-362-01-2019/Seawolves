#! bash

# myList.sh variable.html - creates html document, variable, listing the contents of the top level directory
# call explicitly with "bash ./myList.sh variable.html"

#Seawolves
#AJ, Shaina, David


filename=$1

#count number of slashes in path
numOfSlashes=0
slash="/"
thisPath=$(pwd)
length=$(expr length $thisPath)

for ((i=1;i<length;i++))
do
	letter=$(expr substr $thisPath $i 1)
	if [ "$letter" == "$slash" ]
	then
		#echo "found slash"
		numOfSlashes=$(($numOfSlashes + 1))
	fi
done

#should call cd .. the same number of slashes to get past home directory
for ((i=0;i<numOfSlashes - 2;i++))
do
	#echo "in loop"
	cd ..
done

#get contents
contents=$(ls)

#go back down to create html file with permission to do so
cd $thisPath

#creating and writing html file
cat <<- _Output > $filename
	<html>
	<head>
		<title>
		myList Results
		</title>
	</head>

	<body>
	<h1>Results:</h1>
	Contents of Top Level:<br>
	$contents
	</body>
	</html>
_Output

#opening created html file
xdg-open $filename
