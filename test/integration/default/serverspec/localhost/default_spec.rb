require 'spec_helper'

describe service('cm-update-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
end

# TODO: GET any api response

# TODO: Manually add image to db

# TODO: GET image listing
