require 'spec_helper'

describe Admin::Appointments2Helper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(Admin::Appointments2Helper)
  end

end
