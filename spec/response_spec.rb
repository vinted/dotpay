require 'spec_helper'

describe Dotpay::Response do
  before :each do
    Dotpay.configure do |config|
      config.account_id             = 1234
      config.pin                    = 'testtesttesttest'
    end
  end

  describe "#authorized?" do
    let(:params) do
      { "status"=>"FAIL",
        "control"=>"5DA5L8F5",
        "amount"=>"1.00",
        "id"=>"66548",
        "transaction_id"=>"66548-TST55",
        "t_id"=>"66548-TST55",
        "t_date"=>"2013-02-13 16:23:43",
        "o_id"=>"66548-ZTST55",
        "email"=>"test@email.com",
        "t_status"=>"3",
        "description"=>"Uzsakymo 5DA5L8F5 apmokejimas",
        "version"=>"1.4",
        "orginal_amount"=>"1.00 PLN",
        "channel"=>"20",
        "md5"=>"a4d146472f99f123d0960732dcfd4be8"}
    end

    let(:response) { Dotpay::Response.new(params) }

    subject { response.authorized? }

    it { should be_true }

    context "invalid pin" do
      before { Dotpay.configuration.stub(:pin).and_return('badpin') }
      it { should be_false }
    end
  end

  describe "#status_done?" do
    let(:params) do
      { "status"=>"OK",
        "control"=>"5DA5L8F5",
        "amount"=>"1.00",
        "id"=>"66548",
        "transaction_id"=>"66548-TST55",
        "t_id"=>"66548-TST55",
        "t_date"=>"2013-02-13 16:23:43",
        "o_id"=>"66548-ZTST55",
        "email"=>"test@email.com",
        "t_status"=>"2",
        "description"=>"Uzsakymo 5DA5L8F5 apmokejimas",
        "version"=>"1.4",
        "orginal_amount"=>"1.00 PLN",
        "channel"=>"20",
        "md5"=>"a4d146472f99f123d0960732dcfd4be8"}
    end

    let(:response) { Dotpay::Response.new(params) }

    subject { response.status_done? }

    it { should be_true }

    context "not done" do
      let(:params) do
        { "status"=>"FAIL",
          "control"=>"5DA5L8F5",
          "amount"=>"1.00",
          "id"=>"66548",
          "transaction_id"=>"66548-TST55",
          "t_id"=>"66548-TST55",
          "t_date"=>"2013-02-13 16:23:43",
          "o_id"=>"66548-ZTST55",
          "email"=>"test@email.com",
          "t_status"=>"3",
          "description"=>"Uzsakymo 5DA5L8F5 apmokejimas",
          "version"=>"1.4",
          "orginal_amount"=>"1.00 PLN",
          "channel"=>"20",
          "md5"=>"a4d146472f99f123d0960732dcfd4be8"}
      end

      it { should be_false }
    end

    describe "#status_rejected?" do
      let(:params) do
        { "status"=>"FAIL",
          "control"=>"5DA5L8F5",
          "amount"=>"1.00",
          "id"=>"66548",
          "transaction_id"=>"66548-TST55",
          "t_id"=>"66548-TST55",
          "t_date"=>"2013-02-13 16:23:43",
          "o_id"=>"66548-ZTST55",
          "email"=>"test@email.com",
          "t_status"=>"3",
          "description"=>"Uzsakymo 5DA5L8F5 apmokejimas",
          "version"=>"1.4",
          "orginal_amount"=>"1.00 PLN",
          "channel"=>"20",
          "md5"=>"a4d146472f99f123d0960732dcfd4be8"}
      end

      let(:response) { Dotpay::Response.new(params) }

      subject { response.status_rejected? }

      it { should be_true }

      context "not rejected" do
        let(:params) do
          { "status"=>"OK",
            "control"=>"5DA5L8F5",
            "amount"=>"1.00",
            "id"=>"66548",
            "transaction_id"=>"66548-TST55",
            "t_id"=>"66548-TST55",
            "t_date"=>"2013-02-13 16:23:43",
            "o_id"=>"66548-ZTST55",
            "email"=>"test@email.com",
            "t_status"=>"2",
            "description"=>"Uzsakymo 5DA5L8F5 apmokejimas",
            "version"=>"1.4",
            "orginal_amount"=>"1.00 PLN",
            "channel"=>"20",
            "md5"=>"a4d146472f99f123d0960732dcfd4be8"}
        end

        it { should be_false }
      end
    end
  end
end
