#spec/tender_spec.rb

require "tender"

describe Tender::Lot do
  before(:each) do
    @bet1 = Tender::Bet.new("Stephen King", 300)
    @bet2 = Tender::Bet.new("Arthur Conan-Doyle", 100)
    @bet3 = Tender::Bet.new("Donald Trump", 400)
    @lot = Tender::Lot.new("Painting 1724", 200)
  end

  describe "open?" do
    context "check open lot" do
      context "before an auction" do
        it "open by default" do
          expect(@lot.open?).to be true
        end
      end

      context "after bet" do
        it "still open" do
          @lot.suggest_bet(@bet1)
          expect(@lot.open?).to be true
        end
      end
    end
  end

  describe "bet" do
    context "check lot is closed" do
      context "because of small start bet" do
        it "closed" do
          expect(@lot.suggest_bet(@bet2)).to be false
        end
      end
      context "beacause of small next bet" do
        it "closed to next bet" do
          @lot.suggest_bet(@bet1)
          expect(@lot.suggest_bet(@bet2)).to be false
        end
      end
    end
    context "sucsessful bet" do
      it "succeed" do
        @lot.suggest_bet(@bet1)
        expect(@lot.suggest_bet(@bet3)).to be true
      end
    end
    context "time is out" do
      it "too much time has gone" do
        @lot.suggest_bet(@bet1)
        @lot.send :duration=, Time.now - 30
        expect(@lot.open?).to be false
      end
    end
  end
end
