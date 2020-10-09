resource "signalfx_detector" "api_result" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Key Vault API result rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        A = data('ServiceApiResult', extrapolation="zero", filter=base_filter and filter('statuscode', '200') and ${module.filter-tags.filter_custom})${var.api_result_aggregation_function}
        B = data('ServiceApiResult', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.api_result_aggregation_function}
        signal = (A/B).scale(100).fill(100).publish('signal')
        detect(when(signal < threshold(${var.api_result_threshold_critical}), lasting="${var.api_result_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.api_result_threshold_major}), lasting="${var.api_result_timer}") and when(signal >= ${var.api_result_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too low < ${var.api_result_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.api_result_disabled_critical, var.api_result_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_result_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "is too low < ${var.api_result_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.api_result_disabled_major, var.api_result_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_result_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "api_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Key Vault API latency"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        signal = data('ServiceApiLatency', extrapolation="zero", filter=base_filter and not filter('activityname', 'secretlist') and ${module.filter-tags.filter_custom})${var.api_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.api_latency_threshold_critical}), lasting="${var.api_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.api_latency_threshold_major}), lasting="${var.api_latency_timer}") and when(signal <= ${var.api_latency_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.api_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.api_latency_disabled_critical, var.api_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "is too high > ${var.api_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.api_latency_disabled_major, var.api_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}
