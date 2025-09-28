#!/bin/bash

echo "Building the wiki sidebar..."
cd wiki && python3 sidebar_builder.py && cd ..

echo "Copying wiki into assets folder..."
cd markdown-renderer &&\
    rm -fr public/wiki &&\
    cp -r ../wiki public/wiki &&\
    cd ..

echo "Building site..."
cd markdown-renderer &&\
    npm run build &&\
    cd ..

cp markdown-renderer/dist/markdown-renderer/browser/* docker/html/

echo "Build complete."