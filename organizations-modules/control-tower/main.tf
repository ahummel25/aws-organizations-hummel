data "aws_region" "current" {}

data "aws_organizations_organization" "this" {}

data "aws_organizations_organizational_units" "this" {
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

resource "aws_controltower_control" "this" {
  control_identifier = "arn:aws:controltower:${data.aws_region.current.name}::control/AWS-GR_EC2_VOLUME_INUSE_CHECK"
  target_identifier = [
    for x in data.aws_organizations_organizational_units.this.children :
    x.arn
  ][0]
}
