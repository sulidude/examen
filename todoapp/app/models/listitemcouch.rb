require 'rubygems'
require 'couchrest_model'

SERVER = CouchRest.new
DB     = SERVER.database!('todoapp')

class Listitemcouch < CouchRest::Model::Base
  use_database DB

  property :ingavedatum
  property :einddatum
  property :prioriteit
  property :beschrijving
  property :status
  timestamps!


  design do
   view :by_prioriteit,
     :map =>
       "function(doc) {
         emit(doc.prioriteit, doc);

       }"

 end
end
