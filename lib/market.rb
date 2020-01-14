class Market

  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vender| vender.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    all_inventories = @vendors.map do |vendor|
      vendor.inventory
    end

    items = all_inventories.map do |inventory|
      inventory.keys
    end.flatten.uniq

    item_names = items.map do |item|
      item.name
    end.sort
  end

  def total_inventory
    @vendors.reduce(Hash.new(0)) do |acc, vendor|
      vendor.inventory.each do |item, amount|
        acc[item] += amount
        acc
      end
      acc
    end
  end
end
