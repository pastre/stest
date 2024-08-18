replace() {
	export COMMAND_TO_REPLACE=$1
}

with() {
	if [ -z "${COMMAND_TO_REPLACE-}" ]; then
		echo 'Trying to replace and empty command!'
		exit -1
	fi
	OVERWRITE="$COMMAND_TO_REPLACE() { $1; }"
	eval $OVERWRITE
}
