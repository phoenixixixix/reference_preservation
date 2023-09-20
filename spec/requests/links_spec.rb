require "rails_helper"

RSpec.describe "Links", type: :request do
  let(:valid_attributes) { { title: "Link", url: "https://link.com"} }

  let(:invalid_attributes) { { title: "", url: "" } }

  describe "GET /index" do
    it "renders a successful response" do
      get links_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_link_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      link = create(:link)
      get edit_link_url(link)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates link record" do
      expect {
        post links_url, params: { link: valid_attributes }
      }.to change { Link.count }.by(1)
    end

    it "redirects to index links path" do
      post links_url, params: { link: valid_attributes }
      expect(response).to redirect_to(links_url)
    end

    context "with invalid params" do
      it "does not create a new Link" do
        expect {
          post links_url, params: { link: invalid_attributes }
        }.to change(Link, :count).by(0)
      end

      it "renders new template" do
        post links_url, params: { link: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it "respond with 422 status" do
        post links_url, params: { link: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { title: "Linko", url: "http://linko.com"} }

    subject { create(:link) }

    it "updates link record" do
      patch link_url(subject), params: { link: new_attributes }
      subject.reload

      expect(subject.title).to eq(new_attributes[:title])
      expect(subject.url).to eq(new_attributes[:url])
    end

    it "redirects to index links path" do
      patch link_url(subject), params: { link: new_attributes }
      expect(response).to redirect_to(links_url)
    end

    context "with invalid params" do
      it "renders edit template" do
        patch link_url(subject), params: { link: invalid_attributes }
        expect(response).to render_template(:edit)
      end

      it "respond with 422 status" do
        patch link_url(subject), params: { link: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:link) { create(:link) }

    it "deletes link record" do
      expect { delete link_url(link) }.to change { Link.count }.by(-1)
      expect { link.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to links list" do
      delete link_url(link)
      expect(response).to redirect_to(links_url)
    end
  end
end
