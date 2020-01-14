class Vendor

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(itm)
    found_item = @inventory.find do |item, stock|
      item == itm
    end
    @inventory[found_item[0]]
  end

  def stock(item, amount = 0)
    @inventory[item] += amount
  end
end
