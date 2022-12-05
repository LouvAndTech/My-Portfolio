#!/bin/bash
cd My-Portfolio-front/
npm install
ng build --configuration=production
cd ..
docker build --tag my-portfolio .

echo("Compliation Done")