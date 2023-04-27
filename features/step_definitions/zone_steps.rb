#NEED TO DOWNLOAD FIREFOX IN ORDER FOR THIS TO WORK

@javascript
Then /I should see "(.*)" twice/ do |field|
    expect(page).to have_content(field).twice
end

Given /^I wait for (\d+) seconds?$/ do |n|
    sleep(n.to_i)
end

@javascript
Then /I should see "(.*)" exactly once/ do |field|
    expect(page.body.scan(field).size).to eq(1)
end

And /I press enter on "(.*)"/ do |field|
    find_field(field).native.send_key(:enter)
end

Then /"(.*)" should be disabled/ do |field|
    expect(page).to have_button(field, disabled: true)
end

And /I press the first "(.*)" button$/ do |button|
    first('#'+button).click
end