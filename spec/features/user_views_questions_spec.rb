require 'rails_helper'

feature 'user views questions' do
  let! (:question_1) do
    Question.create(
      title: "Redirect using jQuery or pure JavaScript?",
      description: "How can I redirect the user from one page to another using jQuery or pure JavaScript?"
    )
  end

  let! (:question_2) do
    Question.create(
      title: "Some simple Ruby questions - iterators, blocks, and symbols",
      description: "I understand that yield means 'execute the associated block here.' What is throwing me is the |value| n = part of the each"
    )
  end

  scenario 'views list of questions' do
    # As a user -
    # I want to view recently posted questions So that I can help others
    # Acceptance Criteria
    # - I must see the title of each question
    # - I must see questions listed in order, most recently posted first

    visit "/questions"
    expect(page).to have_content(question_1.title)
    expect(page).to have_content(question_2.title)
    expect(page.body.index("#{question_2.title}") < page.body.index("#{question_1.title}")).to eq true
  end

  scenario 'views a question details' do
    # As a user
    # I want to view a question's details
    # So that I can effectively understand the question
    # Acceptance Criteria
    # - I must be able to get to this page from the questions index
    # - I must see the question's title
    # - I must see the question's description
    visit "/questions"
    find_link("#{question_1.title}").click
    expect(page).to have_content(question_1.title)
    expect(page).to have_content(question_1.description)


  end




end
