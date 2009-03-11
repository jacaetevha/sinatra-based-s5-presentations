require 'sequel'

unless Object.const_defined? 'DB'
  DB = Sequel.mysql(:user=>'joeschmoe',:password=>'supersecretpassword',:host=>'localhost',:database=>'s5_sinatra_presentations')
end

DB.create_table :presentations do
  primary_key :id
  column :title, :text
end

DB.create_table :slides do
  primary_key :id
  foreign_key :presentation_id, :presentation
  column :title, :text
  column :handout_material, :text
end

DB.create_table :points do
  primary_key :id
  column :haml, :text
  foreign_key :slide_id, :slides
end