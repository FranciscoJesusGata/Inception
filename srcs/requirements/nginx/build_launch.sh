#!/bin/bash
docker build -t nginx:fgata-va .\
&& docker run -d -p 443:443 --name prueba nginx:fgata-va
