resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks"
  role_arn = aws_iam_role.EKS_Cluster_role.arn

  vpc_config {
    subnet_ids = [data.aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.EKS_Cluster_role_Policy,
  ]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node_group"
  node_role_arn   = aws_iam_role.Node_group_role.arn
  subnet_ids      = [data.aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.EKS_Node_group_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
}