#!/usr/bin/ruby

require "Ontology"
require "optparse"

# Function that looks up the ontology ID, using the OntologyApi module 
# and stores the information in a OntologyItem Class Object.
# id: Ontology identifier to look up.
def look_up_id(id)
  puts "Looking up '#{id}' on '#{OntologyApi::BASE_URI}' ..."
  res = OntologyApi.get_ontology_by_id(id)

  if res.is_a?(Net::HTTPSuccess)
    puts "#{id} succesfully retrieved!".green
    @ontology_obj.json_to_object(res.body)
    @ontology_obj.print_ontology_item
  else
    puts "Failed to retrieve '#{id}' from '#{OntologyApi::BASE_URI}'".red

    # Application should be exited if any kind of exception is thrown.
    # Otherwise an empty Ontology object could be created.
    exit
  end
end

####################################################
# CLI application to retrieve an ontology identifier
# Starts here
####################################################

# Options originating from the terminal
@options = {}
# Declare an empty ontology class object at the start of the script
@ontology_obj = OntologyItem.new()

# Using the the OptionParser to parse the options submitted by the user.
OptionParser.new do |opts|
  opts.banner = "usage: ruby cli_app.rb [options]"
  opts.on("-h", "--help", "Show help message") do
    puts opts
    puts "Example:".yellow
    puts "ruby cli_app.rb [--id efo] [--outputdir /MyPath/To/MyDirectory/] [--outputfile my_json_file] [--format json]".yellow
    puts "or".yellow
    puts "ruby cli_app.rb [-i efo] [-d /MyPath/To/MyDirectory/] [-o my_csv_file] [-f csv]".yellow
    exit
  end
  opts.on("-i", "--id ID", "Ontology ID to look up [mandatory]") do |id_val|
    @options[:ontology_id] = id_val
  end
  opts.on("-d", "--outputdir DIR", "Output directory [optional]") do |od|
    @options[:outputdir] = od
  end
  opts.on("-o", "--outputfile FILE", "Output file [optional]") do |of|
    @options[:outputfile] = of
  end
  opts.on("-f", "--format FORMAT", "Format of the output file [optional]. Choose between \"json\" and \"csv\"") do |frmt|
    @options[:outputformat] = frmt
  end
end.parse!

# Look up the ontology provided by the user and printing the information to STDOUT
if @options[:ontology_id]
  look_up_id(@options[:ontology_id])
else
  puts "You did not provide an id. Please refer to the help instructions by entering \"cli_app.rb --help\" in the terminal".red
end

# If the user specified an output folder and output file, the information will be exported to a file
if @options[:outputfile] && @options[:outputdir]

  filepath = @options[:outputdir] + @options[:outputfile]

  # Depending on the chosen format, a csv file or a json file will be created
  case @options[:outputformat].downcase
  when "json"
    @ontology_obj.object_to_json("#{filepath}.json")
  when "csv"
    @ontology_obj.object_to_csv("#{filepath}.csv")
  else
    puts "Export format \"#{@options[:outputformat]}\" not recognised. Please choose csv or json!".red
  end
end
