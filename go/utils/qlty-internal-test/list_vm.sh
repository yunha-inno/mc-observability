
echo "####################################################################"
echo "##  ${CONN_CONFIG} - VM: ListStatus"
echo "####################################################################"

curl -sX GET http://localhost:1024/spider/vm -H 'Content-Type: application/json' -d '{ "ConnectionName": "'${CONN_CONFIG}'"}' |json_pp
