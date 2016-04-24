class Array
  def all_empty?
    self.empty?
  end

  def all_same?
    self.all? {|el| el == self.first}
  end

  def any_empty?
    self.any? {|el| el.empty?}
  end

  def none_empty?
    self.none? {|x| x.empty?}
  end
end
