# Terraform


>**Warning:** 
>
>Running this Terraform project will create objects in your AWS account that will cost you money against your AWS bill.


The terraform configuration was created following the [terraform eks guide](https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html) and the [eks-getting-started](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/eks-getting-started).

The sample architecture introduced here includes the following resources:

* EKS Cluster: AWS managed Kubernetes cluster of master servers
* AutoScaling Group containing 2 `m4.large` instances based on the latest EKS Amazon Linux 2 AMI: Operator managed Kuberneted worker nodes for running Kubernetes service deployments
* Associated VPC, Internet Gateway, Security Groups, and Subnets: Operator managed networking resources for the EKS Cluster and worker node instances
* Associated IAM Roles and Policies: Operator managed access resources for EKS and worker node instances


What it does in addition over and above the terraform examples is:

* Initialises the kubernetes provider, authenticating with (aws-iam-authenticator)[https://github.com/kubernetes-sigs/aws-iam-authenticator]
* Create k8s config map to enable nodes to join the cluster


## Prerequisites 

In order to follow this guide you will need:

* An AWS account
* Terraform installed and configured with your credentials
* [AWS IAM Authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator) installed
* [Kubectl](https://kubernetes.io/docs/imported/release/notes/#client-binaries) installed
* [jq](https://stedolan.github.io/jq/) installed


## Provision
>**Note:** 
> Always review someone elses scripts to understand what they will do. This configuration changes resources in your AWS account. 

**1. Review and customise the configuration in `vars.tfvars`**

```
cluster_name = "demo"
availability_zones = ["us-east-1b", "us-east-1c", "us-east-1d"]
number_of_nodes = "1"
node_instance_type = "m4.large"
region = "us-east-1"
```

**2. Initialise terraform**

```
$ terraform init

Initializing modules...
- module.aws-vpc
  Getting source "./modules/aws-vpc"
- module.eks
  Getting source "./modules/eks"

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "kubernetes" (1.1.0)...
- Downloading plugin for provider "aws" (1.24.0)...
- Downloading plugin for provider "http" (1.0.1)...
- Downloading plugin for provider "external" (1.0.0)...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

**3. Review and apply the configuration**

```
$ terraform apply -var-file=vars.tfvars

data.external.heptio_authenticator_aws: Refreshing state...
data.http.workstation-external-ip: Refreshing state...
data.aws_ami.eks-worker: Refreshing state...
data.aws_region.current: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + module.aws-vpc.aws_internet_gateway.eks
      id:                                         <computed>
      tags.%:                                     "1"
      tags.Name:                                  "terraform-eks-demo"
      vpc_id:                                     "${aws_vpc.eks.id}"

      
...


Plan: 25 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

```

Review the changes and type `yes` to apply the changes.

## Test

List the node(s)

```
$ kubectl get nodes
NAME                         STATUS    ROLES     AGE       VERSION
ip-10-0-1-143.ec2.internal   Ready     <none>    24s       v1.10.3
```
List the pods

```
$ kubectl get pods --all-namespaces
NAMESPACE     NAME                        READY     STATUS    RESTARTS   AGE
kube-system   aws-node-6zxg8              1/1       Running   0          1m
kube-system   kube-dns-64b69465b4-n2k5l   3/3       Running   0          4m
kube-system   kube-proxy-jb74q            1/1       Running   0          1m
```

## Tear down

* Run `terraform destroy -var-file=vars.tfvars`

## What next
See [Issues](https://github.com/niallmccullagh/terraform-eks/issues)

Pull requests welcome.
