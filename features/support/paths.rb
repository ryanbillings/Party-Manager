module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
      
    when /my account page/
      edit_host_path(@an)
      
    when /the graduation party details page/
      party_path(@grad)
      
    when /the birthday party details page/
      party_path(@birthday)
      
    when /this party details page/
      party_path(Party.last)
      
    when /my parties page/
      parties_path
      
    when /the new party page/
      new_party_path
      
    when /my locations page/
      locations_path
      
    when /the new location page/
      new_location_path
      
    when /my house details page/
      location_path(@home)
    
    when /my invitations page/
      invitations_path
      
    when /the new invitation page/
      new_invitation_path
    
    when /the rsvp page/
      rsvp_path
    
    when /edit the graduation party/
      edit_party_path(@grad)
    
    when /edit the birthday party/
      edit_party_path(@birthday)
    
    when /my guests page/
      guests_path
      
    when /this guest details page/
      guest_path(@artis)
      
    when /the new guest page/
      new_guest_path
      
    when /edit this guest page/
      edit_guest_path(@artis)
      
    when /the About Us page/
      about_path
      
    when /the Contact Us page/
      contact_path
      
    when /the Privacy page/
      privacy_path
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
