# typed: strict
# frozen_string_literal: true

def common_dir
  @common_dir ||= Gem::Specification.find_by_name("dependabot-common").gem_dir
end

def common_spec_dir
  @common_spec_dir ||= File.expand_path("spec/dependabot", common_dir)
end

def require_common_spec(path)
  common_spec_path = File.expand_path(path.to_s, common_spec_dir)

  unless common_spec_path.start_with?("#{common_spec_dir}/")
    raise ArgumentError, "Invalid common spec path: #{path.inspect}"
  end

  require common_spec_path
end

require "#{common_dir}/spec/spec_helper.rb"
