require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Article do

  it "should not be valid without a title" do
    @article = Article.new
    @article.should_not be_valid
  end


end