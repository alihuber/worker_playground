require "spec_helper"


feature "test queue actions" do

  describe "index page and test queue" do
    it "lets one publish single messages" do
      visit("/")
      expect(page).to have_text("Publish Message:")

      fill_in("publish", with: "foo")
      click_button("publish-button")

      expect(current_path).to eq "/"
    end

    it "lets one flood 12 random messages" do
      visit("/")
      expect(page).to have_text("Publish Message:")

      click_button("flood-button")

      expect(current_path).to eq "/"
    end
  end
end
