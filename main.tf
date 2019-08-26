provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/admin"
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_cpu-90" {
  alarm_name          = "elasticache-alarm-cpu-${var.cache_cluster_id}-90"
  alarm_description   = "CPU utilization on ${var.cache_cluster_id} reached 90%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = ceil(var.cpu_percent_threshold / var.cache_nodetype_vcpu)
  statistic           = "Average"
  alarm_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  ok_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
    CacheNodeId    = var.cache_node_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_evictions" {
  alarm_name          = "elasticache-alarm-evictions-${var.cache_cluster_id}"
  alarm_description   = "Evictions for ${var.cache_cluster_id} have been greater than 0 for at least 30 minutes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Evictions"
  namespace           = "AWS/ElastiCache"
  period              = 960
  threshold           = var.evictions_threshold
  statistic           = "Average"
  alarm_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  ok_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
    CacheNodeId    = var.cache_node_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_currconnections" {
  alarm_name          = "elasticache-alarm-currconnections-${var.cache_cluster_id}"
  alarm_description   = "CurrConnections for ${var.cache_cluster_id} have been greater than 40000 for at least 5 minutes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CurrConnections"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = "40000"
  statistic           = "Average"
  alarm_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  ok_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
    CacheNodeId    = var.cache_node_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_swap" {
  alarm_name          = "elasticache-alarm-swap-${var.cache_cluster_id}"
  alarm_description   = "Swap usage for ${var.cache_cluster_id} have been greater than 1GB for at least 10 minutes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "SwapUsage"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = var.swap_threshold
  statistic           = "Average"
  alarm_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  ok_actions = [
    var.slack_lambda_sns_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
    CacheNodeId    = var.cache_node_id
  }
}
