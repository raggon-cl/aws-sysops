

LAB05
-----

aws ec2 create-security-group --group-name l04t01-sg-elb --description "Security Group for ELB lab"

{
    "GroupId": "sg-05d3196d1955fb0b2"
}

aws ec2 authorize-security-group-ingress --group-name l04t01-sg-elb --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name l04t01-sg-elb --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 describe-vpcs --filters "Name=is-default,Values=true" --query "Vpcs[*].VpcId" --output table

---------------------------
|      DescribeVpcs       |
+-------------------------+
|  vpc-0882d5db26a35f3d9  |
+-------------------------+

aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-0882d5db26a35f3d9" --query "Subnets[*].[AvailabilityZone,SubnetId]" --output table

--------------------------------------------
|              DescribeSubnets             |
+-------------+----------------------------+
|  us-east-1f |  subnet-0eae8de50b49ed394  |
|  us-east-1e |  subnet-02f0e5d4bb5f291b8  |
|  us-east-1a |  subnet-0f8dd63d7fa61de30  |
|  us-east-1d |  subnet-05bce8375447d23d8  |
|  us-east-1c |  subnet-0d0d1b88f0d064980  |
|  us-east-1b |  subnet-046b731dde05b98ed  |
+-------------+----------------------------+

#Create 3 x EC2 instances using the commands below. Replace [SUBNETID1] and [SUBNETID2] with the subnet IDs collected from earlier command. Each block is a single command.

#sg-05d8a23833e8d5350	lab02web-sg  //Segurity Group App Server

aws ec2 run-instances --count 1 --image-id ami-03c5b241316591081 --instance-type t2.micro --security-group-ids sg-05d3196d1955fb0b2 --subnet-id subnet-0f8dd63d7fa61de30 --key-name training-keypair-us-e-1 --user-data file:///home/cloudshell-user/userdata.sh --tag-specifications 'ResourceType=instance,Tags=[{Key=Environment,Value=Training},{Key=Name,Value=l04t01-tg01vm01}]'


aws ec2 run-instances --count 1 --image-id ami-03c5b241316591081 --instance-type t2.micro --security-group-ids sg-05d3196d1955fb0b2 --subnet-id subnet-046b731dde05b98ed --key-name training-keypair-us-e-1 --user-data file:///home/cloudshell-user/userdata.sh --tag-specifications 'ResourceType=instance,Tags=[{Key=Environment,Value=Training},{Key=Name,Value=l04t01-tg01vm02}]'


aws ec2 run-instances --count 1 --image-id ami-03c5b241316591081 --instance-type t2.micro --security-group-ids sg-05d3196d1955fb0b2 --subnet-id subnet-0f8dd63d7fa61de30 --key-name training-keypair-us-e-1 --user-data file:///home/cloudshell-user/userdata.sh --tag-specifications 'ResourceType=instance,Tags=[{Key=Environment,Value=Training},{Key=Name,Value=l04t01-tg02vm01}]'

l04t02-tg01-elb   arn:aws:elasticloadbalancing:us-east-1:466508081033:targetgroup/l04t02-tg01-elb/62f93ca7fae03358

l04t02-tg02-elb   arn:aws:elasticloadbalancing:us-east-1:466508081033:targetgroup/l04t02-tg02-elb/c9df48e4697bfb00




