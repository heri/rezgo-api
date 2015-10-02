# We need to override Array's to_query to add an index # since ActiveSupport by default does not include one.
# IE, return: tour_group[adult][1][first_name]=Alex&tour_group[adult][1][last_name]=Kremer
# Instead of: tour_group[adult][][first_name]=Alex&tour_group[adult][][last_name]=Kremer
class Array
  def to_query(key)
    to_enum(:each_with_index).collect { |value, index| value.to_query("#{key}[#{index+1}]") }.join('&')
  end
end
