=begin
Design a Sports Team (Author Unknown...thank you!)

# + Include 4 players (attacker, midfielder, defender, goalkeeper)

# + All the players’ jersey is blue
# + except the goalkeeper, his jersey is white with blue stripes.

# + All players can run
# + and shoot the ball.

# + Attacker should be able to lob the ball.

# + Midfielder should be able to pass the ball.

# + Defender should be able to block the ball.

# + The referee has a whistle.
# + He wears black
# + He is able to run
# + He is able to whistle.

=end

module Runnable
  def runs
    "Running"
  end
end

class Player
  include Runnable

  def initialize
    @jersey_color = `blue`
  end

  def shoots_the_ball
    "Shoots the ball"
  end
end

class Attacker < Player
  def lob_the_ball
    "Lobs the ball"
  end
end

class Midfielder < Player
  def pass_the_ball
    "Passes the ball"
  end
end

class Defender < Player
  def block_the_ball
    "Blocks the ball"
  end
end

class GoalKeeper < Player
  def initialize
    jersey_color = 'white with blue stripes'
  end
end

class Referee
  include Runnable

  def initialize
    @whistle = true
    @jersey_color = 'black'
  end

  def whistles
    "Whistles"
  end
end

#-------------------------------------------------------------------------------

=begin
21:25 mins

# + Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers

# + teachers can help a student with schoolwork
# + and watch them on the playground.

# + assistants can help a student with schoolwork
# + and watch them on the playground.

# + A teacher teaches

# + Assistant helps kids with any bathroom emergencies

# + Kids can learn
# + Kids can play

# + A teacher can supervise a class

# + A principle can supervise a class

# + A principle can expel a kid

# + Janitors have the ability to clean

# + Cafeteria workers have the ability to serve food

# + Children, teachers, class assistants, principles, janitors and cafeteria workers all have the ability to eat lunch.

=end

module Eatable
  def eat_lunch
    'Eating lunch!'
  end
end

module Supervisable
  def supervise_class
    'Supervising class!'
  end
end

module KidsHelpable
  def help_kid_with_schoolwork
    'Helping student with schoolwork!'
  end
end

module KidsWatchable
  def watch_kid_on_playground
    'Watching student on playground'
  end
end

class Preschool
  def initialize
    @staff = []
    @children = []
  end
end

class People
  include Eatable
end

class Children < People
  def learn
    'Learning!'
  end

  def play
    'Playing!'
  end
end

class Teachers < People
  include Supervisable
  include KidsHelpable
  include KidsWatchable

  def teach
    'Teaching!'
  end
end

class ClassAssistants < People
  include KidsHelpable
  include KidsWatchable

  def help_kid_with_bathroom
    'Helping kid with any bathroom emergency!'
  end
end

class Principle < People
  include Supervisable

  def expel_kid
    'Expeled kid!'
  end
end

class Janitors < People
  def clean_up
    'Cleaning up!'
  end
end

class CafeteriaWorkers < People
  def serve_food
    'Serving food!'
  end
end

#-------------------------------------------------------------------------------

=begin
honestly took probably between 23 - 25 mins
Dental Office Alumni (by Rona Hsu)

# + There's a dental office called Dental People Inc.

# + Within this office, there's 2 oral surgeons, 2 orthodontists, 1 general dentist.

# + Both general dentists and oral surgeons can pull teeth.

# + Orthodontists straighten teeth.

# + All of these aforementioned specialties are dentists.

# + All dentists graduated from dental school.

# + Oral surgeons place implants.

# + General dentists fill teeth

=end

module Pullable
  def pull_teeth
    'Pulling out teeth!'
  end
end

class DentalOffice
  attr_accessor :staff

  def initialize(name)
    @name = name
    @staff = []
  end
end

class Dentists
  def initialize
    @graduated_dental_school = true
  end
end

class OralSurgeon < Dentists
  include Pullable

  def place_implants
    'Placing implants!'
  end
end

class Orthodontist < Dentists
  def straighten_teeth
    'Straightening teeth!'
  end
end

class GeneralDentist < Dentists
  include Pullable

  def fill_teeth
    'Filling teeth!'
  end
end

dental_people_inc = DentalOffice.new('Dental People Inc.')
dental_people_inc.staff << OralSurgeon.new
dental_people_inc.staff << OralSurgeon.new
dental_people_inc.staff << Orthodontist.new
dental_people_inc.staff << Orthodontist.new
dental_people_inc.staff << GeneralDentist.new
p dental_people_inc.staff
