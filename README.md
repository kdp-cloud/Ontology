# Ontology

This repository contains the solution for the assignment regarding the software developer position.

![](https://img.shields.io/github/license/kdp-cloud/Ontology)

The repository contains the following elements:

- Some reusable functionality, written in ruby, to interact with the [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index). The functionality is packaged in the [lib/Ontology.rb](./lib/Ontology.rb) as a module called `OntologyApi`.
- A ruby class object to represent the data retrieved from the API. This Class object can also be found on the following location [lib/Ontology.rb](./lib/Ontology.rb) and is called `OntologyItem`.
- A CLI Application which uses the module and class as a demonstration. It makes requests to the REST API and returns the response to the STDOUT or write it to a json or csv file. The usage of the application is described in the [usage section](#usage) below. The CLI application will be executable from the command-line.

## Table of contents

- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Complete installation](#complete-installation)
  - [Install the gem](#include-the-gem-using-bundler)
- [Usage of the Ontology gem](#usage-of-the-ontology-gem)
  - [Making a GET request to the API](#making-a-get-request-to-the-api)
  - [Processing the information](#processing-the-information)
- [Basic search for an Ontology ID](#usage-of-the-cli-application)
  - [Get the help function](#get-the-help-function)
  - [Basic search for an Ontology ID](#basic-search-for-an-ontology-id)
  - [Saving the output of the application to a file](#saving-the-output-of-the-application-to-a-file)

## Installation

### Prerequisites

This installation procedure assumes ruby is correctly installed on the system. If not, note that this version requires a version of ruby (>= 2.7.5).

### Complete installation

If you want to install the complete application, procede with the following steps. Otherwise, if you only want to implement the gem in your own project, follow the steps described in [Install the gem](#include-the-gem-using-bundler).

1. Clone the contents of this repository using git

```bash
git clone https://github.com/kdp-cloud/Ontology.git
```

2. `cd` into the "Ontology" folder (or if you renamed it, the folder where the content was downloaded).
3. Execute the setup file in the "bin" folder

```bash
./bin/setup
```

### Include the gem using bundler

Add the following line to the Gemfile:

<pre>
gem "Ontology", git: "https://github.com/kdp-cloud/Ontology", branch: "master", glob: "*.gemspec"
</pre>

Use bundler to install the dependecies:

```bash
bundler install
```

## Usage of the Ontology gem

### Making a GET request to the API

To make a GET request, you can use the `{ruby} send_request` function as such:

```ruby
response = send_request("https://www.ebi.ac.uk/ols/api/ontologies/efo")
```

Alternatively you can use the `get_ontology_by_id` helper function which only requires the ontology identifier instead of the whole URI.

```ruby
response = get_ontology_by_id("efo")
```

This line of code returns the same information as before.

### Processing the information

To make the processing of the data easier, the user can make use of the OntologyItem Class Object, which comes with some useful functions.

1. Make an OntologyItem object, based on the response from the API:

```ruby
my_ontology = OntologyItem.new

my_ontology.json_to_object(response.body)

```

The `json_to_object` function will select the relevant information from the body:

- Ontology ID
- Full title
- Description
- Number of terms
- Status

2. Prints the content Ontology item to the STDOUT:

```ruby
my_ontology.print_ontology_item
```

3. Convert the Ontology item to a json file:

```ruby
my_ontology.object_to_json("./ExportFolder/exportfile.json")

```

This function writes the following content to "exportfile.json"

<pre>
{
  "ontologyId": "efo",
  "title": "Experimental Factor Ontology",
  "description": "The Experimental Factor Ontology (EFO) provides a systematic description of many experimental variables available in EBI databases, and for external projects such as the NHGRI GWAS catalogue. It combines parts of several biological ontologies, such as anatomy, disease and chemical compounds. The scope of EFO is to support the annotation, analysis and visualization of data handled by many groups at the EBI and as the core ontology for OpenTargets.org",
  "numberOfTerms": 37758,
  "status": "LOADED"
}

</pre>

4.  Convert the Ontology item to a csv file:

```ruby
my_ontology.object_to_csv("./ExportFolder/exportfile.csv")

```

This function writes the following content to "exportfile.csv"

<pre>
ontologyId,title,description,numberOfTerms,status
efo,Experimental Factor Ontology,"The Experimental Factor Ontology (EFO) provides a systematic description of many experimental variables available in EBI databases, and for external projects such as the NHGRI GWAS catalogue. It combines parts of several biological ontologies, such as anatomy, disease and chemical compounds. The scope of EFO is to support the annotation, analysis and visualization of data handled by many groups at the EBI and as the core ontology for OpenTargets.org",37758,LOADED
</pre>

## Usage of the CLI application

### Get the help function

To get some help on the usage of the CLI app enter in one of the following commands:

```bash
ontology -h
```

or

```bash
ontology --help
```

### Basic search for an Ontology ID

To perform a basic search for a specific Ontology identifier, enter one of these commands in the terminal:

```bash
ontology -i <ontology ID>
```

or

```bash
ontology --id <ontology ID>
```

#### Example

This and example of a simple request for a Ontology ID like 'efo':

```bash
ontology --id efo
```

The CLI app returns by default a json object okf the Ontology ID provided by the user:

<pre>
Looking up 'efo' on 'https://www.ebi.ac.uk/ols/api/ontologies' ...
efo succesfully retrieved!
--------------------------------------------------------------------------------
{
"ontologyId": "efo",
"title": "Experimental Factor Ontology",
"description": "The Experimental Factor Ontology (EFO) provides a systematic description of many experimental variables available in EBI databases, and for external projects such as the NHGRI GWAS catalogue. It combines parts of several biological ontologies, such as anatomy, disease and chemical compounds. The scope of EFO is to support the annotation, analysis and visualization of data handled by many groups at the EBI and as the core ontology for OpenTargets.org",
"numberOfTerms": "37758",
"status": "LOADED",
}
</pre>

### Saving the output of the application to a file

A user can choose to save the result of his query in a json or csv file. The user has specify a `output directory`, the name of the `output file` and the `format` of the output file.

```bash
ontology --i <Ontology ID> -d </Path/To/Directory/> -o <filename> -f <format = 'json' or 'csv'>
```

or

```bash
ontology --id <Ontology ID> --outputdir </Path/To/Directory/> --outputfile <filename> --format <format = 'json' or 'csv'>
```

#### Example

The following example saves the output of the request in a json file:

```bash
ontology --id efo --outputdir ./My_Directory/ --outputfile my_json_file --format json
```

The following example saves the output of the request in a csv file:

```bash
ontology --id efo --outputdir ./My_Directory/ --outputfile my_json_file --format csv
```
