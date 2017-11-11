describe yumrepo('epel'), :if => os[:family] == 'redhat' do
  it { should exist }
  it { should be_enabled }
end

describe command('type pip') do
  its(:exit_status) { should eq 0 }
end
