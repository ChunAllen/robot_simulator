require_relative '../robot.rb'
require 'spec_helper.rb'

describe Robot do

  let!(:instruction) { File.readlines 'instructions/instruction1.txt' }

  describe '.initialize' do
    before :each do
      @robot = Robot.new instruction
    end
    it 'sets the commands' do
      expect(@robot.commands).to eq ["PLACE", "0,0,NORTH", "MOVE", "REPORT"]
    end
    it 'sets the robot x initial placement' do
      expect(@robot.x).to eq '0'
    end
    it 'sets the robot y initial placement' do
      expect(@robot.y).to eq '0'
    end
    it 'sets the initialize robot facing' do
      expect(@robot.facing).to eq 'NORTH'
    end
    it 'sets the max_x grids' do
      expect(@robot.max_x).to eq 5
    end
    it 'sets the max_y grids' do
      expect(@robot.max_y).to eq 5
    end
    it 'sets the results' do
      expect(@robot.results).to eq nil
    end
  end

  describe '#execute' do
    context 'robot was placed on the table' do
      it 'returns the results' do
        robot = Robot.new instruction
        expect(robot.execute).to eq '0,1,NORTH'
      end
    end
    context 'robot wasn\t placed on the table' do
      let!(:not_placed_robot) { File.readlines 'instructions/not_placed_robot.txt' }
      it 'returns error message' do
        robot = Robot.new not_placed_robot
        robot.execute
        expect(robot.errors.full_messages).to include 'You must place the robot first into the table'
      end
    end
    context 'robot is about to fall of' do
      let!(:falling_robot) { File.readlines 'instructions/falling_robot.txt' }
      it 'returns an error message' do
        robot = Robot.new falling_robot
        robot.execute
        expect(robot.errors.full_messages).to include 'Your robot is about to fall of...'
      end
    end
  end

end

