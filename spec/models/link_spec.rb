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

  describe "relations" do
    describe "belonging to Group" do
      let(:belonging_group) { create(:group) }

      it "creates links that belongs to group" do
        link = create(:link, group: belonging_group)

        expect(link.group).to eq(belonging_group)
      end

      it "creates links from Group object" do
        link_attributes = { title: "FromGroupObject", url: "https://hello.com"}

        belonging_group.links.create(link_attributes)

        expect(belonging_group.links.pluck(:title)).to include(link_attributes[:title])
      end
    end
  end

  describe "scopes" do
    describe "::by_group" do
      let(:scope_group) { create(:group, title: "ScopeGroup") }

      it "returns links referenced to specified group" do
        link = create(:link, group: scope_group)
        expect(Link.by_group(scope_group)).to include(link)
      end

      it "does not return links out of scope" do
        unexpected_link = create(:link, :ungrouped)
        expect(Link.by_group(scope_group)).not_to include(unexpected_link)
      end

      it "returns links by specified group id" do
        link = create(:link, group: scope_group)
        group_id = scope_group.id

        expect(Link.by_group(group_id)).to include(link)
      end
    end
  end
end
