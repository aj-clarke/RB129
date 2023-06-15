# What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?

=begin

ANSWER:
Object oriented programming is a programming paradigm that was created to solve the problem of ever growing large programming systems. These large systems had too many dependancies, and the complexity was ever growing.
Object oriented programming has allowed us to create containers of code each with their own smaller subsets of depedencies and create logical connections between them as needed. OOP allows us to think on a new level of abstraction to create more complex code which is easier to debug, maintain, and expand, while reducing the number of dependencies throughout our code.

=end

#-------------------------------------------------------------------------------

# 5 min
# What is the relationship between classes and objects in Ruby?

=begin

Classes are like a template/blueprint from which objects are created. Classes encapulate behaviors/methods and define an objects potential attributes. Objects are instatiated from a class and encapsulates its uniuqe state. # (maybe add?) We then expose the behaviors/methods within the class to interact with an object and its state.

=end

#-------------------------------------------------------------------------------

# When should we use class inheritance vs. interface inheritance?

=begin

ANSWER:
We should use class inheritance an `is-a` relationship, whereas when there is a `has-a` relationship, we use interface inheritance.

For example, a Car `is a` Vehicle, so class inheritance is usually the way to go; however, a Car `has-an` ability to honk a horn, so interface inheritance is a good choice.

=end

#-------------------------------------------------------------------------------

# class Cat
# end

# whiskers = Cat.new
# ginger = Cat.new
# paws = Cat.new


# If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?

=begin

ANSWER:
If we use the `==` to compare the `Cat` objects, they will return `false`. The default implementation of the `==` comes from the `BasicObject` class and functions just like the `equal?` method; which checks to see if they are identical objects. (We CAN override the default behavior of the `==` method to choose what we would want to evalueate for equality).
It demonstrates that although all objects created from the same class have identical behaviors as one another, they are each unique (not the same) objects.

=end

#-------------------------------------------------------------------------------

# 3 min
# class Thing
# end

# class AnotherThing < Thing
# end

# class SomethingElse < AnotherThing
# end


# Describe the inheritance structure in the code above, and identify all the superclasses.

=begin

ANSWER:
In the above snippen we have multiple subclasses inheriting from multiple superclasses. The `SomethingElse` subclass inherits from the `AnotherThing` superclass. The `AnotherThing` class is also a subclass that inherits from the `Thing` class. The `Thing` class is also a subclass of the `Object` supercalss, and the `Object` subclass inherits from the `BasicObject` superclass. The superclasses include `AnotherThing`, `Thing`, `Object`, and `BasicObject`.

=end

#-------------------------------------------------------------------------------

# module Flight
#   def fly; end
# end

# module Aquatic
#   def swim; end
# end

# module Migratory
#   def migrate; end
# end

# class Animal
# end

# class Bird < Animal
# end

# class Penguin < Bird
#   include Aquatic
#   include Migratory
# end

# pingu = Penguin.new
# # pingu.fly
# p Penguin.ancestors

# What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.

=begin

ANSWER:
The method lookup path result from the call would be:
[Penquin, Migratory, Aquatic, Bird, Animal, Object, Kernel, BasicObject]

The call to `fly` will result in an undefined method error as a result of not being able to resolve the `Flight#fly` method call. We can validate the method lookup path by calling the `#ancestors` method on the `Penguin` class; returning an array of the method lookup path.

=end

#-------------------------------------------------------------------------------

# class Animal
#   def initialize(name)
#     @name = name
#   end

#   def speak
#     puts sound # 7
#   end

#   def sound
#     "#{@name} says "
#   end
# end

# class Cow < Animal
#   def sound
#     super + "moooooooooooo!"
#   end
# end

# daisy = Cow.new("Daisy")
# daisy.speak # 22


# What does this code output and why?

=begin

ANSWER:
When the `speak` instance method is invoked on line 22, `'Daisy says moooooooooooo!'` is output. This method call first invokes the `speak` method found via the method lookup chain within the `Animal` superclass. On line 7 the `sound` method is invoked which is overridden within the `Cow` subclass on line 16. Within this method invocation, we first have a call to `super`, which searches up the inheritance hierarchy for a method with the same name, then executes that method.
The `Animal#sound` method uses string interpaltion to output the result of the `#{@name}` expression concatenated in the surrounding string. This produces `'Daisy says ` and is returned to the `Cow#sound` method to conintue execution. `'moooooooooooo!` is then concatenated onto the returned string to form our final output.

=end

#-------------------------------------------------------------------------------

# class Cat
#   def initialize(name, coloring)
#     @name = name
#     @coloring = coloring
#   end

#   def purr; end

#   def jump; end

#   def sleep; end

#   def eat; end
# end

# max = Cat.new("Max", "tabby")
# molly = Cat.new("Molly", "gray")


# Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.

=begin

ANSWER:
No `molly` and `max` do not have the same states as one another; however, they do have the same behaviors as one another. This is because objects instantiated from the same class all have access to the same behiavors, but their attributes (instance variables) contain different information (data/values).

=end

#-------------------------------------------------------------------------------

# class Student
#   attr_accessor :name, :grade

#   def initialize(name)
#     @name = name
#     @grade = nil
#   end

#   def change_grade(new_grade)
#     self.grade = new_grade
#   end
# end

# priya = Student.new("Priya")
# priya.change_grade('A')
# p priya.grade


# In the above code snippet, we want to return `”A”`. What is actually returned and why? How could we adjust the code to produce the desired result?

=begin

ANSWER:
When we call the `grade` instance method on the `priya` object, `nil` is returned because within the `change_grade` setter method, `grade` is seen by Ruby as a local (method) variable; therefore, after we initalize `grade` to reference the value `'A'`, the method returns `'A'` but the instance variable `@grade` is not reassigned to `'A'`. To correct this, we would need to either prepend `self.` (which represents the calling object `priya`) or `@` to `grade` to tell Ruby that we are using a setter method to change the value of the instance method `@grade`.

  def change_grade(new_grade)
    self.grade = new_grade  # best practice
    #or
    @grade = new_grade
  end

=end

#-------------------------------------------------------------------------------

# 44 did within my Notion Code Snippets

#-------------------------------------------------------------------------------

# 5:10 min

# class Student
#   attr_accessor :grade

#   def initialize(name, grade=nil)
#     @name = name
#   end 
# end

# ade = Student.new('Adewale')
# p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">


# Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?

=begin

ANSWER:
The last line will show the following `#<Student:0x00000002a88ef8 @name="Adewale">`. Although we have a default value set as parameter within the `initialize` constructor, this does not actually initialize the instance variable `@grade` with a `nil` value and store it as state within the `ade` object when it is instantiated from the `Student` class.
If we wanted to set the `@grade` instance value to `nil`, we would either need to add it within the `initialize` constructor `@grade = nil` or use the setter method created by the `attr_acessor` to set the value of `@grade` to `nil`. This snippet demonstrates that until an instance variable is initialized via an instance method, it is not stored as state within an object.

=end

#-------------------------------------------------------------------------------

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking." # 9
  end
end

class Knight < Character
  def speak
    "Sir " + super # 15
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name # 20
p sir_gallant.speak # 21

# What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`? 

=begin

ANSWER:
On line 20, when the `name` instance method is called on the `sir_gallant` object, `"Sir Gallant"` is output. The `Knight#name` method first starts with the string literal "Sir " then concatenates a call to `super` onto it. The `super` method searches up the method chain to find the next method with the same name and executes it. In this case, it finds the getter method from with the `Character` class created by the `attr_accessor` method, and returns `Gallant` back from the `super` method call which is concatenated onto the `Sir ` string to create, return, and output the string `"Sir Gallant"`

On line 21, the `speak` method is called on the `sir_gallant` object. It is not found within the `Knight` class, but the method is inherted from the `Character` class and found via the method lookup chain. Once it is invoked, the returned expression from `#{@name}` is concatenated within the surrounding string. The `@name` instance variable, which was added as state when the `sir_gallant` object was instantiated via the `initialize` constructor from the superclass `Character`. This then returns and outputs `"Gallant is speaking."`

To achieve the output of `'Sir Gallant is speaking.''`, we could change the name of the instance method within the `Knight` class from `name` to `speak`

=end

#-------------------------------------------------------------------------------

class FarmAnimal
  def speak
    "#{self} says " # 2
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!" # 7
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!" # 13
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!" # 19
  end
end

p Sheep.new.speak # 23
p Lamb.new.speak # 24
p Cow.new.speak # 25


# What is output and why? 

=begin

ANSWER:
On lines 23 - 25 we instantiate 3 objects, one from the `Sheep` class, one from the `Lamb` class, and one from the `Cow` class.

On line 23, the `speak` method call outputs `"#<Sheep:0x000002086f1db6f8> says baa!"`. When the super keyword is called in the method on line 7, it searches up the method lookup path into the `FarmAnimal` class and executes the `Farm#speak` method. The returned expression from `#{self}` is the `Sheep` object and is concatenated into the surrounding string to form `"#<Sheep:0x000002086f1db6f8> says `, when that is returned from the `FarmAnimal#speak` method we concatenate `'baa!` to get `"#<Sheep:0x000002086f1db6f8> says baa!"`

On line 24 the `Lamb#speak` method is invoked on the `Lamb` object. Within the `Lamb#speak` method, the `super` keyword searches up the method lookup chain to find and invoke the `Sheep#speak` method. Another `super` keyword is found and we again search up the method lookup chain and invoke the `FarmAnimal#speak` method. This The returned expression from `#{self}` is the `Lamb` object and is concatenated into the surrounding string to form `'#<Lamb:0x000002086f46c0e8> says '`, when we return to the `Sheep#speak` method, we concatenate `baa!` onto it, and when that is returned to the `Lamb#speak` method, we concatenate `'baaaaaaa!'` and return, then output `"#<Lamb:0x000002086f46c0e8> says baa!baaaaaaa!"`.

On line 25, the `Cow#speak` method is invoked on the `Cow` object. It follows a similar path as our `Sheep.new.speak` line 23 method call. First the `super` keyword searches up the method lookup chain to find the `FarmAnimal#speak` method; the returned expression from `#{self}` is the `Cow` object and is concatenated into the surrounding string to form `"#<Cow:0x000002086f284d70> says "`. When that is returned from the `FarmAnimal#speak` method we concatenate onto it `'mooooooo!'` and return, then output `"#<Cow:0x000002086f284d70> says mooooooo!"`.

If we wanted to instead have "Sheep", "Lamb", and "Cow" instead of the default output from string interpolation, we could have used (on line 2) `#{self.class}` instead of just `#{self}`, which would have returned the name of each class from that expression.
=end

#-------------------------------------------------------------------------------

class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)


# What are the collaborator objects in the above code snippet, and what makes them collaborator objects?

=begin

ANSWER:
If we are referencing 'custom' collaborator objects, then the `sara` object would be a collaborator object for the `fluffy` object. This is because the `sara` object is stored as state witin the `fluffy` object within the `@owner` instance variable.

TECHNICALLY, we could also say that the string "Sara" is a collaborator object within the `sara` object, and the string "Fluffy" is a collaborator object of the `fluffy` object as they each are stored as state in their respective `@name` instance variables.

=end

#-------------------------------------------------------------------------------

number = 42

result = case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end
p result

# What methods does this `case` statement use to determine which `when` clause is executed?

=begin

ANSWER:
On lines 4 and 5, the `Integer#===` method is used to evaluate to check for equivalance against `number`; `1`, then `10`, `20`, and `30` to see if it "belongs" in that group or equals one in that group. Neither of those clauses will evaluate as truthy. The final `when` clause will execute becasue when we ask "if (40..49) is a group, does 42 belong in it"; the answer is yes when it uses the `Range#===` method to evaluate the expression, so that `when` clause is executed.

=end

#-------------------------------------------------------------------------------

class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

# What are the scopes of each of the different variables in the above code?

=begin

The `@@total_people` class variable is scoped at the class level, and both the `@name` and `@age` instance variables are scoped at the instance (or object) level.

=end