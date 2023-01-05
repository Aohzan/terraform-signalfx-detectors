output "aliveness" {
  description = "Detector resource for aliveness"
  value       = signalfx_detector.aliveness
}

output "failed" {
  description = "Detector resource for failed"
  value       = signalfx_detector.failed
}
