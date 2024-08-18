TEST_RUN_FOLDER=${TEST_RUN_FOLDER:-"$TMPDIR"}

verify() {
	TEST_CASE_NAME=$1
	EXPECTATION=$2
	TEST_CASE="$(cat <&0)"
	TEST_FOLDER="$TEST_RUN_FOLDER/$(md5 <<< $TEST_CASE_NAME)"
	mkdir -p $TEST_FOLDER
	echo "Running $TEST_CASE_NAME" > "$TEST_FOLDER/status"
	bash -c "$TEST_CASE" > "$TEST_FOLDER/result"
	if test 0 -eq $? && test "succeeds" = $EXPECTATION; then
		echo "$TEST_CASE_NAME: Passed" > "$TEST_FOLDER/status"
	elif test 0 -ne $? && test "fails" = $EXPECTATION; then
		echo "$TEST_CASE_NAME: Passed" > "$TEST_FOLDER/status"
	else
		echo "$TEST_CASE_NAME: Failed" > "$TEST_FOLDER/status"
		cat  "$TEST_FOLDER/result"
	fi
}

# If it was not sourced, we should run all tests in directory
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 0;


echo "Running tests in $PWD"
mkdir -p $TEST_RUN_FOLDER

FILES="$(find . -name '*_test.sh')"
if [ -z "$FILES" ]; then
	echo 'No test files found!'
	exit 1
fi

find . -name '*_test.sh' | while read file; do
	bash $file
done

find $TEST_RUN_FOLDER -name 'status' | while read file; do
	cat "$file"
done