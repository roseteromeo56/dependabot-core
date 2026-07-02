# typed: false
# frozen_string_literal: true

require "spec_helper"

RSpec.describe "#require_common_spec" do
  it "raises for unsupported shared example paths" do
    expect { require_common_spec("../shared_examples_for_autoloading") }.to raise_error(ArgumentError)
  end
end