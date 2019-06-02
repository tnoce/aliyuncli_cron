#!/bin/bash

REGION="ap-northeast-1"

ALL_INSTANCE_ID=(`aliyuncli ecs DescribeInstances | jq -r '.Instances.Instance[].InstanceId'`)

for INSTANCE_ID in "${ALL_INSTANCE_ID[@]}"
do
  INSTANCE_STATUS=`aliyuncli ecs DescribeInstanceAttribute --InstanceId ${INSTANCE_ID} | jq -r '.Status'`
  if [ "${INSTANCE_STATUS}" == "Stopped" ]; then
    aliyuncli ecs StartInstance --InstanceId ${INSTANCE_ID} --RegionId ${REGION}
    echo "Started ECS Instance."
    echo "InstanceId:"${INSTANCE_ID}
  fi
done
    echo "Complete all jobs!!"
~
