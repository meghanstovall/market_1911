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

  def sell(item, amount)
    all_inventory = total_inventory
    if amount > all_inventory[item]
      false
    else
      update_stock_when_selling(item, amount)
      true
    end
  end

  def update_stock_when_selling(item, amount)
    vendors_with_item = @vendors.find_all do |vender|
      vender.inventory.keys.include?(item)
    end

    count = 0
    until amount == 0
      first_vendor = vendors_with_item.shift
      if first_vendor.inventory[item] < amount
        count += first_vendor.inventory[item]
        first_vendor.inventory[item] = 0
        amount = amount - count
      else
        first_vendor.inventory[item] -= amount
        amount = 0
      end
    end
  end
end
