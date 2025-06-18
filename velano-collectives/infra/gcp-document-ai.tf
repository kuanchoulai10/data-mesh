# --8<-- [start:processor]
resource "google_document_ai_processor" "layout_parser_processor" {
  location     = "us"
  display_name = "layout-parser-processor"
  type         = "LAYOUT_PARSER_PROCESSOR"
}
# --8<-- [end:processor]