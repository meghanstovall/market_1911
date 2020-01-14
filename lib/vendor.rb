class Vendor

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(itm)
    #refactor
    found_item = nil
    @inventory.each do |item, stock|
      if item = itm
        found_item = item
      end
    end
    @inventory[found_item]
  end

  def stock(item, amount)
    @inventory[item] += amount
  end
end
