require "yaml"

module ::Predicator
  class TestGenerator
    include ERB::Util
    attr_reader :project_root, :input_filename, :test_case

    def initialize project_root, input_filename
      @project_root = project_root
      @input_filename = input_filename
      @test_case = YAML.safe_load File.read input_filename
    end

    def test_case_name
      test_case["name"]
    end

    def class_name
      classify test_case_name
    end

    def instructions
      test_case["instructions"]
    end

    def tests
      test_case["tests"]
    end

    def generate
      folder = input_filename.dirname.basename.to_s
      output_filename = project_root.join *%W[ test cases #{folder} test_#{test_case_name}.rb ]
      puts "Generating #{output_filename.relative_path_from(project_root)}"
      output_filename.dirname.mkdir unless output_filename.dirname.exist?
      File.write output_filename, render
    end

    private

    def render
      ERB.new(test_class_template).result(binding)
    end

    def classify string
      string.to_s.split('_').collect!{ |w| w.capitalize }.join
    end

    def test_class_template
      <<~TEMPLATE
        require "helper"

        class <%= class_name %>Test < ::Minitest::Test
          attr_reader :instructions

          def setup
            @instructions = <%= instructions %>
          end
        <% tests.each do |test| %>
          def test_<%= test["name"] %>
            context = <% if test["context"].nil? %>nil<% else %><%= test["context"] %><% end %>
            expected_result = <% if test["result"].nil? %>nil<% else %><%= test["result"] %><% end %>

            e = ::Predicator::Evaluator.new instructions, context
            assert_equal expected_result, e.result
            assert_empty e.stack
          end
        <% end %>
        end
      TEMPLATE
    end
  end
end
