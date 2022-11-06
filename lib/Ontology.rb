# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require "colorize"
require "csv"

# Module containing the functions used to interact with the Ontology REST API
module OntologyApi
  # Base URI or the API = CONSTANT
  BASE_URI = "https://www.ebi.ac.uk/ols/api/ontologies"

  # Function that sends a GET request to the API.
  # Returns the response if the request was handled succesful.
  # Returns a Error message if something went wrong.
  # Arguments:
  #   uri: (String)
  def self.send_request(uri)
    begin
      res = Net::HTTP.get_response(uri)
      raise "Apologies for the inconvenience. The service is currently unavailable.".red if res.is_a?(Net::HTTPServiceUnavailable)
      raise "ID not found. Please provide an existing ID!".red if res.is_a?(Net::HTTPNotFound)
      return res if res.is_a?(Net::HTTPSuccess)
    rescue StandardError => e
      puts "Something went wrong: #{e}".red
    end
  end

  # Helper function that requests the information of a certain ontology ID.
  # Arguments:
  #   id: (String)
  # Example:
  #   >> get_ontology_by_id("efo")
  #   => {
  #      "ontologyId": "efo",
  #      "title": "Experimental Factor Ontology",
  #      "description": "The Experimental Factor Ontology (EFO) provides a systematic description of many experimental variables available in EBI databases, and for external projects such as the NHGRI GWAS catalogue. It combines parts of several biological ontologies, such as anatomy, disease and chemical compounds. The scope of EFO is to support the annotation, analysis and visualization of data handled by many groups at the EBI and as the core ontology for OpenTargets.org",
  # rubocop:enable Layout/LineLength
  #      "numberOfTerms": "37758",
  #      "status": "LOADED",
  #      }
  def self.get_ontology_by_id(id)
    begin
      raise "The id must be of type 'String'. Please provide a valid ID.".red unless id.is_a?(String)

      uri = URI("#{BASE_URI}/#{id}")
      send_request(uri)
    rescue StandardError => e
      puts "Something went wrong: #{e}".red
    end
  end
end

# OntologyItem class object that holds the relevant information or attributes that is required for the user.
# Contains class function for processing this information.
class OntologyItem
  # Class object attributes
  attr_accessor :id, :full_ontology_title, :ontology_description, :number_of_terms, :current_status

  # Function that converts a json-string to an object
  def json_to_object(json_string)
    json_obj = JSON.parse(json_string, object_class: OpenStruct)
    self.id = json_obj.ontologyId
    self.full_ontology_title = json_obj.config.title
    self.ontology_description = json_obj.config.description
    self.number_of_terms = json_obj.numberOfTerms
    self.current_status = json_obj.status
  end

  # Function that prints the object information to the STDOUT.
  def print_ontology_item
    puts "-" * 80
    puts "{".blue
    puts "\"ontologyId\":".green + " \"#{id}\"" + ",".yellow
    puts "\"title\":".green + " \"#{full_ontology_title}\"" + ",".yellow
    puts "\"description\":".green + " \"#{ontology_description}\"" + ",".yellow
    puts "\"numberOfTerms\":".green + " \"#{number_of_terms}\"" + ",".yellow
    puts "\"status\":".green + " \"#{current_status}\"" + ",".yellow
    puts "}".blue
    puts "-" * 80
  end

  # Function that converts an object to a json file.
  def object_to_json(filepath)
    begin
      json_string = pretty_generate({
                                      "ontologyId" => id,
                                      "title" => full_ontology_title,
                                      "description" => ontology_description,
                                      "numberOfTerms" => number_of_terms,
                                      "status" => current_status
                                    })
      File.open(filepath, "w") do |f|
        f.puts(json_string)
      end
      puts "Ontology object succesfully written to \"#{filepath}\".".green
    rescue StandardError => e
      puts "An error occurred while exporting to json: #{e}".red
    end
  end

  # Function that converts an object to a csv file.
  def object_to_csv(filepath)
    begin
      CSV.open(filepath, "w") do |csv|
        csv << %w[ontologyId
                  title
                  description
                  numberOfTerms
                  status]
        csv << [id,
                full_ontology_title,
                ontology_description,
                number_of_terms,
                current_status]
      end
      puts "Ontology object succesfully written to \"#{filepath}\".".green
    rescue StandardError => e
      puts "An error occurred while exporting to csv: #{e}".red
    end
  end
end
