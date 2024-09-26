# Creating an N-tier architecture template using HashiCorp Configuration Languaage(HCL) in Terraform.

## Virtual Private Cloud(VPC)

**Arguments**
-------------

1. cidr_block 
2. tags
3. enable_dns_hostnames

configured a Virtual Private Cloud (VPC) using the CIDR block 192.0.0.0/16. This CIDR block allows for a total of 65,536 IP addresses, ranging from 192.0.0.0 to 192.0.255.255.
The specified CIDR block of 192.0.0.0/16 enables the creation of multiple subnets within the VPC, each supporting up to 65,536 IP addresses.

**Reserved IP Addresses:** In any subnet, certain IP addresses 
are reserved by AWS:
The first four addresses and the last address in each subnet CIDR block cannot be assigned to resources.
For example, in a subnet with the CIDR block 192.0.1.0/24, the reserved addresses would be:
192.0.1.0: Network address
192.0.1.1: Reserved for the VPC router
192.0.1.2: Reserved for DNS
192.0.1.3: Reserved for future use
192.0.1.255: Broadcast address

## SUBNET ##

**Arguments**
--------------

1. vpc_id
2. cidr_block
3. availability_zone
4. tags

**Subnet Configuration for VPC with CIDR Block 192.0.0.0/16**

In this section, we outline the configuration of five subnets within a Virtual Private Cloud (VPC) using the CIDR block 192.0.0.0/16. The subnets are organized as follows:
- 2 Web Subnets
- 2 Application (App) Subnets
- 1 Database (DB) Subnet

### Subnet Breakdown
1. **Web Subnets**
These subnets are designed to host web servers that require direct access to the internet.
***Web Subnet 1***
CIDR Block: 192.0.0.0/24
Availability Zone: ap-south-1a
Purpose: Hosts public-facing web servers.
***Web Subnet 2***
CIDR Block: 192.0.1.0/24
Availability Zone: ap-south-1b
Purpose: Hosts additional public-facing web servers for redundancy and load balancing.
2. **Application (App) Subnets**
These subnets are intended for application servers that process business logic and interact with the web servers and database.
***App Subnet 1***
CIDR Block: 192.0.2.0/24
Availability Zone: ap-south-1a
Purpose: Hosts application servers that handle requests from web servers.
***App Subnet 2***
CIDR Block: 192.0.3.0/24
Availability Zone: ap-south-1b
Purpose: Hosts additional application servers for load balancing and fault tolerance.
3. **Database (DB) Subnet**
This subnet is dedicated to database servers, ensuring they are isolated from direct internet access for security reasons.
***DB Subnet***
CIDR Block: 192.0.4.0/24
Availability Zone: ap-south-1c
Purpose: Hosts database servers that are accessed only by application servers within the VPC.


## Routing Tables

Each web subnet should be associated with a route table that directs traffic to an Internet Gateway, allowing public access.

The application and database subnets should have route tables that restrict direct internet access, ensuring they communicate only with each other and the web subnets as needed.

## Security Groups

**Configure security groups for each subnet:**

***Web Subnets:*** Allow inbound HTTP/HTTPS traffic from the internet.

***App Subnets:*** Allow inbound traffic from port 8000

***DB Subnet:*** Allow inbound traffic from the app subnets on database ports (e.g., port 3306 for MySQL).

## EC2 Instance

**Arguments**

1. ami
2. instance_type 
3. key_name
4. associate_public_ip_address
5. subnet_id
6. vpc_security_group_ids

An instance has been successfully created in Web Subnet 1 within the VPC configured with the CIDR block 192.0.0.0/16. Here’s a concise overview of the steps involved in the process and the implications of this configuration.

# Steps for Launching Terraform Template

**terraform init**
Initialize the working directory and download the necessary provider plugins.

**terraform plan**
preview the changes that Terraform will make

**terraform fmt**
The command rewrites Terraform configuration files to follow a standard format, applying a set of style conventions for better readability and maintainability

**terraform validate**
The command checks the syntax of all Terraform files in the specified directory, identifying issues such as invalid HCL (HashiCorp Configuration Language) syntax, missing required attributes, or incorrect references to variables and resources.

**terraform apply -var-file='variables.tfvars**
Command is used to apply your Terraform configuration while specifying a file that contains variable definitions. Here’s a concise overview of how this command works and its implications.

**terraform destroy -var-file='variables.tfvars**
is used to destroy infrastructure resources managed by Terraform while specifying a variable file. Here's a concise overview of how this command works.


![Alt Text]("D:\AWS_Ntier_Terraform\images\Screenshot 2024-09-25 225143.png")

![Alt Text]("D:\AWS_Ntier_Terraform\images\Screenshot 2024-09-26 000515.png")