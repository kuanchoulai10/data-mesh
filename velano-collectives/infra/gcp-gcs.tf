# --8<-- [start:velano-collectives]
resource "google_storage_bucket" "velano_collectives" {
    name     = "velano-collectives-${random_string.velano_collectives_suffix.result}"
    location = "US"
}
# --8<-- [end:velano-collectives]
