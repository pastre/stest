source 'stest.sh'

verify 'parses multiline commands' succeeds << EOF
    echo 'yayy'
    echo 'yayy'
    echo 'yayy'
    echo 'yayy'
EOF


verify 'non-zero exit code' fails <<test
    source 'stest.sh'
    verify 'example failing test' fails exit -1 | grep 'Passed'
test
