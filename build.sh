#!/bin/bash

function fetch-from-remote {
    repo=$1
    dir=$2
    mkdir -p $2
    cd $dir
    if [[ -e .git ]]; then
        git clone $repo --depth 1
    else
        git pull
    fi
    cd -
}

rm -rf docs/*
cp index.html docs/

fetch-from-remote https://github.com/cozy/cozy-konnector-libs.git /tmp/cozy-konnector-libs
cp -r /tmp/cozy-konnector-libs/packages/cozy-konnector-libs/docs src/cozy-konnector-libs

fetch-from-remote https://github.com/cozy/cozy-stack.git /tmp/cozy-stack
cp -r /tmp/cozy-stack/docs src/cozy-stack

mkdocs build -f mkdocs.yml
mkdocs build -f mkdocs_fr.yml
msgmerge --update i18n/fr_FR/LC_MESSAGES/messages.po i18n/messages.pot
