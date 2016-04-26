require "minitest/test"

module Minitest; end # :nodoc: -- ugh rdoc sucks hard sometimes

class Minitest::Test
  VERSION = "1.0.0" # :nodoc:

  ##
  # Getter for prove_it class variable

  def self.prove_it
    @@prove_it ||= false
  end

  ##
  # Setter for prove_it class variable. true/false

  def self.prove_it= o
    @@prove_it = o
  end

  ##
  # Call this at the top of your tests when you want to force all
  # tests to prove success (via at least one assertion) rather
  # than rely on the absence of failure.

  def self.prove_it!
    @@prove_it = true unless defined? @@prove_it
  end

  TEARDOWN_METHODS << "assert_proven?"

  def assert_proven? # :nodoc:
    flunk "Absence of failure is not success. Prove it!" if
      self.class.prove_it && self.failures.empty? && self.assertions == 0
  end
end

##
# Hooks Minitest::Test.run to enforce prove_it! for all tests.
#
# TODO: to be moved to minitest/hell?

class Minitest::Test
  def self.run reporter, options = {} # :nodoc:
    prove_it!
    super
  end
end if ENV["MT_HELL"]
