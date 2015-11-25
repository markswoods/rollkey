$LOAD_PATH << '.'

set = "ABCDE".split("").permutation.collect {|p| p.join }

keycode = set.delete(set[0])
while set.length > 0
  n = set.select {|p| p.start_with?(keycode[-4..-1])} # find next matching sequence
  if n[0]
    keycode += n[0][-1] # Add the last letter, rolling the code
    set.delete(n[0])
  else
    keycode += set[0]   # Need to start a new chain, pick first element remaining in set
    set.delete(set[0])
  end
end

# Check for any duplicates embedded in the string
i = 0
morestring = true
while morestring
  key = keycode[i, 5]
  off = keycode.index(key, i+1)
  if off 
    pre = keycode.slice(0, off) 
    post = keycode.slice((off+5)..-1)
    keycode = pre + post
  end
  i += 1    
  if i+5 > keycode.length  
    morestring = false
  end
end

puts "length: #{keycode.length}\nKey: #{keycode}"