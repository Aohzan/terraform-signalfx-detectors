# aliveness detector

variable "aliveness_notifications" {
  description = "Notification recipients list per severity overridden for aliveness detector"
  type        = map(list(string))
  default     = {}
}

variable "aliveness_aggregation_function" {
  description = "Aggregation function and group by for aliveness detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "aliveness_transformation_function" {
  description = "Transformation function for aliveness detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "aliveness_max_delay" {
  description = "Enforce max delay for aliveness detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "aliveness_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "aliveness_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "aliveness_disabled" {
  description = "Disable all alerting rules for aliveness detector"
  type        = bool
  default     = null
}

variable "aliveness_threshold_critical" {
  description = "Critical threshold for aliveness detector"
  type        = number
  default     = 1
}

variable "aliveness_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "aliveness_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}

# failed detector

variable "failed_notifications" {
  description = "Notification recipients list per severity overridden for failed detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_aggregation_function" {
  description = "Aggregation function and group by for failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "failed_transformation_function" {
  description = "Transformation function for failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "failed_max_delay" {
  description = "Enforce max delay for failed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "failed_disabled" {
  description = "Disable all alerting rules for failed detector"
  type        = bool
  default     = null
}

variable "failed_threshold_critical" {
  description = "Critical threshold for failed detector"
  type        = number
  default     = 0
}

variable "failed_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "failed_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
