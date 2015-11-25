require 'pry'
require 'active_model'
require_relative 'robot_helper.rb'

class Robot

  include ActiveModel::Model
  include RobotHelper

  attr_accessor :commands, :x, :y, :facing, :max_x, :max_y, :results

  def initialize(commands)
   @commands = strip_by_white_spaces(commands)
   @x, @y, @facing = @commands[1].split(',')
   @max_x, @max_y = [5,5]
   @results = nil
  end

  def execute
   return unless is_placed?
   @commands.each_with_index do |command, index|
      placing_initial_coordinates(commands[index+1]) if command == "PLACE"
      case command
      when 'MOVE'
        move_into_new_position
      when 'LEFT'
        change_direction('LEFT')
      when 'RIGHT'
        change_direction('RIGHT')
      when 'REPORT'
        @results = generate_report
      end
   end
   @results
  end

  private

  def warning_message
    unless check_warning
      compose_error_message 'Your robot is about to fall of...', errors
    end
    errors.full_messages.first
  end

  def generate_report
    warning_message || "#{@x},#{@y},#{@facing}"
  end

  def is_placed?
    unless @commands.first == 'PLACE'
      compose_error_message 'You must place the robot first into the table', errors
    else
      true
    end
  end

  def placing_initial_coordinates(args)
    @x, @y, @facing = args.split(',')
    @x = @x.to_i
    @y = @y.to_i
  end

  def change_direction(direction)
    case @facing
    when 'NORTH'
      @facing = direction.eql?('LEFT') ? 'WEST' : 'EAST'
    when 'WEST'
      @facing = direction.eql?('LEFT') ? 'SOUTH' : 'NORTH'
    when 'SOUTH'
      @facing = direction.eql?('LEFT') ? 'EAST' : 'WEST'
    when 'EAST'
      @facing = direction.eql?('LEFT') ? 'NORTH' : 'SOUTH'
    end
  end

  def check_warning
    case @facing
    when "NORTH"
      return false
    when "WEST"
      return false if @x==0
    when "EAST"
      return false if @x==@max_x-1
    end if @y==@max_y-1

    case @facing
    when "SOUTH"
      return false
    when "WEST"
      return false if @x==0
    when "EAST"
      return false if @x==@max_x-1
    end if @y==0

    return false if @x==@max_x-1 && @facing == "EAST"
    return false if @x==0 && @facing == "WEST"

    return true
  end

  def move_into_new_position
    case @facing
    when 'NORTH'
      @y = @y+1 unless (@y+1) > (@max_y - 1)
    when 'WEST'
      @x = @x-1 unless (@x-1) < 0
    when 'SOUTH'
      @y = @y-1 unless (@y-1) < 0
    when 'EAST'
      @x = @x+1 unless (@x+1) > (@max_x - 1)
    end
  end

end