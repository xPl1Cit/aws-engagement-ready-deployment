resource "aws_db_subnet_group" "product" {
  name        = "${var.project}-product-db-subnet-group-${var.stage}"
  subnet_ids  = var.private_db_subnet_ids

  tags = {
    Name = "${var.project}-product-db-subnet-group-${var.stage}"
  }
}

resource "aws_db_instance" "product" {
  identifier        = "${var.project}-product-db-${var.stage}"
  engine            = "postgres"
  engine_version    = "17.4"
  instance_class    = var.db_instance_type 
  allocated_storage = 20
  max_allocated_storage = 100
  db_subnet_group_name = aws_db_subnet_group.product.name
  vpc_security_group_ids = [ var.rds_sg_id ]
  multi_az          = true 
  storage_type      = "gp3"
  publicly_accessible = false 
  username          = var.db_username
  password          = var.db_password
  db_name           = var.db_name
  port              = 5432
  backup_retention_period = 7
  deletion_protection = true
  auto_minor_version_upgrade = true
  tags = {
    Name = "${var.project}-product-db-${var.stage}"
  }

  final_snapshot_identifier = "${var.project}-product-db-snapshot-${var.stage}"
}