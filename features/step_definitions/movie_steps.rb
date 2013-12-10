# Add a declarative step here for populating the DB with movies.

Given /the following verses exist/ do |movies_table|
  movies_table.hashes.each do |movie|
     Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
   assert(page.body.index(e1) < page.body.index(e2))
end

Then  /I should see all verses/ do
  rows = page.body.scan(/<tr>/).length - 1
  assert(rows == Movie.all.length)
end

Then /I should not see any verses/ do
  #assert page.has_no_content?()
end
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
   rating_list.split(",").each { |rating| step "I #{uncheck}check \"ratings_#{rating.strip}\"" }
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
