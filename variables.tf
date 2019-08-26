variable "cache_cluster_id" {
  description = "Elasticache cluster ID"
}

variable "cache_node_id" {
  description = "Elasticache node ID"
}

variable "cache_nodetype_vcpu" {
  description = "vCpu count"
}

variable "account_id" {
  description = "The AWS account id"
  type        = number
}

variable "region" {
  description = "The region of AWS"
  type        = string
}

variable "slack_lambda_sns_topic_arn" {
  description = "Slack lambda sns topic arn"
  type        = string
}

variable "evictions_threshold" {
  description = "Threshold for evictions alarm"
  type        = string
  default     = "0"
}

variable "cpu_percent_threshold" {
  description = "Threshold for cpu alarm in %"
  type        = number
  default     = 90
}

variable "swap_threshold" {
  description = "Threshold for swap alarm"
  type        = number
  default     = 262144000
}
