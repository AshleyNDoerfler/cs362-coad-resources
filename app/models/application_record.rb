# The ApplicationRecord acts as the parent class for all models in the COAD system.
# This is an abstract class used to provide common functionality to its subclasses/children.
class ApplicationRecord < ActiveRecord::Base
  
  self.abstract_class = true
end
