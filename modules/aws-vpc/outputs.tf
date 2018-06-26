
output "subnet_ids" {
  value = "${aws_subnet.eks.*.id}"
}


output "vpc_id" {
  value = "${aws_vpc.eks.id}"
}