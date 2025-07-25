variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default = "avik-kambui"
}

variable "region" {
  description = "The GCP region for the cluster"
  type        = string
  default     = "australia-southeast1" # Melbourne region
}
