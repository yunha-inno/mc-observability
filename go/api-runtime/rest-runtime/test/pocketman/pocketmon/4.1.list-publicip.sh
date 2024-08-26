#!/bin/bash
source setup.env

SHOOTERS=( aws-shooter-name azure-shooter gcp-shooter )
CMD=list-test.sh

echo $WORK_PATH
num=0
for SHOOTER in "${SHOOTERS[@]}"
do
	WORK_PATH=$TEST_PATH/$SHOOTER/publicip
        /bin/bash -c 'cd '$WORK_PATH';'./$CMD'' &

        num=`expr $num + 1`
done


