class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name

# What is output and why?

=begin

ANSWER:
On line 16, when the `Dog#dog_name` instance method is invoked on the `teddy` object, `'bark! bark!  bark! bark!'` is output. When we instantiated the `teddy` object from the `Dog` class, we did pass the string literal `Teddy` into the `initialize` constructor method; however, the value within the `name` argument was never used to initialize the `@name` instance variable within the `Dog` class.
The `teddy` object is still encapsulating and tracking its state and is therefore "aware" of the `@name` instance variable. That instance variable is inherited from the `Animal` superclass, is uninitialized and references a `nil` value. When the `Dog#dog_name` instance method is called, during string interpolation, the `@name` instance variable references 'nothing' and therefore evaluates to nothing. The output reflects this via the output stated earlier.

=end

#-------------------------------------------------------------------------------
# 8 Mins
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other_person)
    name == other_person.name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true


# In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`? 

# Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?

=begin

We can return `true` on line 11 by defining our own custom `Person#==` instance method to the following:

def ==(other_person)
  name == other_person.name
end

The above added instance method will instruct ruby to compare the values referenced by their respective `@name` instance variable against one another for equality. This does not mean the `String` objects referenced by the two separate objects are the same object. To validate this, we could compare the objects with one another via the `#equal?` method or compare the output of calling both objects `name` getter methods and chaining on an `object_id` method call to validate they are different from one another. Below shows the results tested (object id's will differ).
al.name.equal?(alex.name)
=> false

al.name.object_id
=> 260 

alex.name.object_id
=> 12600

=end

#-------------------------------------------------------------------------------
# 8 min
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name


# What is output on `lines 14, 15, and 16` and why?

=begin

On line 14, `'Bob'` is output after the `name` getter method is called on the `bob` object. When the `bob` object was instatiated, the argument `'Bob'` was passed into the `initialize` constructor and assigned to the `@name` instance variable.
On line 15, `'My name is BOB.'` is output. When `puts` is called, since we defined a custom `to_s` instance method in our `Person` class, this method is automatically called on the object that `puts` is inovked on. Within that instance method, we use string concatenation evaluating the `#{name.upcase!}` expression. This does two things, it destructively mutates the `@name` instance variable, and then is concatenated within the surrounding string then output as stated above.
Finally, on line 16, when the `name` getter method is called on `bob` again, we return the mutated value from the `@name` instance variable. This output is `BOB`.

=end

#-------------------------------------------------------------------------------
# 7 min
# Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.

=begin

ANSWER:
It is generally safer to invoke a setter method in case there is some other validation logic required to check the value prior to that data being stored as state within an instance variable.

class Person
  attr_reader :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def change_age(new_age)
    if new_age.to_s.to_i == new_age
      @age = new_age
    else
      'Invalid entry'
    end
  end
end

aj = Person.new('aj', 40)
p aj.age                    # => 40
p aj.change_age('hello')    # => "Invalid entry"
p aj.change_age(41)         # => 41
p aj.age                    # => 41

=end

#-------------------------------------------------------------------------------
# 9 min
# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

=begin

ANSWER:
If there are times where we need to ensure we only expose certain data stored within an instance variable, defining a custom getter method is a way to achieve this. For example, if we only wanted to expose a partial bank account number, we could do the following:

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
p aj.display_acct_num
=end

#-------------------------------------------------------------------------------

class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end


# What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?

=begin

ANSWER:
When we invoke the `Triangle.sides` class method, this invocation can return `nil`, the integer 3, or the integer 4 when the shared class variable `@@sides` is referenced depending on when it is invoked. When the `sides` class method is invoked, it is not within the `Triangle` class, it is found within the `Shape` class via inheritance and the coorepsonding method lookup path.
If it is invoked prior to either an object being instatiated from the `Triangle` or `Quadrilateral` classes, it will reference `nil`, the value in which it is initialized to within the `Shape` class.
When we instantaiate a new object from the `Triangle` class, when the `initialize` constructor executes, the shared `@@sides` class variable is reassigned to the integer `3``. If the `Triangle.sides` class method is then invoked, it will return the reassigned value of `@@sides`; the integer `3`. Finally, in similar fashion, when we instantiate a new ojbect from the `Quadrilateral` class, when the `initialize` constructor method executes, the shared class variable `@@sides` is reassigned to the integer value 4. Any references to the class variable will return this reassigned variable. Moving forward with this code snippet, only via instantiation of new `Triangle` and `Quadrilateral` objects will the `@@sides` class variable change (be reassigned).

=end
