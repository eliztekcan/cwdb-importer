out_file = File.new("out.txt", "w")
f = File.open('clues', "r")
f.each_line do |line|
  #line = line.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
  #out_file.puts(line.split("\s").join(","))
  out_file.puts(line[0..25].strip + " " + line[37..-1])
end
f.close
out_file.close