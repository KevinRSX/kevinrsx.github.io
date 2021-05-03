#!/bin/bash

pandoc markdown/all.md -o ./all.html --template=uikit.html
pandoc markdown/about.md -o ./about.html --template=uikit.html
pandoc markdown/index.md -o ./index.html --template=uikit.html
