TEST_RUN_FOLDER=${TEST_RUN_FOLDER:-"$TMPDIR/stest"}
verify() {
	TEST_CASE_NAME=$1
	EXPECTATION=$2
	TEST_CASE="$(cat <&0)"
	TEST_FOLDER="$TEST_RUN_FOLDER/$TEST_CASE_NAME"
	mkdir -p "$TEST_FOLDER"
	echo "Running $TEST_CASE_NAME" > "$TEST_FOLDER/status"
	bash -c "$TEST_CASE" 2>&1 > "$TEST_FOLDER/result"
	if test 0 -eq $? && test "succeeds" = $EXPECTATION; then
		echo "$TEST_CASE_NAME: Passed" > "$TEST_FOLDER/status"
	elif test 1 -eq $? && test "fails" = $EXPECTATION; then
		echo "$TEST_CASE_NAME: Passed" > "$TEST_FOLDER/status"
	else
		echo "$TEST_CASE_NAME: Failed" > "$TEST_FOLDER/status"
	fi
}

# If it was not sourced, we should run all tests in directory
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 0;


echo "Running tests in $PWD. Results are stored in $TEST_RUN_FOLDER"
mkdir -p $TEST_RUN_FOLDER

FILES="$(find . -name '*_test.sh')"
if [ -z "$FILES" ]; then
	echo 'No test files found!'
	exit 1
fi

find . -name '*_test.sh' | while read file; do
	bash $file
done

TEST_FAILED=$(grep -Ril "Failed" $TEST_RUN_FOLDER)

if [ -n "$TEST_FAILED" ]; then
	echo "Tests failed"
	grep -Ril "Failed" $TEST_RUN_FOLDER | while read file; do
		cat $file
	done
	exit -1
else
	echo "All tests passed"
fi
