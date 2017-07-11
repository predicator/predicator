module Predicator
  class HandParser
    def initialize
      @lexer = Lexer.new
      @tokens = []
    end

    def parse string
      @lexer.parse string
      while token = @lexer.next_token
        @tokens << token
      end

      parse_predicate
    end

    def parse_predicate
      left = parse_single_predicate
      if peek :AND
        consume :AND
        right = parse_single_predicate
        AST::And.new left, right
      elsif peek :OR
        consume :OR
        right = parse_single_predicate
        AST::And.new left, right
      else
        left
      end
    end

    def parse_single_predicate
      if peek :TRUE
        parse_true
      elsif peek :FALSE
        parse_false
      elsif peek :BANG
        parse_not
      elsif peek :LPAREN
        parse_group
      end
    end

    def parse_not
      consume :BANG
      predicate = parse_predicate
      AST::Not.new predicate
    end

    def parse_group
      consume :LPAREN
      predicate = parse_predicate
      consume :RPAREN
      AST::Group.new predicate
    end

    def parse_true
      value = consume :TRUE
      AST::True.new true
    end

    def parse_false
      value = consume :FALSE
      AST::False.new false
    end

    def consume expected_type
      token = @tokens.shift
      if !token.nil? && token.first == expected_type
        token
      else
        type = token.nil? ? nil : token.first
        binding.pry
        raise RuntimeError.new(
          "Expected token type #{expected_type} but got #{type}")
      end
    end

    def peek expected_type
      return false if @tokens.empty?
      @tokens.fetch(0).first == expected_type
    end
  end
end
