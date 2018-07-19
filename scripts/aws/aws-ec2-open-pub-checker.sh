#!/bin/bash

rm open*
#-- This script give you a list of instances wth public IP with any ingress rule with 0.0.0.0/0
#export AWS_ACCESS_KEY_ID=ABCDEF
#export AWS_SECRET_ACCESS_KEY=ABCDEF
#export AWS_DEFAULT_PROFILE=profile-name

region=(us-east-1 us-east-2 us-west-1 us-west-2 ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-south-1 ap-southeast-1 ap-southeast-2 ca-central-1 cn-north-1 cn-northwest-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 sa-east-1)

for e in "${region[@]}"
do 

#gets list of security groups with any ingress rule with 0.0.0.0/0
sg=($(aws ec2 describe-security-groups --region $e --filter Name=ip-permission.cidr,Values='0.0.0.0/0' --query 'SecurityGroups[*].GroupId' | sed 's/\"//g' | sed 's/\,//g' | sed 's/\]//g' | sed 's/\[//g'))

aws ec2 describe-security-groups --region $e --filter Name=ip-permission.cidr,Values='0.0.0.0/0' --query 'SecurityGroups[*].GroupId' | sed 's/\"//g' | sed 's/\,//g' | sed 's/\]//g' | sed 's/\[//g' | sed '/^\s*$/d' | awk '$1=$1' >> open-sg-id.txt
#aws ec2 describe-security-groups --region $region --filter Name=ip-permission.cidr,Values='0.0.0.0/0' --query 'SecurityGroups[*].GroupId' | sed 's/\"//g' | sed 's/\,//g' | sed 's/\]//g' | sed 's/\[//g' | sed '/^\s*$/d' >> open-security-groups.txt


for i in "${sg[@]}"
do 
aws ec2 describe-security-groups --group-ids $i --region $e --filters --query 'SecurityGroups[].[IpPermissions[?contains(IpRanges[].CidrIp, `0.0.0.0/0`)].[join(`:`, [IpProtocol, join(`-`, [to_string(FromPort), to_string(ToPort)])])][]]' --output text | sed 's/tcp://g' | sed 's/icmp://g' | sed 's/udp://g' | awk '{$2=$2};1' | sed 's/$/	'$e'/' >> open-sg-withPorts.txt 
#aws ec2 describe-security-groups --group-ids $i --region $region | jq '.SecurityGroups[].GroupId' | sed 's/\"//g' >> open-security-groups.txt
#aws ec2 describe-security-groups --group-ids $i --region $region | jq '.SecurityGroups[].IpPermissions[] | select(.IpRanges[].CidrIp=="0.0.0.0/0") | .FromPort' >> open-security-groups.txt
done

for i in "${sg[@]}"
do
#goes though all sg's from before and check if it's assigned to an instance. 
aws ec2 describe-instances --region $e --filters Name=instance.group-id,Values=$i --query 'Reservations[].Instances[].[InstanceId,PublicIpAddress]' --output text | sed 's/\"//g' | sed 's/\,//g' | sed 's/\]//g' | sed 's/\[//g' | sed '/^\s*$/d' | sed 's/$/	'$e'/' >> instances.txt
done

sort -u instances.txt >> open-instances.txt
rm instances.txt

done

paste -d"	" open-sg-id.txt open-sg-withPorts.txt >> open-sg.txt
rm open-sg-id.txt open-sg-withPorts.txt

