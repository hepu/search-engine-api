# frozen_string_literal: true

class Search
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_accessor :text, :engine, :page

  validates :engine, inclusion: { in: SearchService::ENGINES.values, message: "'%{value}' is not a valid engine" },
                     presence: true
end
