# frozen_string_literal: true

RSpec.describe Ontology do
  it "has a version number" do
    expect(Ontology::VERSION).not_to be nil
  end

  it "should return a HTTP status code 200" do
    expect(OntologyApi.get_ontology_by_id("efo").is_a?(Net::HTTPSuccess)).to eq(true)
  end

  it "Should raise an error and return 'nil' when entering a non existing identifier" do
    expect(OntologyApi.get_ontology_by_id("something")).to eq(nil)
  end
  puts OntologyApi.get_ontology_by_id(5).inspect
  it "Should raise an error when entering a number instead of a string" do
    expect(OntologyApi.get_ontology_by_id(5)).to eq(nil)
  end
end
