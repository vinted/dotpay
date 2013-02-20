require 'spec_helper'

describe Dotpay do
  before :each do
    Dotpay.configure do |config|
      config.account_id             = 1234
      config.pin                    = 'testtesttesttest'
      config.cancel_login           = 'testlogin'
      config.cancel_password        = 'testpass'
    end
  end

  it "should have defaults" do
    Dotpay.configuration.endpoint.should == 'https://ssl.dotpay.pl/'
    Dotpay.configuration.cancel_endpoint.should == 'https://ssl.dotpay.pl/api/cancel/'
    Dotpay.configuration.language.should == :pl
  end

  describe "#configure" do
    it "should allow configuring" do
      Dotpay.configuration.account_id.should        == 1234
      Dotpay.configuration.pin.should               == 'testtesttesttest'
      Dotpay.configuration.cancel_login.should      == 'testlogin'
      Dotpay.configuration.cancel_password.should   == 'testpass'
    end
  end

  describe "#cancel_transaction" do
    subject { Dotpay.cancel_transaction("TX01", 1.00, 'ABC') }

    context "successful" do
      before do
        stub_request(:post, "https://ssl.dotpay.pl/api/cancel/").
          with(:body => {
          "amount"=>"1.00",
          "control"=>"ABC",
          "id"=>"1234",
          "login"=>"testlogin",
          "md5"=>"e077b995f4e592ce5b9a428df2d009bf",
          "passwd"=>"testpass",
          "t_id"=>"TX01",
          "type"=>"1"}
        ).to_return(:status => 200, :body => "OK", :headers => {})
      end

      it { should be_true }
    end

    context "error" do
      before do
        stub_request(:post, "https://ssl.dotpay.pl/api/cancel/").
          with(:body => {
          "amount"=>"1.00",
          "control"=>"ABC",
          "id"=>"1234",
          "login"=>"testlogin",
          "md5"=>"e077b995f4e592ce5b9a428df2d009bf",
          "passwd"=>"testpass",
          "t_id"=>"TX01",
          "type"=>"1"}
        ).to_return(:status => 200, :body => "err01", :headers => {})
      end

      specify do
        expect { subject }.to raise_error(Dotpay::Error)
      end
    end
  end
end
