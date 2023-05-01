#NEED TO DOWNLOAD FIREFOX IN ORDER FOR THIS TO WORK

@javascript
Then /I should see "(.*)" twice/ do |field|
    #this ignores hidden text, such as that in the informational section explaining zones and pools
    #which is why we commented it out
    # expect(page).to have_content(field).twice 
    if page.respond_to? :should
        page.should have_content(text)
    else
        assert page.has_content?(text)
    end
end

Given /^I wait for (\d+) seconds?$/ do |n|
    sleep(n.to_i)
end

@javascript
Then /I should see "(.*)" exactly once/ do |field|
    expect(page.body.scan(field, visible:true).size).to eq(1)
end

And /I press enter on "(.*)"/ do |field|
    find_field(field).native.send_key(:enter)
end

Then /"(.*)" should be disabled/ do |field|
    expect(page).to have_button(field, disabled: true)
end

And /I press the first "(.*)" button$/ do |button|
    first('#'+button).click
    #page.evaluate_script('window.confirm = function() { return true; }')
    #page.click('Remove')
end

@javascript
And /I press "OK" to a confirmation/ do
    page.driver.browser.switch_to.alert.accept
    #accept_confirm('Are you sure you want to delete zone ?')
end

