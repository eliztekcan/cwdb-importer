require 'set'
require 'mongo'

def import(source, connection_string)
	f = File.open(source, "r")
	arr = Array.new
	f.each_line do |line|
		line = line.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		index = line.index(' ')
		data = {
			clue: line[index+1..-2],
			answer: line[0..index-1]
		}
		if(line.length > 0 )
			arr.push(data)
		end
	end

	client = Mongo::Client.new(connection_string)
	collection = client[:cwdb]
	result = collection.insert_many(arr)
	result.inserted_count
	f.close
end

def copy_unique_lines(source, target)
  lines = Set.new

  File.open(target, 'w') do |out|
    File.open(source, 'r').each_line do |line|
      if lines.add?(line)
        out << line
      end
    end
  end
end


def parse_clues(source,target)

	out_file = File.new(target, "w")
	f = File.open(source, "r")
	f.each_line do |line|
  		out_file.puts(line[0..25].strip + " " + line[37..-1])
	end
	f.close
	out_file.close
end

parse_clues('clues','out.txt')
copy_unique_lines('out.txt','new_txt')
import('new_txt',File.open('connection_string', &:readline))
