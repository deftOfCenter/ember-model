require 'rake'

T2_DIR = "/Users/deft/code/ember-t2/vendor/js"

desc "Create the #{T2_DIR} directory"
directory T2_DIR

desc "copy ember-model to t2 directory"
file "dist/ember-model.js" => ["dist", File.join(T2_DIR, "ember-model.js")] do |t|
  cp t.prerequisites[1], t.name, :verbose => true
end

desc "Update Ember Model to newest version"
task :update_ember_model do
  puts "Pulling changes from git..."
  system "git pull origin master"
  puts "Updating dependencies..."
  system "npm install"
  puts "Running Grunt to install..."
  system "grunt"
  puts "Ember Model updated!"
end

desc "Copy Ember Model to T2"
task :copy_to_t2 => "dist/ember-model.js" do
  puts "Ember copied to #{T2_DIR}!"
end

desc "Update Ember Model and copy to T2"
task :update_t2 => [:update_ember_model, :copy_to_t2] do
  puts "T2 updated with newest Ember-Model!"
end