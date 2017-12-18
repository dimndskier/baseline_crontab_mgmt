require 'spec_helper'
describe 'baseline_crontab_mgmt' do

  context 'with defaults for all parameters' do
    it { should contain_class('baseline_crontab_mgmt') }
  end
end
