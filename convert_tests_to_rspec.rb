require 'fileutils'

# Define directories
test_dir = 'test'
spec_dir = 'spec'

# Function to convert test file content
def convert_file_content(content)
  content.gsub!(/require ['"]test_helper['"]/, "require 'rails_helper'")
  content.gsub!(/class (.*?)Test < ActiveSupport::TestCase/, 'RSpec.describe \1, type: :model do')
  content.gsub!(/test ["'](.*?)["'] do/, 'it "\1" do')
  content.gsub!(/assert_equal (.*?), (.*?)/, 'expect(\2).to eq(\1)')
  content.gsub!(/assert (.*?)/, 'expect(\1).to be_truthy')
  content.gsub!(/refute (.*?)/, 'expect(\1).to be_falsey')
  content.gsub!(/assert_not (.*?)/, 'expect(\1).not_to be_truthy')
  content.gsub!(/assert_nil (.*?)/, 'expect(\1).to be_nil')
  content.gsub!(/assert_not_nil (.*?)/, 'expect(\1).not_to be_nil')
  content.gsub!(/assert_difference (.*?) do/, 'expect { \1 }.to change { \1 }')
  content.gsub!(/assert_no_difference (.*?) do/, 'expect { \1 }.not_to change { \1 }')
  content.gsub!(/assert_redirected_to (.*?)/, 'expect(response).to redirect_to(\1)')
  content.gsub!(/assert_response :(.*?)/, 'expect(response).to have_http_status(:\1)')
  content.gsub!(/assert (.*?)\.errors\[:(.*?)\].any?/, 'expect(\1.errors[:\2]).not_to be_empty')
  content.gsub!(/assert (.*?)\.valid?/, 'expect(\1).to be_valid')
  content.gsub!(/refute (.*?)\.valid?/, 'expect(\1).not_to be_valid')
  content.gsub!(/end$/, 'end') # Ensure end statements are properly converted
  content
end

# Process each test file
Dir.glob("#{test_dir}/**/*_test.rb").each do |test_file|
  # Read the file content
  content = File.read(test_file)

  # Convert the content
  new_content = convert_file_content(content)

  # Define the new file path
  new_file_path = test_file.gsub(test_dir, spec_dir).gsub('_test.rb', '_spec.rb')

  # Ensure the directory exists
  FileUtils.mkdir_p(File.dirname(new_file_path))

  # Write the new file content
  File.open(new_file_path, 'w') { |file| file.write(new_content) }
end

puts 'Test files have been converted to RSpec format.'
