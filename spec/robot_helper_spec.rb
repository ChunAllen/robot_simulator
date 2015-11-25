require_relative '../robot_helper.rb'
require_relative '../robot.rb'
require 'active_model'
require 'spec_helper.rb'

describe RobotHelper do

  class TestClass
    include ActiveModel::Model
  end

  include RobotHelper

  let!(:instruction) { File.readlines 'instructions/instruction1.txt' }

  describe '#strip_by_white_spaces' do
    it 'strips white spaces and next lines from the text file' do
      expect(strip_by_white_spaces(instruction)).to eq ["PLACE", "0,0,NORTH", "MOVE", "REPORT"]
    end
  end

  describe '#compose_error_message' do
    before :each do
      @test_class = TestClass.new
      @error = compose_error_message 'Robot failed to execute', @test_class.errors
    end
    it 'returns false' do
      expect(@error).to eq false
    end
    it 'returns error message' do
      expect(@test_class.errors.full_messages).to include 'Robot failed to execute'
    end
  end

end
