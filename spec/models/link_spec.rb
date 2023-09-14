require "rails_helper"

RSpec.describe Link, type: :model do
  describe "#valid?" do
    let(:link) { build(:link) }

    subject { link.valid? }

    it { is_expected.to be true }
  end

  describe "validations" do
    subject { build(:link) }

    describe "title" do
      context "when empty" do
        before { subject.title = "" }

        it { expect(subject.valid?).not_to be(true) }

        it "throws errors" do
          subject.valid?

          expect(subject.errors.full_messages).to include("Title can't be blank")
        end
      end
    end

    describe "url" do
      context "when empty" do
        before { subject.url = "" }

        it { expect(subject.valid?).not_to be(true) }

        it "throws errors" do
          subject.valid?

          expect(subject.errors.full_messages).to include("Url can't be blank")
        end
      end
    end
  end
end
