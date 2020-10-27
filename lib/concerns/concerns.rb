module Concerns::Findable
  def find_by_name(title)
    all.find { |item| item.name == title }
  end

  def find_or_create_by_name(title)
    # found = find_by_name(title)
    # return create(title) if !found
    return create(title) if !found = find_by_name(title)
    found
  end
end
