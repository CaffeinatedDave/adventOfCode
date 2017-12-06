require 'digest/md5'
md5 = Digest::MD5.new

input = "yzbqklnj"

found5 = 0
found6 = 0
ptr = 0
until found6 > 0
  ptr += 1

  hex = md5.hexdigest("#{input}#{ptr}")
  if (hex[0,5] == "00000" and found5 == 0)
    found5 = ptr
  end
  if hex[0,6] == "000000"
    found6 = ptr
  end
end

puts "Found 5 match at #{found5}"
puts "Found 6 match at #{found6}"
