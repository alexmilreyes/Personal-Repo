#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

##########################################
##### EC2 Instance Type Change Check #####
##########################################

cd /root/instanceCheck/ec2

# Copy Yesterday to the day before and copy Todays to Yesterday.
cp yesterdayInstanceType.txt dayBeforeInstanceType.txt && cp todaysInstanceType.txt yesterdayInstanceType.txt

# Pulls a list of all current instances id, name, type and places it in a file called todaysInstanceType.txt. 
aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value| [0], InstanceType, InstanceId]' --output text | sort | awk '{ print $1, $2, $3 }' > todaysInstanceType.txt

# Ignore any instances that are launched and terminated my automated processess.
sed -e  '/None/d' -e '/PCMD-PCMAG/d' -e '/bee/d' todaysInstanceType.txt > todaysInstanceTypeTMP.txt && cat todaysInstanceTypeTMP.txt > todaysInstanceType.txt

# Compares the Yesterdays and Todays instances types and saves it to changesInstanceTypeTMP.txt.
diff -U 0  yesterdayInstanceType.txt todaysInstanceType.txt > changesInstanceTypeTMP.txt

# Formates changesInstanceType.txt for readability.
sed -e '/@/d' changesInstanceTypeTMP.txt > changesInstanceType.txt

# If changesInstanceType.txt has any content send an email to  OPS.
if test -s changesInstanceType.txt ; then
echo "FILE has data." && mpack -s 'EC2 Type Changed' changesInstanceType.txt  zdops@ziffdavis.com
else
echo "FILE is empty."
fi ;

##########################################
##### RDS Instance Type Change Check #####
##########################################

cd /root/instanceCheck/rds

# Copy Yesterday to the day before and copy Todays to Yesterday.
cp yesterdayInstanceType.txt dayBeforeInstanceType.txt && cp todaysInstanceType.txt yesterdayInstanceType.txt

# Pulls a list of all current instances id and their instance class and places it in a file called todaysInstanceType.txt.
aws rds describe-db-instances --query 'DBInstances[].[DBInstanceIdentifier, DBInstanceClass]'  --output text | sort | awk '{ print $1, $2 }' > todaysInstanceType.txt

# Compares the Yesterdays and Todays instances types and saves it to changesInstanceType.txt.
diff -U 0  yesterdayInstanceType.txt todaysInstanceType.txt > changesInstanceTypeTMP.txt

# Formates changesInstanceType.txt for readability.
sed -e '/@/d' changesInstanceTypeTMP.txt > changesInstanceType.txt

# If changesInstanceType.txt has any content, send an email to  OPS.
if test -s changesInstanceType.txt ; then
echo "FILE has data." && mpack -s 'RDS Type Changed' changesInstanceType.txt  zdops@ziffdavis.com
else
echo "FILE is empty."
fi ;

##########################################
### RedShift Instance Type Change Check ##
##########################################

cd /root/instanceCheck/redshift

# Copy Yesterday to the day before and copy Todays to Yesterday.
cp yesterdayInstanceType.txt dayBeforeInstanceType.txt && cp todaysInstanceType.txt yesterdayInstanceType.txt

# Pulls a list of all current instances id and their instance type and places it in a file called todaysInstanceType.txt.
aws redshift describe-clusters --query 'Clusters[].[ClusterIdentifier, NodeType]' --output text | sort | awk '{ print $1, $2 }' > todaysInstanceType.txt

# Compares the Yesterdays and Todays instances types and saves it to changesInstanceType.txt.
diff -U 0  yesterdayInstanceType.txt todaysInstanceType.txt > changesInstanceTypeTMP.txt

# Formates changesInstanceType.txt for readability.
sed -e '/@/d' changesInstanceTypeTMP.txt > changesInstanceType.txt

# If changesInstanceType.txt has any content send an email to  OPS.
if test -s changesInstanceType.txt ; then
echo "FILE has data." && mpack -s 'Redshift Type Changed' changesInstanceType.txt  zdops@ziffdavis.com
else
echo "FILE is empty."
fi ;

##########################################
##### ElastiCache   Type Change Check ####
##########################################

cd /root/instanceCheck/elasticache

# Copy Yesterday to the day before and copy Todays to Yesterday.
cp yesterdayInstanceType.txt dayBeforeInstanceType.txt && cp todaysInstanceType.txt yesterdayInstanceType.txt

# Pulls a list of all current instances id and their instance type and places it in a file called todaysInstanceType.txt.
aws elasticache describe-cache-clusters --query 'CacheClusters[].{CacheClusterId: CacheClusterId, CacheNodeType: CacheNodeType}' --output text | sort | awk '{ print $1, $2 }' > todaysInstanceType.txt

# Compares the Yesterdays and Todays instances types and saves it to changesInstanceType.txt.
diff -U 0  yesterdayInstanceType.txt todaysInstanceType.txt > changesInstanceTypeTMP.txt

# Formates changesInstanceType.txt for readability.
sed -e '/@/d' changesInstanceTypeTMP.txt > changesInstanceType.txt

# If changesInstanceType.txt has any content send an email to  OPS.
if test -s changesInstanceType.txt ; then
echo "FILE has data." && mpack -s 'ElastiCache Type Changed' changesInstanceType.txt  zdops@ziffdavis.com
else
echo "FILE is empty."
fi ;