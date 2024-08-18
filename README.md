# stest

## Installation
Figuring this out now, will probably be a brew formula

## Usage
`stest` will treat all files ending with `_test.sh` as test scripts. It will run each of these scripts and report the results.

`smock` will replace the execution of a command with a different command. This is useful for testing scripts that depend on external commands.

The library assumes that programs that exit with a zero exit code are successful and those that exit with a non-zero exit code are failures.

Testing that a script returns with a zero exit code
```bash
verify 'when git is installed then it should pass' succeeds <<test
    source 'smock.sh'
    replace 'git'; with 'echo'
    ./my_script.sh
test
```

Testing that a script fails with a non-zero exit code
```bash
verify 'when git is not installed it should fail' fails <<test
    source 'smock.sh'
    replace 'git'; with 'a_malformed_command_that_will_fail'
    ./my_script.sh
test
```

## Contributing

While we are figuring this out, contributions are not yet allowed

## About

This is a simple testing library for bash scripts as well as an experiment on how far can we drive bash scripts with as simple as a solution as possible