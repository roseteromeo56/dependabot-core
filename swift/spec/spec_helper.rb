# typed: true
# frozen_string_literal: true

def common_dir
  @common_dir ||= Gem::Specification.find_by_name("dependabot-common").gem_dir
end

def require_common_spec(path)
  case path.to_s
  when "shared_examples_for_autoloading"
    require "#{common_dir}/spec/dependabot/shared_examples_for_autoloading"
  when "file_fetchers/shared_examples_for_file_fetchers"
    require "#{common_dir}/spec/dependabot/file_fetchers/shared_examples_for_file_fetchers"
  when "file_parsers/shared_examples_for_file_parsers"
    require "#{common_dir}/spec/dependabot/file_parsers/shared_examples_for_file_parsers"
  when "file_updaters/shared_examples_for_file_updaters"
    require "#{common_dir}/spec/dependabot/file_updaters/shared_examples_for_file_updaters"
  when "metadata_finders/shared_examples_for_metadata_finders"
    require "#{common_dir}/spec/dependabot/metadata_finders/shared_examples_for_metadata_finders"
  when "update_checkers/shared_examples_for_update_checkers"
    require "#{common_dir}/spec/dependabot/update_checkers/shared_examples_for_update_checkers"
  else
    raise ArgumentError, "Unsupported common spec path: #{path.inspect}"
  end
end

require "#{common_dir}/spec/spec_helper.rb"
