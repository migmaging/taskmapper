require 'spec_helper'

describe "Delete project" do 
  let(:client) do 
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end

  context "Given the backend has 2 projects" do 
    before do 
      client.project! :name => 'Awesome Project',
        :description => 'This is awesome!'

      client.project! :name => 'Bored Project',
        :description => 'This is bored'
    end

    subject { projects } 
    it { should have(2).items }

    describe :delete do 
      context "Given a project id" do 
        let(:project) { projects.first }
        subject { projects.delete project }
        it { should be_true }
      end
    end
  end
end

