#!/bin/bash

if [ "$1" = "" ]; then
        echo
        echo -e 'usage: '$0' mock|aws|azure|gcp|alibaba|tencent|ibm|openstack|cloudit|ncp|nhncloud'
        echo -e '\n\tex) '$0' aws'
        echo
        exit 0;
fi

if [ "${CSP}" = "azure" ]; then
	export SLEEP=80
fi

source ../common/setup.env $1
source setup.env $1

echo -e "####################################################################"
echo -e "# ./01.inbound-case-01.sh $1 "
echo -e "####################################################################"
./01.inbound-case-01.sh $1

echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./02.inbound-case-02.sh $1 "
echo -e "####################################################################"
./02.inbound-case-02.sh $1

echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./03.inbound-case-03.sh $1 "
echo -e "####################################################################"
./03.inbound-case-03.sh $1

echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./04.inbound-case-04.sh $1 "
echo -e "####################################################################"
./04.inbound-case-04.sh $1

echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./05.inbound-case-05.sh $1 "
echo -e "####################################################################"
./05.inbound-case-05.sh $1

echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./06.inbound-case-06.sh $1 "
echo -e "####################################################################"
./06.inbound-case-06.sh $1


echo -e "\n\n"


#----------------

echo -e "####################################################################"
echo -e "# ./10.inbound-case-10.sh $1 "
echo -e "####################################################################"
./10.inbound-case-10.sh $1


echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./11.inbound-case-11.sh $1 "
echo -e "####################################################################"
./11.inbound-case-11.sh $1

echo -e "\n\n"


#----------------

echo -e "####################################################################"
echo -e "# ./20.inbound-case-20.sh $1 "
echo -e "####################################################################"
./20.inbound-case-20.sh $1


echo -e "\n\n"

echo -e "####################################################################"
echo -e "# ./21.inbound-case-21.sh $1 "
echo -e "####################################################################"
./21.inbound-case-21.sh $1

echo -e "\n\n"

sleep 1

echo -e "\n\n"
echo -e "###########################################################"
echo -e "# Finished All Test Cases... "
echo -e "###########################################################"
echo -e "\n\n"

if [ "${CSP}" = "azure" ]; then
	unset SLEEP
fi
