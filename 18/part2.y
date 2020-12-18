class Calcp
  prechigh
    left '+'
    left '*'
  preclow
rule
  target: exp
        | /* none */ { result = 0 }

  exp: exp '+' exp { result += val[2] }
     | exp '*' exp { result *= val[2] }
     | '(' exp ')' { result = val[1] }
     | NUMBER
end

---- header
#
---- inner

  def parse(str)
    @q = []
    until str.empty?
      case str
      when /\A\s+/
      when /\A\d+/
        @q.push [:NUMBER, $&.to_i]
      when /\A.|\n/o
        s = $&
        @q.push [s, s]
      end
      str = $'
    end
    @q.push [false, '$end']
    do_parse
  end

  def next_token
    @q.shift
  end

---- footer

parser = Calcp.new
puts(File.foreach('./input.txt').map do |line|
    parser.parse(line)
end.reduce(&:+))
