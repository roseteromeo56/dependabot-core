# typed: false
# frozen_string_literal: true

def common_dir
  @common_dir ||= Gem::Specification.find_by_name("dependabot-common").gem_dir
end

def require_common_spec(path)
  spec_root = File.expand_path("spec/dependabot", common_dir)
  requested_path = path.to_s

  raise ArgumentError, "spec path must not be empty" if requested_path.empty?
  raise ArgumentError, "spec path contains invalid characters" if requested_path.include?("\0")

  resolved_path = File.expand_path(requested_path, spec_root)
  unless resolved_path.start_with?("#{spec_root}/")
    raise ArgumentError, "spec path must remain within #{spec_root}"
  end

  require resolved_path
end

def run_git(args, dir)
  stdout, stderr, status = Open3.capture3(
    {
      "GIT_AUTHOR_NAME" => "Pub Test",
      "GIT_AUTHOR_EMAIL" => "pub@dartlang.org",
      "GIT_COMMITTER_NAME" => "Pub Test",
      "GIT_COMMITTER_EMAIL" => "pub@dartlang.org",
      # To make stable commits ids we fix the date.
      "GIT_COMMITTER_DATE" => "1970-01-01T00:00:00.000",
      "GIT_AUTHOR_DATE" => "1970-01-01T00:00:00.000"
    },
    "git",
    *args,
    chdir: dir
  )
  raise "git #{args.join(' ')} failed `#{stdout}` `#{stderr}`" if status != 0

  stdout
end

shared_context "with temp dir" do
  around do |example|
    Dir.mktmpdir("rspec-") do |dir|
      @temp_dir = dir
      example.run
    end
  end

  attr_reader :temp_dir
end

require "#{common_dir}/spec/spec_helper.rb"
