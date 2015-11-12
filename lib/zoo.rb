require_relative "cage"
require_relative "employee"
require 'pry'

class Zoo
  attr_reader :name, :season_opening_date, :season_closing_date, :cages, :employees
  def initialize(name, season_opening_date, season_closing_date)
    @name = name
    @season_opening_date = season_opening_date
    @season_closing_date = season_closing_date
    @cages = Array.new(10).map { Cage.new }
    @employees = []
  end

  def add_employee(employee)
    @employees << employee
  end

  def open?(date)
    (date < season_closing_date) && (date > season_opening_date)
  end

  def add_animal(animal)
    flag = true
    @cages.each do |cage|
      if cage.empty?
         cage.animal = animal
         flag = false
         break
      end
     end

     if flag
       raise ZooAtCapacity
     end
  end

  def visit
    conversation = ""
    @employees.each do |employee|
      conversation += "#{employee.greet}\n"
    end
    @cages.each do |cage|
      conversation += "#{cage.animal.speak}\n" if !cage.empty?
    end
    conversation
  end

end

class ZooAtCapacity < StandardError;end
