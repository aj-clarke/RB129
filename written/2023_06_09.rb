class AnimalClass
  attr_accessor :name, :animals

  def initialize(name)
    @name = name
    @animals = []
  end

  def <<(animal)
    animals << animal.name
  end

  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds

p some_animal_classes 
puts Animal.new('Human')

# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?

=begin

ANSWER:

The output from line 38 is `[#<Animal:0x0000029928fd99b8 @name="Human">, #<Animal:0x0000029929042440 @name="Dog">, #<Animal:0x0000029924f24f80 @name="Cat">, #<Animal:0x0000029928fa26c0 @name="Eagle">, #<Animal:0x0000029929040460 @name="Blue Jay">, #<Animal:0x0000029928fb2a70 @name="Penguin">]`, which is an array of the objects instantiated from the `Animal` class that were collaborator objects of either the `mammals` or `birds` objects from the `AnimalClass`.
This is probably not the intended functionality expected when looking to output the array of objects built from the two `AnimalClass` objects. If we wanted to instead add a list of "names" to the array, we could modify the `AnimalClass#<<` method to instead push in the return value of calling the `#name` getter method on the object passed in from the `Animal` class; `animals << animal.name`. This change would return the following from line 38: `["Human", "Dog", "Cat", "Eagle", "Blue Jay", "Penguin"]`.
=end
#-------------------------------------------------------------------------------

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info
# => Spartacus weighs 10 lbs and is 12 inches tall.

# We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?

=begin

ANSWER:
The `change_info` method does not modify the state of the `@name`, `@height`, and `@weight` instant variables when it is invoked on line 22 because the reassignment within that method treats the varibles as local variables, not the desired instance vairables. When attempting to reassign instance variable values, we must either directly reference the instance variable via prepending the `@` symbol or, if we have an associated setter method for each instance variable, we can prepend `self.` to each of them within the method to modify their state.

=end

#-------------------------------------------------------------------------------

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name
    name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name
bob.change_name
p bob.name

# In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`? 

=begin

ANSWER:
The error is actually raised on line 15 when invoking the `Person#change_name` method on the `bob` object. Inside of the method the intention of reassigning `@name` is not what actually occurs. When reassining an instance variable, we must either prepend the `@` symbol or prepend `self.` to tell Ruby that we are referencing the instance variable during reassignment. In the current state, we are trying to reassign an undefined local variable (local to the method) to the result of upcasing that undefined local variable, causing a `NoMethodError` exeption to be raised.
To adjust the code, again we could prepend `name` with either `self.` or `@` to indicate it is an instance variable being referenced.

=end

#-------------------------------------------------------------------------------

class Vehicle
  @@wheels = 4 # Reassigned to `2`` at line 15

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels # 9 - 4

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels # 15 - 2
p Vehicle.wheels # 16 - 2

class Car < Vehicle; end

p Vehicle.wheels # 20 - 2
p Motorcycle.wheels # 21 - 2
p Car.wheels # 22 - 2


# What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?

=begin

ANSWER:
On line 9 the `Vehicle::wheels` class method call references the `@@wheels` class varaible on line 2 and outputs `4`. On line 15, the `Motorcycle::wheels` class method is invoked. The class method is inherited from its `Vehicle` supercalss, and when invoked, the resolution of `@@wheels` begins again from the `Motorcycle` class where it is found and reassigns the `@@wheels` class variable to `2` and all remaining `Vehicle::wheels` and `Motorcycle:wheels` class method invocations output `2`. In addition, this change is also inherited by the `Car` class on line 18; therefore, when we invoke the `Car::wheels` class method, via inheritance, the method is found and invoked from the `Vehicle` class, and `@@wheels` is resolved within the `Vehicle` class.

This demonstrates that 1 copy of a class variable is shared across all subclasses of a superclass. This can lead to unexpected or undesired results within a program if one subclass modifies a superclasses class variable. That change then shared across all subclasses. It is recommended to avoid class variables with working with inheritance; and further, some recommend against their use at all.

=end

#-------------------------------------------------------------------------------

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end

  def to_s
    "#{@name} #{@color}"
  end
end

bruno = GoodDog.new("brown")
p bruno # 17

# What is output and why? What does this demonstrate about `super`?

=begin

ANSWER:
On line 17 `#<GoodDog:0x000001924754e8b0 @name="brown", @color="brown">` is output. Calling the `p` method on the `bruno` object invokes the `inspect` method on it which will output the name of the objects class and all initialized instance variables for that object.

In this specific example, this demonstrates that when the `super` method is inovked on line 7, it will take in any arguments passed into the method that invokes it, in this case the `initialize` constructor method within the `GoodDog` class with the `color` arguments value, and will search up the inheritance chain of its current `GoodDog` class until it finds another identical method. Once found, it will invoke that method, the `initialize` method, and pass in the value of `color` and assign it to the `@name` instance variable. Once that method completes its execution, the remainder of the `initialize` constructor within the `GoodDog` class assigns the `color` value to the `@color` instance variable.

=end

#-------------------------------------------------------------------------------

class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")

# What is output and why? What does this demonstrate about `super`?

=begin

ANSWER:
When attempting to initialize a new object `bear` from the `Bear` class with 1 argument `'black'`, an `Argument` error is raised. On line 9, when the `super` method is invoked, it attempts to invoke the `Animal` `initialize` constructor with 1 argument `color`; however, the constructor method in the `Animal` class does not accept any arguments. This causes the `Argument` error. 

This demonstrates that when calling the super method, we have to ensure that the correct number of arguments are passed along with it. If not, we can run into an ArgumentError indicating an incorrect number of arguments is being passed into the method found further up the method lookup chain.

=end

#-------------------------------------------------------------------------------

module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end

  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
# p good_dog.walk
p GoodAnimals::GoodDog.ancestors

# What is the method lookup path used when invoking `#walk` on `good_dog`?

=begin

ANSWER:
The method lookup path is: [GoodAnimals::GoodDog, Danceable, Swimmable, Animal, Walkable, Object, Kernel, BasicObject]
This can be verified by invoking the `#ancestors` method on the GoodAnimals::GoodDog class.
=end

#-------------------------------------------------------------------------------

class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
    puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end


# What is output and why? How does this code demonstrate polymorphism? 

=begin

ANSWER:
During each iteration of the elements within the array referenced by `array_of_animals`, the `#feed_animal` method is inoked passing in the current object; `Animal` object, `Fish` object, and finally `Dog` object. The `eat` instance method is called on each object and the following occurs:

When `Animal#eat` is inovked, `"I eat."` is output. When `Fish#eat` is invoked, `"I eat plankton."` is output. Finally, when `Dog#eat` is invoked, `"I eat kibble."` is output. Each `#eat` instance method is unique to the class that invokes it, but all of the objects, even though they are of different types, still respond to the same method call, just in their own way.

This demonstrates polymorphism via class inheritance. Methods (behaviors) in a superclass (parent class) can be inherited by its subclasses. Subclasses can then override these methods providing a way for different objects to respond to the same method invocation. This allows us to define basic superclass's that have greater reusability and smaller subclasses to provide more detailed/explicit behaviors.

=end

#-------------------------------------------------------------------------------

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets.jump


# We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object?

=begin

ANSWER:
On line 28 we call the jump method on the `pets` array. Although there is a `Pet#jump` instance method, this method is not one built to handle an array object; therefore we receive a `NoMethodError`.
The `kitty` and `bud` objects (from the `Cat` and `Bulldog` classes respectively) are collaborator objects of the `bob` `Person` object, as they are stored as state within the `bob` object.

=end
