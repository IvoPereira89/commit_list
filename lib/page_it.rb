module PageIt
  def self.fetch(array, page, page_size)
    return array unless page && page > 0 && page_size && page_size > 0
    initial = (page-1) * page_size
    array[initial, page_size] || []
  end
end
