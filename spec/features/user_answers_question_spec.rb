require 'rails_helper'

feature 'user answers a question' do
  # As a user
  # I want to answer another user's question
  # So that I can help them solve their problem
  # Acceptance Criteria
  # - I must be on the question detail page
  # - I must provide a description that is at least 50 characters long
  # - I must be presented with errors if I fill out the form incorrectly
  
  let! (:question_1) do
    Question.create(
      title: "How do I remove a particular element from an array in JavaScript?",
      description: "From an array of integers, how to remove a specific element? The equivalent of something like array.remove(int)."
    )
  end

  scenario 'user successfully answers a question' do
    visit "/questions"
    find_link("#{question_1.title}").click
    expect(page).to have_content(question_1.description)
    fill_in "answer_description", with: "Find the index of the array element you want to remove, then remove that index with splice."
    click_button "Submit Answer"
    expect(page).to have_content("Find the index of the array element you want to remove, then remove that index with splice.")
    expect(page).to have_content("Answer was successfully posted")
  end

  scenario "failure to post an answer" do
    visit "/questions"
    find_link("#{question_1.title}").click
    click_button "Submit Answer"
    expect(page).to have_content("Answer is too short (minimum is 50 characters)")
    expect(page).to have_field("answer_description")
  end
end
