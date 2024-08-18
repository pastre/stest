source 'stest.sh'

verify 'parses multiline commands' succeeds << EOF
    echo 'yayy'
    echo 'yayy'
    echo 'yayy'
    echo 'yayy'
EOF