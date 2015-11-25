$LOAD_PATH << '.'

for i in 0..119
  system("ruby perm.rb #{i}")
end