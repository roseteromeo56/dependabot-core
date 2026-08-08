# typed: true
# frozen_string_literal: true

def require_common_spec(path)
  case path
  when "shared_examples_for_autoloading"
    require_relative "../../common/spec/dependabot/shared_examples_for_autoloading"
  when "metadata_finders/shared_examples_for_metadata_finders"
    require_relative "../../common/spec/dependabot/metadata_finders/shared_examples_for_metadata_finders"
  when "update_checkers/shared_examples_for_update_checkers"
    require_relative "../../common/spec/dependabot/update_checkers/shared_examples_for_update_checkers"
  when "file_updaters/shared_examples_for_file_updaters"
    require_relative "../../common/spec/dependabot/file_updaters/shared_examples_for_file_updaters"
  when "file_parsers/shared_examples_for_file_parsers"
    require_relative "../../common/spec/dependabot/file_parsers/shared_examples_for_file_parsers"
  when "file_fetchers/shared_examples_for_file_fetchers"
    require_relative "../../common/spec/dependabot/file_fetchers/shared_examples_for_file_fetchers"
  else
    raise ArgumentError, "Invalid common spec path: #{path}"
  end
end

require_relative "../../common/spec/spec_helper"
