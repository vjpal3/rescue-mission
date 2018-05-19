require 'rails_helper'

feature 'user edits a question' do
  # As a user
  # I want to edit a question
  # So that I can correct any mistakes or add updates
  # Acceptance Criteria
  # - I must provide valid information
  # - I must be presented with errors if I fill out the form incorrectly
  # - I must be able to get to the edit page from the question details page
  let! (:question_1) do
    Question.create(
      title: "Redirect using jQuery or pure JavaScript?",
      description: "How can I redirect the user from one page to another using jQuery or pure JavaScript?"
    )
  end

  scenario 'successfully edits a question' do
    visit "/questions"
    find_link("#{question_1.title}").click
    find_link("Edit this Question").click

    expect(page).to have_content("Edit Question")
    fill_in "Title", with: "Some simple Ruby questions - iterators, blocks, and symbols"
    fill_in "Description",
      with: "I understand that yield means 'execute the associated block here.' What is throwing me is the |value| n = part of the each"
    click_button "Edit Question"
    expect(page).to have_content("Question details")
    expect(page).to have_content("Some simple Ruby questions - iterators, blocks, and symbols")
    expect(page).to have_content("Question was successfully updated")
  end

  scenario 'fails to edit the question' do
    visit "/questions"
    find_link("#{question_1.title}").click
    find_link("Edit this Question").click

    fill_in "Title", with: ""

    click_button "Edit Question"
    expect(page).to have_content("Edit Question")
    expect(page).to have_content("2 errors prohibited this question from being posted")
    expect(page).to have_field('Title', with: '')
    expect(page).to have_field('Description', with: 'How can I redirect the user from one page to another using jQuery or pure JavaScript?')
  end


end
