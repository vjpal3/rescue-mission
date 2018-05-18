require 'rails_helper'

feature 'user posts a question' do

  scenario 'user successfully posts a question' do
    # As a user
    # I want to post a question
    # So that I can receive help from others
    # Acceptance Criteria
    # - I must provide a title that is at least 20 characters long
    # - I must provide a description that is at least 50 characters long
    # - I must be presented with errors if I fill out the form incorrectly

    visit "/questions"
    find_link("Post a Question").click
    expect(page).to have_content("Post a Question")
    fill_in "Title", with: "Some simple Ruby questions - iterators, blocks, and symbols"
    fill_in "Description",
      with: "I understand that yield means 'execute the associated block here.' What is throwing me is the |value| n = part of the each"
    click_button "Post Question"
    expect(page).to have_content("Question details")
    expect(page).to have_content("Some simple Ruby questions - iterators, blocks, and symbols")
    expect(page).to have_content("Question was successfully posted")
  end

  scenario 'user fails to post a question' do
    visit "/questions"
    find_link("Post a Question").click
    click_button "Post Question"

    expect(page).to have_content("Title is too short (minimum is 20 characters)")
    expect(page).to have_content("Description is too short (minimum is 50 characters)")
  end


end
