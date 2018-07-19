#!/bin/bash

#-- This scripts allows you to add a security group to every instance in your aws account
#-- update variable "secu" to the security group you want to add. 

secu="sg-fbda8cb3"

instanceids=($(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' | sed 's/\"//g' | sed 's/\,//g' | sed 's/\]//g' | sed 's/\[//g'))

for i in "${instanceids[@]}"
do

sg=($(aws ec2 describe-instances --instance-ids $i --query 'Reservations[].Instances[].SecurityGroups[].GroupId' | sed 's/\"//g' | sed 's/\,//g' | sed 's/\]//g' | sed 's/\[//g' | tr -d '\r\n'))

aws ec2 modify-instance-attribute --instance-id $i --groups $sg $secu

done


#--Notes

