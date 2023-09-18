require "rails_helper"

RSpec.describe "Links", type: :request do
  describe "POST /links" do
    let(:link_params) { { title: "Linko", url: "https://linko.com"} }

    it "creates link record" do
      expect {
        post "/links", params: { link: link_params }
      }.to change { Link.count }.by(1)
    end

    it "redirects to index links path" do
      post "/links", params: { link: link_params }

      expect(response).to redirect_to("/links")
    end

    context "with invalid params" do
      let(:invalid_link_params) { { title: "", url: "" } }
      before { post "/links", params: { link: invalid_link_params } }

      it { expect(response).to render_template(:new) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "PUT /links/:id" do
    let(:updated_link_params) { { title: "Linko", url: "http://linko.com"} }
    subject { create(:link) }

    it "updates link record" do
      put "/links/#{subject.id}", params: { link: updated_link_params }
      subject.reload

      expect(subject.title).to eq(updated_link_params[:title])
      expect(subject.url).to eq(updated_link_params[:url])
    end

    it "redirects to index links path" do
      put "/links/#{subject.id}", params: { link: updated_link_params }

      expect(response).to redirect_to("/links")
    end

    context "with invalid params" do
      let(:invalid_link_params) { { title: "", url: "" } }
      before { put "/links/#{subject.id}", params: { link: invalid_link_params } }

      it { expect(response).to render_template(:edit) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "DELETE /links/:id" do
    subject { create(:link) }

    it "deletes link record" do
      subject

      expect { delete "/links/#{subject.id}" }.to change { Link.count }.by(-1)
      expect { subject.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
