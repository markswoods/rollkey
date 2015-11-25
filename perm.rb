$LOAD_PATH << '.'

seed = ARGV[0].to_i
if seed == ""
  seed = 30   # Note: 0 works just as well
end

set = "ABCDE".split("").permutation.collect {|p| p.join }

keycode = set.delete(set[seed])
while set.length > 0
  n = set.select {|p| p.start_with?(keycode[-4..-1])} # find next matching sequence
  if n[0]
    keycode += n[0][-1] # Add the last letter, rolling the code
    set.delete(n[0])
  else
    # find the best available key to start with
    n = set.select {|p| p.start_with?(keycode[-3..-1])} 
    if n[0]
      keycode += n[0][-2..-1] # take last two characters
      set.delete(n[0])
    else
      n = set.select {|p| p.start_with?(keycode[-2..-1])} 
      if n[0]
        keycode += n[0][-3..-1] # take last three characters
        set.delete(n[0])
      else
        n = set.select {|p| p.start_with?(keycode[-1])} 
        if n[0]
          keycode += n[0][-4..-1] # take last four characters
          set.delete(n[0])
        else
          keycode += set[0]   # Need to start a new chain, pick first element remaining in set
          set.delete(set[0])
        end
      end
    end  
  end
end

#puts "length: #{keycode.length} using #{seed}:#{keycode[0..4]} as seed\n"
puts "#{keycode}"