#!/bin/bash
curl -X POST http://10.0.0.1:8080/put -d key="ciao" -d value="hello"
echo ""
curl -X GET  http://10.0.0.1:8080/get?key="ciao"
echo ""
curl -X GET  http://10.0.0.1:8080/get?key=nonexist
echo ""
