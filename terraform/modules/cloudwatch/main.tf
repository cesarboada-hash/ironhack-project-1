# SNS Topic para notificaciones por email
resource "aws_sns_topic" "cloudwatch_alerts" {
  name = "${var.project_name}-cloudwatch-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.cloudwatch_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Alarma CPU - Frontend
resource "aws_cloudwatch_metric_alarm" "cpu_frontend" {
  alarm_name          = "${var.project_name}-cpu-frontend"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU usage above 80% on frontend"
  alarm_actions       = [aws_sns_topic.cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = var.frontend_instance_id
  }
}

# Alarma CPU - Backend
resource "aws_cloudwatch_metric_alarm" "cpu_backend" {
  alarm_name          = "${var.project_name}-cpu-backend"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU usage above 80% on backend"
  alarm_actions       = [aws_sns_topic.cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = var.backend_instance_id
  }
}

# Alarma CPU - Database
resource "aws_cloudwatch_metric_alarm" "cpu_db" {
  alarm_name          = "${var.project_name}-cpu-database"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU usage above 80% on database"
  alarm_actions       = [aws_sns_topic.cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = var.db_instance_id
  }
}

# Alarma Memoria - las 3 instancias (via CloudWatch Agent)
resource "aws_cloudwatch_metric_alarm" "mem_frontend" {
  alarm_name          = "${var.project_name}-mem-frontend"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Memory usage above 80% on frontend"
  alarm_actions       = [aws_sns_topic.cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = var.frontend_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "mem_backend" {
  alarm_name          = "${var.project_name}-mem-backend"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Memory usage above 80% on backend"
  alarm_actions       = [aws_sns_topic.cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = var.backend_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "mem_db" {
  alarm_name          = "${var.project_name}-mem-database"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Memory usage above 80% on database"
  alarm_actions       = [aws_sns_topic.cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = var.db_instance_id
  }
}
