# Create your grading script here

rm -rf stderr.txt
rm -rf student-submission
git clone $1 student-submission
cd student-submission
if  ! [ -e ListExamples.java ]

	then
		echo "ListExamples.java file not found"
		exit 1

	else
		cp ListExamples.java ./../
		cd ..
		javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> stderr.txt
fi

echo 

[ -s stderr.txt ]

if [ $? -eq 0 ]

then
	echo "ListExamples.java file can't compile!"
	exit 1

else
	echo "ListExamples.java file is compiled successfully!"
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > stdout.txt

COUNT_FILTER=$(grep -c "testFilter" stdout.txt)

COUNT_MERGE=$(grep -c "testMerge" stdout.txt)

PASSED_FILTER=$(echo "1-$COUNT_FILTER/2" | bc)

PASSED_MERGE=$(echo "2-$COUNT_MERGE/2" | bc)

echo "you passed $PASSED_FILTER out of 1 test for filter() method!"

echo "you passed $PASSED_MERGE out of 2 for merge() method!"
