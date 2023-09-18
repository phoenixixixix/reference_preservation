require "rails_helper"

RSpec.describe Group, type: :model do
  describe "#valid?" do
    let(:group) { build(:group) }

    subject { group.valid? }

    it { is_expected.to be true }
  end

  describe "validations" do
    subject { build(:group) }

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
  end

  describe "relations" do
    describe "has many Links" do
      subject { create(:group) }

      it "returns associated links" do
        associated_link = create(:link, group: subject)

        expect(subject.links).to include(associated_link)
      end
    end
  end
end
