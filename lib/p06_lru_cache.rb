require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #compare max and count
    return @store.get(key) if @store.include?(key)
    @store.insert(key, @prc.call(key))
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # Why is calc empty?! It was never called, blasphemy!
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.append(link)
  end

  def eject!
    @store.eject_some_links
  end

  def recursive_search(query)
    return false if query.nil? || query.length == 0
    url = "https://www.google.com/search?query=#{query}"
    http_response = Net::HTTP.get(URI(url))
    html_obj = Nokogiri::HTML(http_response)
    # Depends on what kind of search result you want to feed back
    # into the loop
    text_nodes = html_obj.css('span.st')
    text_nodes.each do |text_node|
      puts text_node.text
      # recursive_search(link.values.last)
    end
  end
end
