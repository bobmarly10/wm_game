class Team < ActiveRecord::Base

  # relations

  # validations
  validates :country, :group, :presence => true

  # plugins
  as_enum :group, { a:0, b:1, c:2, d:3, e:4, f:5, g:6, h:7 }





end
