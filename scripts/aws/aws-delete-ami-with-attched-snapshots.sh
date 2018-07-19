#!/bin/bash
#Script to delete ami with attached snapshots.

#return ami's with true value.
#aws ec2 describe-images --image-ids --filter "Name=tag:retain,Values=true" --query 'Images[].ImageId[]' | tr -d '[,]"' | sed '/^$/d' | sed -e 's/^[ \t]*//' | sort

#returns all ami's created before set date that are active.
#aws ec2 describe-images --image-ids --filter "Name=state,Values=available" "Name=tag:retain,Values=true" "Name=owner-id,Values=ACCOUNT#" --query 'Images[?CreationDate<=`YYYY-MM-DD`].ImageId[]' | tr -d '[,]"' | sed '/^$/d' | sed -e 's/^[ \t]*//' | sort


#Get a list of all ami's created before a certain date and removes all ami's that are tagged with  name retain and value true.
comm -23 <( aws ec2 describe-images --image-ids --filter "Name=state,Values=available" "Name=owner-id,Values=ACCOUNTNUMBER" --query 'Images[?CreationDate<=`2018-01-28`].ImageId[]' | tr -d '[,]"' | sed '/^$/d' | sed -e 's/^[ \t]*//' | sort ) <( aws ec2 describe-images --image-ids --filter "Name=tag:retain,Values=true" --query 'Images[].ImageId[]' | tr -d '[,]"' | sed '/^$/d' | sed -e 's/^[ \t]*//' | sort ) >> imageid.txt

#Find snapshots associated with AMI.
for i in `cat imageid.txt`; do aws ec2 describe-images --image-ids $i --query "Images[].BlockDeviceMappings[].Ebs[].SnapshotId" | tr -d '[,]"' | sed '/^$/d' | sed -e 's/^[ \t]*//' >> snap.txt ; done

echo "Following are the snapshots associated with AMIs : \n `cat snap.txt`"

echo "Starting the Deregister of AMI... \n"

#Deregistering the AMI
for i in `cat imageid.txt`; do aws ec2 deregister-image --image-id $i ; done

echo "\nDeleting the associated snapshots.... \n"

#Deleting snapshots attached to AMI
for i in `cat snap.txt`; do aws ec2 delete-snapshot --snapshot-id $i ; done
