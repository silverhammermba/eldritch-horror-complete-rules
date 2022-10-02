# run as: ruby -pi add_ids.rb INPUT
# add ids to each header derived from their text
# replaces all existing header attributes
if $_ =~ /\A(.*)<h(\d+)[^>]*>([^<]+)<\/h\d+>(.*)/
  pre, level, text, post = $1, $2, $3, $4
  id = text.gsub(/[^A-Za-z]+/, ?-).downcase
  id = id[1..-1] if id[0] == "-"
  id = id[0...-1] if id[-1] == "-"
  $_ = "#{pre}<h#{level} id=\"#{id}\">#{text}</h#{level}>#{post}\n"
end
