# Ontology

This repository contains the solution for the assignment regarding the software developer position.

![](https://img.shields.io/github/license/kdp-cloud/Ontology)

The repository contains the following elements:

- Some reusable functionality, written in ruby, to interact with the [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index). The functionality is packaged in the [lib/Ontology.rb](./lib/Ontology.rb) as a module called `OntologyApi`.
- A ruby class object to represent the data retrieved from the API. This Class object can also be found on the following location [lib/Ontology.rb](./lib/Ontology.rb) and is called `OntologyItem`.
- A CLI Application which uses the module and class as a demonstration. It makes requests to the REST API and returns the response to the STDOUT or write it to a json or csv file. The usage of the application is described in the [usage section](#usage) below.

## Table of contents

- [Prerequisites](#prerequisites)
- [Installing](#installation)
- [Usage](#usage)
- [Tests](#tests)

## Installation

download the contents of

Install the gem and add to the application's Gemfile by executing:

    $ bundle add Ontology

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install Ontology

## Usage

### Get the help function

To get some help on the usage of the CLI app enter in one of the following commands:

```bash
ruby cli_app.rb -h
```

or

```bash
ruby cli_app.rb --help
```

### Basic search for an Ontology ID

To perform a basic search for a specific Ontology identifier, enter one of these commands in the terminal:

```bash
ruby cli_app.rb -i <ontology ID>
```

or

```bash
ruby cli_app.rb --id <ontology ID>
```

#### Example

This and example of a simple request for a Ontology ID like 'efo':

```bash
ruby cli_app.rb --id efo
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
ruby cli_app.rb --i <Ontology ID> -d </Path/To/Directory/> -o <filename> -f <format = 'json' or 'csv'>
```

or

```bash
ruby cli_app.rb --id <Ontology ID> --outputdir </Path/To/Directory/> --outputfile <filename> --format <format = 'json' or 'csv'>
```

#### Example

The following example saves the output of the request in a json file:

```bash
ruby cli_app.rb --id efo --outputdir ./My_Directory/ --outputfile my_json_file --format json
```

The following example saves the output of the request in a csv file:

```bash
ruby cli_app.rb --id efo --outputdir ./My_Directory/ --outputfile my_json_file --format csv
```
