resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false

  # CRITICAL: Prevent this from regenerating on every apply
  # This ensures ACR name, IPs, and other resources stay consistent
  lifecycle {
    ignore_changes = all
  }
}
