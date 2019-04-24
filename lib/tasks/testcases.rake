require "pathname"
require "predicator/test_generator"

namespace :testcases do
  desc "Generate testcase classes from predicator_tests"
  task :generate do
    predicator_root = Pathname.new File.expand_path "../..", __dir__
    testcases_path = predicator_root.join "../predicator_tests"

    testcases_path.glob "evaluator/*.yml" do |file|
      generator = ::Predicator::TestGenerator.new predicator_root, file
      generator.generate
    end
  end
end
