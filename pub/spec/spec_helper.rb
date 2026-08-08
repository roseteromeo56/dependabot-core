# typed: false
# frozen_string_literal: true

def common_dir
  @common_dir ||= Gem::Specification.find_by_name("dependabot-common").gem_dir
end

def require_common_file(*path_segments)
  common_root = File.realpath(common_dir)
  target_path = File.realpath(File.join(common_root, *path_segments))

  unless target_path.start_with?("#{common_root}/")
    raise ArgumentError, "common spec path must remain within #{common_root}"
  end

  require target_path
end

def require_common_spec(path)
  common_spec_paths = {
    "shared_examples_for_autoloading" => %w(spec dependabot shared_examples_for_autoloading.rb),
    "metadata_finders/shared_examples_for_metadata_finders" =>
      %w(spec dependabot metadata_finders shared_examples_for_metadata_finders.rb),
    "update_checkers/shared_examples_for_update_checkers" =>
      %w(spec dependabot update_checkers shared_examples_for_update_checkers.rb),
    "file_updaters/shared_examples_for_file_updaters" =>
      %w(spec dependabot file_updaters shared_examples_for_file_updaters.rb),
    "file_parsers/shared_examples_for_file_parsers" =>
      %w(spec dependabot file_parsers shared_examples_for_file_parsers.rb),
    "file_fetchers/shared_examples_for_file_fetchers" =>
      %w(spec dependabot file_fetchers shared_examples_for_file_fetchers.rb)
  }

  path_segments = common_spec_paths.fetch(path) do
    raise ArgumentError, "Invalid common spec path: #{path}"
  end

  require_common_file(*path_segments)
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

require_common_file("spec", "spec_helper.rb")
