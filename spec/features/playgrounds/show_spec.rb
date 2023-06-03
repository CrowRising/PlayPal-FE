require 'rails_helper'

RSpec.describe '/playgrounds#show' do
  describe 'Playground Show Page' do
    it 'displays name of playground, attributes and static img' do

      expect(page).to have_content('')
      expect(page).to have_content('')
      expect(page).to have_content('')
      expect(page).to have_content('')
      expect(page).to have_content('')
    end

    it 'displays links to home and user dashboards' do
      expect(page).to have_link('Home')
      expect(page).to_not have_link('Dashboard')
    end

    it 'displays button to add playground to favorites' do


    end
  end
end