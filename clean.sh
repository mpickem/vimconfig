#! /bin/bash

find tmp/backup ! -name 'README' -type f -exec rm -f {} +
find tmp/undo   ! -name 'README' -type f -exec rm -f {} +
find tmp/swap   ! -name 'README' -type f -exec rm -f {} +
