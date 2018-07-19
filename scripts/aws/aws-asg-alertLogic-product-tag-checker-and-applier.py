import boto3


#US-EAST-1
asgEast = boto3.client('autoscaling')
ec2East = boto3.client("ec2")

response = asgEast.describe_tags(
    Filters=[
        {
            'Name' : 'auto-scaling-group',
            'Values' : [
                'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-e8c6888d',
            ], 
        },
        {
            'Name' : 'Key',
            'Values' : [
                'product',
            ]
        }
    ]
)

try:
    asgEast1Tag = response["Tags"][0]["Key"]
except IndexError:
    pass

try:
    asgEast1Tag
except NameError:
    response = asgEast.create_or_update_tags(
        Tags=[
            {
                'ResourceId': 'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-e8c6888d',
                'ResourceType': 'auto-scaling-group',
                'Key': 'product',
                'Value': 'alertlogic',
                'PropagateAtLaunch': True
            },
        ]
    )

    reservations =   ec2East.describe_instances(
        Filters=[{'Name': 'tag:Name', 
                  'Values': ['AlertLogic Security Appliance']
                 }
        ]
    )

    mytags = [{
            "Key" : "product", 
            "Value" : "alertlogic"
        }]

    for reservation in reservations["Reservations"]:
        for instance in reservation["Instances"]:
            ec2East.create_tags(
                Resources = [instance["InstanceId"]],
                Tags = mytags
    )
    
    print("Product tag has been applied to ASG in us-east-1")
else:
    print ("No need to apply product tag ASG in us-east-1")
    

response = asgEast.describe_tags(
    Filters=[
        {
            'Name' : 'auto-scaling-group',
            'Values' : [
                'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-06a8346a',
            ], 
        },
        {
            'Name' : 'Key',
            'Values' : [
                'product',
            ]
        }
    ]
)

try:
    asgEast2Tag = response["Tags"][0]["Key"]
except IndexError:
    pass

try:
    asgEast2Tag
except NameError:
    response = asgEast.create_or_update_tags(
        Tags=[
            {
                'ResourceId': 'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-06a8346a',
                'ResourceType': 'auto-scaling-group',
                'Key': 'product',
                'Value': 'alertlogic',
                'PropagateAtLaunch': True
            },
        ]
    )

    reservations =   ec2East.describe_instances(
        Filters=[{'Name': 'tag:Name', 
                  'Values': ['AlertLogic Security Appliance']
                 }
        ]
    )

    mytags = [{
            "Key" : "product", 
            "Value" : "alertlogic"
        }]

    for reservation in reservations["Reservations"]:
        for instance in reservation["Instances"]:
            ec2East.create_tags(
                Resources = [instance["InstanceId"]],
                Tags = mytags
    )

    print("Product tag has been applied to ASG in us-east-1")
else:
    print ("No need to apply product tag ASG in us-east-1")



#US-WEST-2
asgWest = boto3.client('autoscaling', region_name='us-west-2')
ec2West = boto3.client("ec2", region_name='us-west-2')

response = asgWest.describe_tags(
        Filters=[
        {
            'Name' : 'auto-scaling-group',
            'Values' : [
                'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-bae717df',
            ], 
        },
        {
            'Name' : 'Key',
            'Values' : [
                'product',
            ]
        }
    ]
)

try:
    asgWestTag = response["Tags"][0]["Key"]
except IndexError:
    pass

try:
    asgWestTag
except NameError:
    response = asgWest.create_or_update_tags(
        Tags=[
            {
                'ResourceId': 'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-bae717df',
                'ResourceType': 'auto-scaling-group',
                'Key': 'product',
                'Value': 'alertlogic',
                'PropagateAtLaunch': True
            },
        ]
    )

    reservations =   ec2West.describe_instances(
        Filters=[{'Name': 'tag:Name', 
                  'Values': ['AlertLogic Security Appliance']
                 }
        ]
    )

    mytags = [{
            "Key" : "product", 
            "Value" : "alertlogic"
        }]

    for reservation in reservations["Reservations"]:
        for instance in reservation["Instances"]:
            ec2West.create_tags(
                Resources = [instance["InstanceId"]],
                Tags = mytags
    )

    print("Product tag has been applied to ASG in us-west-2")
else:
    print ("No need to apply product tag ASG in us-west-2")



#EU-WEST-1
asgEuWest = boto3.client('autoscaling', region_name='eu-west-1')
ec2EuWest = boto3.client("ec2", region_name='eu-west-1')

response = asgEuWest.describe_tags(
    Filters=[
        {
            'Name' : 'auto-scaling-group',
            'Values' : [
                'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-d6f204b3',
            ], 
        },
        {
            'Name' : 'Key',
            'Values' : [
                'product',
            ]
        }
    ]
)

try:
    asgEuWest1Tag = response["Tags"][0]["Key"]
except IndexError:
    pass

try:
    asgEuWest1Tag
except NameError:
    response = asgEuWest.create_or_update_tags(
        Tags=[
            {
                'ResourceId': 'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-d6f204b3',
                'ResourceType': 'auto-scaling-group',
                'Key': 'product',
                'Value': 'alertlogic',
                'PropagateAtLaunch': True
            },
        ]
    )

    reservations = ec2EuWest.describe_instances(
        Filters=[{'Name': 'tag:Name', 
                  'Values': ['AlertLogic Security Appliance']
                 }
        ]
    )

    mytags = [{
            "Key" : "product", 
            "Value" : "alertlogic"
        }]

    for reservation in reservations["Reservations"]:
        for instance in reservation["Instances"]:
            ec2EuWest.create_tags(
                Resources = [instance["InstanceId"]],
                Tags = mytags
    )
    
    print("Product tag has been applied to ASG in eu-west-1")
else:
    print ("No need to apply product tag ASG in eu-west-1")

response = asgEuWest.describe_tags(
    Filters=[
        {
            'Name' : 'auto-scaling-group',
            'Values' : [
                'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-398a965d',
            ], 
        },
        {
            'Name' : 'Key',
            'Values' : [
                'product',
            ]
        }
    ]
)

try:
    asgEuWest2Tag = response["Tags"][0]["Key"]
except IndexError:
    pass

try:
    asgEuWest2Tag
except NameError:
    response = asgEuWest.create_or_update_tags(
        Tags=[
            {
                'ResourceId': 'AlertLogic Security Autoscaling Group 134253291/C584E566-29B2-4D7A-A0EA-43B365AFCD2C/vpc-398a965d',
                'ResourceType': 'auto-scaling-group',
                'Key': 'product',
                'Value': 'alertlogic',
                'PropagateAtLaunch': True
            },
        ]
    )

    reservations = ec2EuWest.describe_instances(
        Filters=[{'Name': 'tag:Name', 
                  'Values': ['AlertLogic Security Appliance']
                 }
        ]
    )

    mytags = [{
            "Key" : "product", 
            "Value" : "alertlogic"
        }]

    for reservation in reservations["Reservations"]:
        for instance in reservation["Instances"]:
            ec2EuWest.create_tags(
                Resources = [instance["InstanceId"]],
                Tags = mytags
    )

    print("Product tag has been applied to ASG in eu-west-1")
else:
    print ("No need to apply product tag ASG in eu-west-1")