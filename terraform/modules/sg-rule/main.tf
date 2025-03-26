resource "aws_security_group_rule" "sg_to_sg" {
  count = length(var.source_security_group_id)

  type                     = var.rule_type #"ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = var.protocol #"tcp"
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id[count.index]
}

resource "aws_security_group_rule" "cidr_to_sg" {
  count = length(var.source_cidr_blocks) > 0 ? 1 : 0

  type              = var.rule_type #"ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = var.protocol #"tcp"
  cidr_blocks       = var.source_cidr_blocks
  security_group_id = var.security_group_id
}