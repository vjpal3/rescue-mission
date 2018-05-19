require 'rails_helper'

feature 'user views questions' do
  let! (:question_1) do
    Question.create(
      title: "Redirect using jQuery or pure JavaScript?",
      description: "How can I redirect the user from one page to another using jQuery or pure JavaScript?"
    )
  end

  let! (:answer_1_1) do
    question_1.answers.create(
      description: "In JavaScript and jQuery we use this following code to redirect the page: window.location.href='http://google.com'; window.location.replace('page1.html');"
    )
  end

  let! (:question_2) do
    Question.create(
      title: "Some simple Ruby questions - iterators, blocks, and symbols",
      description: "I understand that yield means 'execute the associated block here.' What is throwing me is the |value| n = part of the each"
    )
  end

  let! (:answer_2_1) do
    question_2.answers.create(
      description: "For the definition of inject, you are basically setting up chained blocks."
    )
  end

  let! (:answer_2_2) do
    Answer.create(
      description: "In the inject or reduce method, n represents an accumulated value; this means the result of every iteration is accumulated in the n variable. This could be, as is in your example, the sum or product of the elements in the array. yield returns the result of the block, which is stored in n and used in the next iterations. This is what makes the result cumulative.",
      question_id: question_2.id
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
    expect(page).to have_content("Question details")

  end

  scenario "views a question's answers, most recent last"do
    # As a user
    # I want to view the answers for a question
    # So that I can learn from the answer
    # Acceptance Criteria
    # - I must be on the question detail page
    # - I must only see answers to the question I'm viewing
    # - I must see all answers listed in order, most recent last
    #
    visit "/questions"
    find_link("#{question_2.title}").click
    expect(page).to have_content(question_2.title)
    expect(page).to have_content(answer_2_1.description)
    expect(page).to_not have_content(answer_1_1.description)
    expect(page).to have_content(answer_2_2.description)
    expect(page.body.index("#{answer_2_1.description}") < page.body.index("#{answer_2_2.description}")).to eq true
  end




end
