resource "aws_lb" "project_lb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "psql_tg" {
  name     = "psql-tg"
  port     = 5432
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "psql1" {
  target_group_arn = aws_lb_target_group.psql_tg.arn
  target_id        = var.psql1_id
  port             = 5432
}

resource "aws_lb_target_group_attachment" "psql2" {
  target_group_arn = aws_lb_target_group.psql_tg.arn
  target_id        = var.psql2_id
  port             = 5432
}

resource "aws_lb_target_group_attachment" "psql3" {
  target_group_arn = aws_lb_target_group.psql_tg.arn
  target_id        = var.psql3_id
  port             = 5432
}

resource "aws_lb_target_group_attachment" "psql4" {
  target_group_arn = aws_lb_target_group.psql_tg.arn
  target_id        = var.psql4_id
  port             = 5432
}

resource "aws_lb_target_group" "grafana_tg" {
  name     = "grafana-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "grafana1" {
  target_group_arn = aws_lb_target_group.grafana_tg.arn
  target_id        = var.grafana1_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "grfana2" {
  target_group_arn = aws_lb_target_group.grafana_tg.arn
  target_id        = var.grafana2_id
  port             = 3000
}

resource "aws_lb_listener" "psql_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = 5432
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.psql_tg.arn
  }
}

resource "aws_lb_listener" "grafana_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana_tg.arn
  }
}
