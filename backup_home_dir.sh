#!/usr/bin/env bash
set -e
set +x

tar -zcvf 20230604_home_backup.tar.gz --exclude='/Users/fpa/.Trash' --exclude='/Users/fpa/projects' --exclude='/Users/fpa/.cache' --exclude="/Users/fpa/.npm" --exclude="/Users/fpa/.jupyter"  --exclude="/Users/fpa/Applications" --exclude="/Users/fpa/Library"  --exclude="/Users/fpa/Qt" ~