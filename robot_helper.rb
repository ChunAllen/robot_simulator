module RobotHelper

  def strip_by_white_spaces(commands)
    commands.join().gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').split(' ')
  end

  def compose_error_message(message, errors)
    errors.add :base, message
    false
  end

end
