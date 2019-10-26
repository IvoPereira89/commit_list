require 'spec_helper'
require "page_it"

describe PageIt do
  describe "when create with wrong params" do
    it "return the correct elements" do
      expect(PageIt.fetch([1, 2, 3, 4, 5], 2, 2)).to eql([3, 4])
    end
  end
end
