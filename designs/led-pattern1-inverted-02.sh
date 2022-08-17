#!/bin/bash 

curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{ \"clear_display\": [0] }"  "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/displaycontent/BCDDC2C90667"


# LARGER FLAG ####################################################################################################################################################################
##### CHECKERED PATTERN LARGE
# checkEvenA="34"
# checkEvenB="42"
# checkEvenC="50"
# checkEvenD="58"

# checkEvenA="24"
# checkEvenB="42"
# checkEvenC="40"
# checkEvenD="48"



# checkOddA="28"
# checkOddB="36"
# checkOddC="44"
# LARGER FLAG ####################################################################################################################################################################
##### CHECKERED PATTERN LARGE
checkEvenA="30"
checkEvenB="38"
checkEvenC="46"
checkEvenD="54"

checkOddA="28"
checkOddB="36"
checkOddC="44"

# # ROW 1 LARGE
curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenA}, \"y\" : 0, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
sleep 1
curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenB}, \"y\" : 0, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
sleep 1
curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenC}, \"y\" : 0, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
sleep 1
curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenD}, \"y\" : 0, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
sleep 1

# # ROW 2 LARGE
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkOddA}, \"y\" : 4, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" :0, \"x\" : ${checkOddB}, \"y\" : 4, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkOddC}, \"y\" : 4, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1


# # ROW 3 LARGE
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenA}, \"y\" : 8, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenB}, \"y\" : 8, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenC}, \"y\" : 8, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkEvenD}, \"y\" : 8, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# # ROW 4 LARGE
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkOddA}, \"y\" : 12, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" :0, \"x\" : ${checkOddB}, \"y\" : 12, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkOddC}, \"y\" : 12, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1
# # curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : ${checkOddD}, \"y\" : 12, \"size_x\" : 3, \"size_y\" : 3, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [100,14,40] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# # sleep 1



### WORKS

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 62, \"y\" : 1, \"size_x\" : 2, \"size_y\" : 13, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 71, \"y\" : 1, \"size_x\" : 2, \"size_y\" : 13, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 62, \"y\" : 1, \"size_x\" : 11, \"size_y\" : 2, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 62, \"y\" : 7, \"size_x\" : 11, \"size_y\" : 2, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 

####













#####################################################################################################################################################################
# LETTER: A #########################################################################################################################################################

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 60, \"y\" : 1, \"size_x\" : 2, \"size_y\" : 13, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 69, \"y\" : 1, \"size_x\" : 2, \"size_y\" : 13, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 60, \"y\" : 1, \"size_x\" : 11, \"size_y\" : 2, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

# curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 60, \"y\" : 7, \"size_x\" : 11, \"size_y\" : 2, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [0,0,0] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
# sleep 1

#####################################################################################################################################################################
## FILLED SQUARE ####################################################################################################################################################
curl --tlsv1.2 --cacert "root-ca.pem" --cert "716f466c1a-certificate.pem.crt" --key "716f466c1a-private.pem.key" -X POST -d "{     \"draw_rec\": { \"content_id\" : 0, \"display_id\" : 0, \"x\" : 26, \"y\" : 0, \"size_x\" : 47, \"size_y\" : 16, \"velocity_x\" : 0, \"velocity_y\" : 0, \"color\" : [100,14,40] } }" "https://a2p26y8hfzn5u6-ats.iot.ap-southeast-1.amazonaws.com:8443/topics/sym/ica/exd/draw/BCDDC2C90667"
sleep 1




