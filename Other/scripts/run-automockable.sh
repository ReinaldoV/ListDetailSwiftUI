#!/bin/bash

# Install parallel if not available
if ! command -v parallel &> /dev/null
then
    brew install parallel
fi

# Install sourcery if not installed
./Other/scripts/install-sourcery.sh

# Only use colours on terminals
tty -s
if [ $? -eq 0 ]; then
    export green=$(tput setaf 2)
    export red=$(tput setaf 1)
    export reset=$(tput sgr0)
fi

sourceryFolder=$(pwd)/Other/bin/Sourcery
export sourceryBin=$sourceryFolder/bin/sourcery

generate_mocks() {
    local module=$(basename $1)
    printf '%s' "Generating $module mocks..."

    local error=$($sourceryBin --config $1 --quiet 2>&1)
    if [ -z "$error" ]; then
        echo  "$green Done$reset"
    else
        echo "$red Error$reset"
        echo $error
    fi
}
export -f generate_mocks

find . -type f -name '.sourcery.yml' | sed -E 's|/[^/]+$||' | sort -u | sed "s#./#generate_mocks #" > commands.txt

parallel -a commands.txt --will-cite
rm commands.txt
