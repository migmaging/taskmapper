require 'spec_helper'

describe "Search projects" do
  let(:client) do
    TaskMapper::Client.new :kanbanpad, 
      { :user => 'foo', :password => 'bar' },
      :projects_provider => projects_provider
  end
  
  let(:search_results) { client.projects search_criteria }
  
  let(:projects_provider) { double :projects_provider }
  
  context "Given no search criteria is passed" do
    let(:search_criteria) { nil }
    
    context "Given the backend has 2 projects" do
      let(:backend_projects) do
        [{
          :id => 1,
          :name => 'p1',
          :description => 'desc',
          :created_at => Time.now,
        },
        {
          :id => 2,
          :name => 'p2',
          :description => 'desc'
        }]
      end
      
      before do 
        projects_provider.should_receive(:list)
        .and_return backend_projects  
      end
      
      describe :search_results do
        subject { search_results }
      
        its(:count) { should == 2 }
      
        describe :first do
          subject { search_results.first }
          its(:id) { should == 1 }
          its(:name) { should == 'p1' }
          its(:description) { should == 'desc' }
          its(:created_at) { should be_a Time }
        end
      end
    end
  end
end
