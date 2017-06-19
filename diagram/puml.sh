#!/usr/bin/env bash
set -u # Exit on unset var
set -e # Exit on non-true return value

# Always start in project root to ensure that relative paths work
cd $(dirname ${BASH_SOURCE[0]})/

################################

PUML_RELATIVE_WORKING_DIR="./"
PUML_BIN=$(which plantuml || true)

################################

if [ -z "${PUML_BIN}" ]; then
    echo -e "$(tput setaf 2)You need plantuml for this script. On a mac with homebrew:\n$(tput setaf 3)brew install plantuml$(tput sgr 0)";
    exit 1;
fi

if [ "$#" -eq 0 ]; then
    echo -e "$(tput setaf 2)Turning all .puml files to .svg in ${PUML_RELATIVE_WORKING_DIR} ...$(tput sgr 0)";
    ${PUML_BIN} -tsvg -o . ${PUML_RELATIVE_WORKING_DIR}*
elif [ "$#" -eq 1 ]; then
    echo -e "$(tput setaf 2)Turning $1 to .svg in ${PUML_RELATIVE_WORKING_DIR} ...$(tput sgr 0)";
    ${PUML_BIN} -tsvg -o . ${PUML_RELATIVE_WORKING_DIR}$1
else
    echo "";
    echo "Usage:";
    echo "puml.sh                    Creates .svg files from all .puml files";
    echo "puml.sh <diagram.puml>     Creates diagram.svg from diagram.puml";
    exit 1;
fi
