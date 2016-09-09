require './test/test_helper'
require './lib/html_exporter'

class HTMLExporterTest < Minitest::Test

  def test_header_row_is_an_array_of_headers
    header = HTMLExporter::HEADER_ROW
    assert_instance_of Array, header
  end

  def test_response_to_header_format_html
    assert_respond_to HTMLExporter, :header_format_html
  end

  def test_response_to_queue_format_html
    assert_respond_to HTMLExporter, :queue_format_html
  end

  def test_response_to_build_full_html
    assert_respond_to HTMLExporter, :queue_format_html
  end

  def test_response_to_export_html
    assert_respond_to HTMLExporter, :export_html
  end
end
