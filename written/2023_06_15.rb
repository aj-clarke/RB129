# The following is a short description of an application that lets a customer place an order for a meal:

# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.

#-------------------------------------------------------------------------------

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end


# In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?

=begin

ANSWER:
If we wanted to avoid using the `self` prefix, we could opt to directly reference the `@age` instance variable like `@age += 1`. That said, it is a best practice to use setter and getter methods over directly referencing an instance variable. If there is a need for validation or some other function to occur prior to the instance variable value being changed, then this could not take place if the instance variable (state) is directly accessed and modified.
In addition, best practices is to use `self` only when necessary, which in this case would be to keep the code as is for modifying the `@age` instance variable value.

=end

#-------------------------------------------------------------------------------

# module Drivable
#   def self.drive
#   end
# end

# class Car
#   include Drivable
# end

# bobs_car = Car.new
# # p Car.ancestors
# bobs_car.drive


# What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?

=begin

ANSWER:
The output from the `drive` method call is `NoMethodError (undefined method `drive' for #<Car:0x0000024ea2c80760>)`. When the `drive` method is called on the `bobs_car` object, it searches up the method lookup chain to find an instance method called `drive` to execute. It searches `[Car, Drivable, Object, Kernel, BasicObject]` and does not find one, leading to the exception.
Unless we change the class method within the `Drivable` module to an instance method, it will not execute that method. We can do this by removing the prepended `self`. This will tell Ruby that the `drive` method within `Drivable` is scoped at the instance level, thereby executing it as expected.

=end

#-------------------------------------------------------------------------------

class House
  include Comparable # added

  attr_reader :price

  def initialize(price)
    @price = price
  end

  # Added spaceship operator to compare @price values
  def <=>(other_house)
    price <=> other_house.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive


# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?

=begin

ANSWER:
We could include the `Comparable` module, then add in a `<=>` operator to reference the `@price` instance vairables values that we need compared. Added code in-line and tested to validate.

=end