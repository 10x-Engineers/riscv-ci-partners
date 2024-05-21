#!/bin/bash
cd mkdocs_src || exit
mkdocs gh-deploy -d ../docs
cd ..
git add .
