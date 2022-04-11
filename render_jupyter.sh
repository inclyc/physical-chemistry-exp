#!/bin/bash
FILE_NAME=`echo ${1%.*} | awk -F/ '{print $NF}'`
TEX_FILE_NAME="$FILE_NAME.tex"
RENDER_DIR="./渲染/"
AUTHOR=$2

RENDER_DIR="$RENDER_DIR/$FILE_NAME/$AUTHOR/"
mkdir -p $RENDER_DIR

jupyter nbconvert --to latex --output-dir=$RENDER_DIR $1



sed -i -E 's/\\documentclass\[11pt\]\{article\}/\\documentclass[a4paper]{ctexart}/g' $RENDER_DIR/$TEX_FILE_NAME
sed -i -E '/\\begin\{document\}/i author{'$AUTHOR'}' $RENDER_DIR/$TEX_FILE_NAME
sed -i -E 's/author\{'$AUTHOR'\}/\\author{'$AUTHOR'}/g' $RENDER_DIR/$TEX_FILE_NAME

pushd $RENDER_DIR
latexmk -pdf -xelatex -quiet $TEX_FILE_NAME
# clean latex except pdf
rm -f *.xdv *.aux *.log *.out *.toc *.nav *.snm *.vrb *.fls *.fdb_latexmk *.fls *.synctex.gz *.idx *.ind *.ilg *.bbl *.blg *.brf *.run.xml *.bak
popd