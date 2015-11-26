# Robot Simulator
### Description
- The application is a simulation of a toy robot moving on a square tabletop,
  of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be
  prevented from falling to destruction. Any movement that would result in the
  robot falling from the table must be prevented, however further valid
  movement commands must still be allowed.

### Instructions for the Robot
```
    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT
```
- **PLACE** will put the toy robot on the table in position X,Y and facing NORTH,
  SOUTH, EAST or WEST.
- The origin **(0,0)** can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any
  sequence of commands may be issued, in any order, including another PLACE
  command. The application should discard all commands in the sequence until
  a valid PLACE command has been executed.
- **MOVE** will move the toy robot one unit forward in the direction it is
  currently facing.
- **LEFT** and **RIGHT** will rotate the robot 90 degrees in the specified direction
  without changing the position of the robot.
- **REPORT** will announce the X,Y and F of the robot. This can be in any form,
  but standard output is sufficient.


### Constraints
- The toy robot must not fall off the table during movement. This also
  includes the initial placement of the toy robot.
- Any move that would cause the robot to fall must be ignored.


### Setup the Robot Simulator
```
$ git clone git@github.com:ChunAllen/robot_simulator.git
$ cd robot_simulator
$ bundle install
```

### Running the program
```
$ irb
> require_relative 'robot.rb'
> instruction = File.readlines 'instructions/instruction1.txt'
> robot = Robot.new instruction
> robot.execute
=> 0,0,NORTH
```

### Running the test
```
$ rspec spec/
```
