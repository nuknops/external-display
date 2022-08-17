#!/bin/bash 

# CLEAR ALL
curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{ \"clear_display\": [0] }"  "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/displaycontent/BCDDC2C90667"
sleep 1

