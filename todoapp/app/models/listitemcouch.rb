require 'rubygems'
require 'couchrest'

SERVER = CouchRest.new
DB     = SERVER.database!('contact-manager')

class Listitemcouch < CouchRest::Model::Base
  use_database DB

  property :ingavedatum
  property :einddatum
  property :prioriteit
  property :beschrijving
  property :status
  timestamps!

  view_by :prioriteit

end
