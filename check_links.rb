require 'set'
require 'did_you_mean'

valid_hrefs = Set.new
hrefs = []

File.open(ARGV[0]).each_line do |line|
  line.scan(/id="[^"]+"/).each do |id|
    id = id[4...-1]
    href = "##{id}"
    if valid_hrefs.include? href
      warn "duplicate id: #{id}"
    end
    valid_hrefs << href
  end

  if line !~ /stylesheet/
    line.scan(/href="[^"]+"/).each do |href|
      href = href[6...-1]
      hrefs << href
    end
  end
end

longest = hrefs.map(&:length).max

hrefs.each do |href|
  unless valid_hrefs.include? href
    best = valid_hrefs.min_by { |valid| DidYouMean::Levenshtein.distance(href, valid) }
    warn "%#{longest}s => #{best}" % href
  end
end
