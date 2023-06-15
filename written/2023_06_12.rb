# How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.

=begin

Method access control is implemented within ruby via access modifiers. These modifiers control the level of access to methods within a class. Public methods are available to anyone who knows the class or objects name. Private methods are restricted so that only within the class can those method be accessed/used for any required functionality. Protected methods are those that are still restriced from outside of the class; however, access to methods between objects from that classes instances is allowed.

public is person name
protected is comparing speed
private is combination for lock

*EXAMPLES ADDED INTO WRITTEN NOTES*

=end

#-------------------------------------------------------------------------------

# Describe the distinction between modules and classes.

=begin

ANSWER:
Classes are used to group common behaivors with one another that relate to the objects that will be instatiated from them, and are primarily used to model hierarchical domains. Because of the hierarchical structure, classes can only inherit from one superclass at a time.
Modules are used to group common behaivors that can be used across various classes that can exibit the behaivor defined by the methods within it. A key difference between classes and modules is that objects cannot be instatiated from a module. Also, unlike classes that can only inherit from one superclass, as many modules as needed can be 'mixed in' to any given class. This is Ruby's way of handling the need for 'multiple inheritance'.

=end

#-------------------------------------------------------------------------------

# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.

=begin

Polymorphism is the ability of objects of different types to respond to the same method invocation. There are two types of polymorphism in Ruby: Inheritance, and Ducktyping
Class Inheritance:
  Class inheritance is when a subclass inherites and overrides behaviors of its superclass (parent class). When a method is invoked on an object from any of the subclasses objects, they all respond to that method invocation, but they usually respond in different ways. This allows us to create basic superclasses that have high reusability, and subclasses that are more defined/granular behaviors.
Interface Inheritance:
  Interface inheritance is when we mix in modules via the `include` method into a class (or classes). This allows us to extend the functionality (behaviors) defined within a module to the objects instantiated from its class. It is how we achieve multiple inheritance within Ruby. It is also how we group common behaviors together that can be used across multiple classes within our codebase helping us keep our code more flexible and 'DRY'.

Ducktyping
  Ducktyping is the form of polymorphism where objects of different unrelated types can respond to the same method invocation. The name references the mentality/concept of "If it looks like a duck and quaks like a duck, then it must be a duck". If two objects respond to a `power_on` method invocation and take the same number of arguments, as long as it is an intended action, it is ducktyping. Ducktyping allows us to create code that is more flexible, easier to maintian, and extendable.


=end

#-------------------------------------------------------------------------------

# What is encapsulation, and why is it important in Ruby? Give an example.

=begin

ANSWER:
Encapsulation is the hiding of functionality from the rest of the code base. It is a form of data protection that protects data from being manipulated unless there is obvious intention. Encapuslation also sets the boundaries within our code to allow us to think at a higher level of abastraction to create more complex code while reducing the number of dependencies. To achieve encapsulation we create classes (which encapuslate behaviors/methods), instantiate objects from those classes (which encapsulate state), and via methods expose an objects state to the rest of the codebase for interaction with the object.

class Legos
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

duplos = Legos.new('Duplos')

p duplos.type # => 'Duplos'

=end

#-------------------------------------------------------------------------------

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk # 40

kitty = Cat.new("Kitty")
p kitty.walk # 43


# What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?

=begin

ANSWER:
On line 40, the `p` method invocation outputs `"Mike strolls forward"`, and subsequently on line 43, the output is `"Kitty saunters forward"`. In this code snippet, it make more sense to use a module mixin for each class vs using class inheritance because there is no type of `is-a` relationship between a cat and a person for those classes to inherit from one another.
Modules are useful when there are common behaviors across various superclass’s or subclasses that can be grouped together into a single module and ‘mixin’ those modules into superclass's or subclasses as required. This will allow for code follow the DRY principle to avoid repeating code across classes.

=end