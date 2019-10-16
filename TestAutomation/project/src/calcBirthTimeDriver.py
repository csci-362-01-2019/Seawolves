import agepicker
import sys #import for the library that allows grabbing command line args

#sys.argv[n] is the string array that holds the command line args, n=0 is the name of the python file being run n >= 1 are the args being sent in after the filename

#since the arguments are considered strings we have to cast to either an int or float value. This will be handled by making the first argument after the filename being the type that is being sent

#ex. python calcBirthTimeDriver.py int 5
#this will run the driver with the input as an interger 5
if sys.argv[1] == "int": 
	testInput = int(sys.argv[2])	
elif sys.argv[1] == "float":
	testInput = float(sys.argv[2])
else:
	testInput = sys.argv[2]

#calling the method with the given input and printing the result
returnVal = agepicker.calculate_birth_timestamp(testInput)
print(returnVal)

