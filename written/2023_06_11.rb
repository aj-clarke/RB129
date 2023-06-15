# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

=begin

ANSWER:
The `attr_accessor` method is used to create both a setter and a getter method for a given instance variable. Unless we need to expose the data encapsulated within an object to a user, there is no need to use the `attr_accessor` method to create these methods. The concept of encapsulation is hiding functionality from the rest of the codebase, and part of that is using it as a form of data security to ensure data is not manipulated unless there is obvious intention.

If we wanted to ensure that only the pertinant information about a users bank account is revealed, we could create a custom getter method to only expose what we want, for example:

class BankAccount
  def initialize(name, acct_num)
    @name = name
    @acct_num = acct_num  # assum a 10 digit number
  end

  def display_acct_num
    'xxxxxx' + @acct_num.to_s[6, 4]
  end
end

aj_account = BankAccount.new('aj', 1234567890)
p aj_account.display_acct_num # => "xxxxxx7890"

In this example, we are choosing to only display the last four digits of a users bank account instead of the entire account number to ensure that unecessary data is not exposed, ensuring that data stays encapsulated (protected).

=end

#-------------------------------------------------------------------------------

# What is the difference between states and behaviors?

=begin

State is tracked via instance variables and the values/data assigned to them. So the state is the data associated with an individual object. Behaviors are the things that objects are capable of doing, which are represented by instance methods. To summarize:

State is tracked/represented via instance variables and is the data that is associated with that individual instance. Data could be anything from a name to any other identifiable trait. Although objects from the same class share the “name” of instance variables, their containing data can contain different information.
Behaviors are represented via instance methods. All objects instantiated from a class share identical behaviors with one another and these are exposed by instance methods.

=end

#-------------------------------------------------------------------------------

# What is the difference between instance methods and class methods?

=begin

ANSWER:
Instance methods are the behaviors that represent what an object is capable of doing, and we can use these methods to expose the state of an object. Class methods are the behaviors that represent what a class is capable of doing. They can be invoked without any objects being instantiated, and are used primarily for functionality that does not require state within a class.

=end

#-------------------------------------------------------------------------------

# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.

=begin

ANSWER:
Collaborator objects are objects that are stored as state within another object. The purpose of collaboraor objects is to logically represent a connection between one object and another. 

class GolfBag
  attr_accessor :contents

  def initialize(brand)
    @brand = brand
    @contents = []
  end
end

class GolfBalls
  def initialize(brand)
    @brand = brand
  end
end

nike_bag = GolfBag.new('Nike')
noodles = GolfBalls.new('noodles')

nike_bag.contents << noodles

p nike_bag.contents

=end

#-------------------------------------------------------------------------------

# How and why would we implement a fake operator in a custom class? Give an example.

=begin

ANSWER:
We can implement a 'fake operator' within a custom class by defining a custom implementation of it in our class which will override the default implementation. We would do this to ensure that within our custom class, equivalance is being tested on the data intended. To show an example, the below code will be used to test whether the objects instance variable string values are the same or not. By default it would intead compare the objects themselves for equivalance.

class TechnicSet
  attr_reader :lego_set_name
  def initialize(lego_set_name)
    @lego_set_name = lego_set_name
  end

  def ==(other_set)
    lego_set_name == other_set.lego_set_name
  end
end

batmobile = TechnicSet.new('Batmobile')
capt_america_shield = TechnicSet.new('Captain Americas Shield')
batmobile2 = TechnicSet.new('Batmobile')

p batmobile == batmobile2
p batmobile == capt_america_shield

=end

#-------------------------------------------------------------------------------

# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.

=begin
We use self to be specific about what is being referenced and what we are intending to do in reference to behavior (like ensuring we reassign an instance variable in a custom setter method vs referencing a local variable). The scope of self is very important. If self is used within a class inside of an instance method, it represents its calling object. However, if self is used within a class, but outside of an instance method, it references the class itself and can be used to define class methods.

class TechnicSet
  def self.info                               # self represents the `TechnicSet` class
    "This class represents the #{self} class" # self represents the `TechnicSet` class
  end

  def initialize(lego_set_name)
    @lego_set_name = lego_set_name
  end

  def change_name(new_name)
    self.lego_set_name = new_name   # self represents instance/object `technic_set`
  end

  private

  attr_accessor :lego_set_name
end

technic_set = TechnicSet.new('Captain Americas Shield')
p technic_set
technic_set.change_name('Thors Hammer')
p technic_set
p TechnicSet.info

=end

#-------------------------------------------------------------------------------

class Person
  def initialize(n)
    @name = n
  end

  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"


# What does the above code demonstrate about how instance variables are scoped?

=begin

The above code demonstrates that instance variables are all scoped at the instance level. Even though the instance variable `@name` was defined within the `initialize` constructor, it is available at the instance or object level within the entire class. This is why on lines 6 through 8, we are able to use an instance method and within it access the instance variable `@name`'s value when that getter method is used on line 17.

=end

#-------------------------------------------------------------------------------

# How do class inheritance and mixing in modules affect instance variable scope? Give an example.

=begin

ANSWER:
In reference to class inheritance, instance variables are still scoped at the instance level. Any instance variables that are uninitialized from the supercalss need to be initialized by a superclass intance method prior to it being available for use. Similarly, for any modules that have been mixed into an objects class via the include method, the methods defined within the module have access to the objects instance variables. All defined behaviors are available for use within the module. Also similarly, any instance variables that are a part of the module must be initialized via a method within the module prior to them being available for use by the calling object.

=end

#-------------------------------------------------------------------------------

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky


# What is output and why? How could we output a message of our choice instead?
=begin

ANSWER:
When the `sparky` object is passed into the `puts` method as an argument, the default `to_s` method is automatically called on the object. The default return value from the `to_s` method call is `#<GoodDog:0x0000027e0dc3f9a0>` which is the name of the class, and an encoded object id representing its space in memory. If we want to alter the output when invoking the `puts` method or using the objects name within string interpolation, we need to define our own custom `to_s` instance method within the class.

Example:

def to_s
  "I am #{name} and I am #{age} years old in dog years."
end

=end

# How is the output above different than the output of the code below, and why?

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky

=begin

ANSWER:
The output from the above snippent differs from the previous because when we invoke the `p` method on an object, this invokes the `inspect` method on it. The `inspect` method will output `#<GoodDog:0x0000027e0dbeea00 @name="Sparky", @age=28>` which is the name of the object, its encoded object id (space in memory) and all initialized instance variables with their coorresponding values (which track state).

=end

#-------------------------------------------------------------------------------

# When does accidental method overriding occur, and why? Give an example.

=begin

ANSWER:
Accidental method overriding occurs when a custom method is created that has the same name as a method from a superclass (or any inherited method from a class in the method lookup chain).

class Villain
  def initialize(name)
    @name = name
  end

  def freeze(person)
    "The villain froze #{person}"
  end
end

mr_freeze = Villain.new('Mr. Freeze')
p mr_freeze.freeze('Batman')

In the above example, instead of the `mr_freeze` object being frozen, the `Villain#freeze` method has overridden the `Object#freeze` method. This can cause issues later if there is a separate process/function that requires the object to be frozen. Instead of the object being frozen, the issue would present itself in the form of an `ArgumentError`. 

=end