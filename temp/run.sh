#!/bin/bash

DIR=$( dirname "${BASH_SOURCE[0]}" )
directories=$(find $DIR/* -prune -type d -name "atmos-*")
echo $directories