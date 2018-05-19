require 'rails_helper'

feature 'user deletes a question' do
  # As a user
  # I want to delete a question
  # So that I can delete duplicate questions
  # Acceptance Criteria
  # - I must be able delete a question from the question edit page
  # - I must be able delete a question from the question details page
  # - All answers associated with the question must also be deleted

  let! (:question_1) do
    Question.create(
      title: "Redirect using jQuery or pure JavaScript?",
      description: "How can I redirect the user from one page to another using jQuery or pure JavaScript?"
    )
  end

  scenario 'successfully deletes a question from question detail page' do
    visit "/questions"
    find_link("#{question_1.title}").click
    find_link("Delete this Question").click
    expect(page).to_not have_content("Redirect using jQuery or pure JavaScript?")
  end

  scenario 'successfully deletes a question from question edit page' do
    visit "/questions"
    find_link("#{question_1.title}").click
    find_link("Edit this Question").click
    find_link("Delete this Question").click
    expect(page).to_not have_content("Redirect using jQuery or pure JavaScript?")
  end

end
