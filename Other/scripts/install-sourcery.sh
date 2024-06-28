#!/bin/bash

sourceryVersion="2.1.7"
sourceryFolder=$(pwd)/Other/bin/Sourcery
export sourceryBin=$sourceryFolder/bin/sourcery

install_sourcery() {
    mkdir -p $sourceryFolder
    curl -L https://github.com/krzysztofzablocki/Sourcery/releases/download/${sourceryVersion}/Sourcery-${sourceryVersion}.zip -o $sourceryFolder/Sourcery.zip
    unzip -q $sourceryFolder/Sourcery.zip -d $sourceryFolder
}

if [ ! -e "$sourceryBin" ]; then
    echo "Installing Sourcery $sourceryVersion..."
    install_sourcery
else
    installedVersion=$($sourceryBin --version)
    if [[ $installedVersion != $sourceryVersion ]]; then
        echo "Updating to Sourcery $sourceryVersion..."
        rm -r $sourceryFolder
        install_sourcery
    fi
fi