require_relative '../lib/app'

describe "the crypto_scrapper method" do
  it "should return a hash, and hash is not nil" do
    expect(crypto_scrapper).not_to be_nil
  end

  it "should contain at least 15 cryptocurrencies" do
    expect(crypto_scrapper).to have_attributes(size: (be > 15))
  end

  it "should include BTC as hash key" do
    expect(crypto_scrapper.has_key?("BTC")).to eq(true)
  end

  it "should include AAVE as hash key" do
    expect(crypto_scrapper.has_key?("AAVE")).to eq(true)
  end

  it "should not have any nil values" do
    expect(crypto_scrapper.values).not_to include(nil)
  end

  # Difference between Ni and nul?

end