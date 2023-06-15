# class Person
#   attr_reader :name

#   def set_name
#     @name = 'Bob'
#   end
# end

# bob = Person.new
# p bob.name


=begin

# What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

ANSWER:
# On line 11, the `name` instance method is invoked on the `bob` object from the `Person` class. This will output and return `nil`. When we instantiate a new object `bob` from the `Person` class on line 10, we are not initializing the `@name` instance variable to any value. 
# The `@name` instance variable still exists; however, its current state is comparable to a `null` or `nil` existance. This is because objects track what attributes are defined within the object’s class and class inheritance hierarchy; therefore, there is an awareness of the instance variables which are not initialized. All uninitialized instance variables within the object’s class and class inheritance hierarchy reference `nil`.
# This is a stark difference compared to local variables. While uninitialized instance variables reference `nil`, uninitialized local variables will throw an error for an undefined local variable or method being referenced.

=end

#-------------------------------------------------------------------------------

module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim

=begin
# What is output and why? What does this demonstrate about instance variables?

ANSWER:
On line 41, `nil` is output and returned because the `#swim` instance method in the `Dog` class returns `nil`. When the `swim` method is invoked, the if statement evaluates if the @can_swim instance variable returns a truthy value; it does not. 

The `Swimmable` module is mixed into the `Dog` class; therefore, the `Swimmable#enable_swimming` method has to run first in order to initialize the @can_swim instance variable and add it as state to the `teddy` object. Once that is done, the `swim` methods if statement will evaluate to true and will output the string `swimming!`

This demonstrates that an objects state is distinct from other objects from the same class. Also that uninitialized instance variables within a class and a class inheritance hierarchy reference nil.

=end

#-------------------------------------------------------------------------------

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end

  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides
p Square.new.sides
p Square.new.describe_shape

=begin

# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

ANSWER:

Ruby resolves constants in two ways

Without namespace/constant resolution operator:
Ruby first attempts to resolve constants lexically; within the surrounding container of the constant reference, if a lexical search does not resolve a constant, Ruby will search up the inheritance hierarchy of the constants referenced container or structure; its `ancestors`. Finally, if neither is able to resolve the constant, Ruby searches the top level (main). An uninitialized constant error is thrown if it cannot be resolved.

With namespace/constant resolution operator:
When a namespace resolution operator is used, we tell Ruby where to start searching to resolve the constant. Ruby will search the specified container, then if it is not resolved, will search the inheritance hierarchy of the specified container. If the constant is not resolved, it stops searching and will throw an uninitialized constant error.

On line 81, the integer 4 is output. When the `sides` class method is invoked on the `Square` class, the class method is found further up the inheritance chain via the method lookup path `Square` > `Quadrilateral` > `Shape`. Within the `sides` class method, `self` represents the class `Square` and we use the namespaced operator to attempt resolving the `SIDES` constant; same functionality as if it were `Square::SIDES`. As mentioned above, this tells Ruby where to begin seaching to resolve the constant. It is not resolved within the `Square` class, so the search continues up the inheritance hierarchy to the `Quadrilateral` class to reference the SIDES constant with the integer value of 4.

On line 82, the integer 4 is again output. When the `sides` instance method is invoked on the instantiated `Square` object it once again finds the desired method within the `Shape` class; however, this time it is an instanc method, not a class method. The `class` method is invoked on `self` which represents the `Square` object; this returns the name of the class which is the same as `self::SIDES`. The rest of the constant resolution is idential to the previous lookup from that point.

On line 83, an error is thrown; `uninitialized constant Describable::SIDES`. Due to inheritance up to the `Shape` class and via the `Describable` module mixin, `Square` objects have access to the `Describable#describe_shape` method. When this method is invoked the `SIDES` constant cannot be resolved. As mentioned above, without a namespace operator, searches lexically within the `Describable` module, then via the inheritance hierarchy, and finally in the main/top level. Ruby is unable to resolve the SIDES constant in any of those locations causing the error stated above.

This demonstrates that constants have lexical scope. Lexical scope is; where a constant is defined within our code determines where that constant is available to us. This means that when trying to resolve a constant, the constant reference determines what surrounding structure is searched for its resolution.

`self` refers to the following: On line 59, `self` refers to the `Square` object instantiated on line 83, On line 67 `self` refers to the `Square` class. Finally, on line 71, self refers to the `Square` object instantiated on line 82.

=end

#-------------------------------------------------------------------------------

