class IncreaseAddressService

  def call(address)
    count = address[-1, 1].to_i
    address[-1, 1] = (count + 1).to_s
    address
  end

end
