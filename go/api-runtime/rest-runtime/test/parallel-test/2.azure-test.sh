export CONN_CONFIG=azure-northeu-config
export IMAGE_NAME=Canonical:UbuntuServer:18.04-LTS:latest
export SPEC_NAME=Standard_B1ls

./parallel_test.sh $1
