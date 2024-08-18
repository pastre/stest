#!/bin/bash

source 'stest.sh'

verify 'Overwrites unexistent commands' succeeds <<tset
	source 'smock.sh'
	replace 'mycommandd'; with 'echo success'
	mycommandd || fail 'Expected the command to be overwritten'
tset

