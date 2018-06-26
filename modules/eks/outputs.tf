#
# A standalone kubeconfig for the cluster.
# Copy the output to a file called 'cluster_config' and merge by: 
# KUBECONFIG=~/.kube/config:./cluster_config kubectl config view --flatten > ~/.kube/config
#
output "kubeconfig" {
  value = "${local.kubeconfig}"
}