# Ontology

This repository contains the solution for the assignment regarding the software developer position.

![](https://img.shields.io/github/license/kdp-cloud/Ontology)

The repository contains the following elements:

- Some reusable functionality, written in ruby, to interact with the [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index). The functionality is packaged in the [lib/Ontology.rb](./lib/Ontology.rb) as a module called `OntologyApi`.
- A ruby class object to represent the data retrieved from the API. This Class object can also be found on the following location [lib/Ontology.rb](./lib/Ontology.rb) and is called `OntologyItem`.
- A CLI Application which uses the module and class as a demonstration. It makes requests to the REST API and returns the response to the STDOUT or write it to a json or csv file. The usage of the application is described in the [usage section](#usage) below. The CLI application will be executable from the command-line.

The module and class object in the Ontology.rb file are packaged in a gem, which can be found in the [gem folder](./gemfile/). The gem is designed so can be used seperately from the CLI application in other projects. The implementation and usage of the gem outisde the CLI application will not be discussed since this is out of the scope of the assignment.

## Table of contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage of the CLI application](#usage-of-the-cli-application)
  - [Get the help function](#get-the-help-function)
  - [Basic search for an Ontology ID](#basic-search-for-an-ontology-id)
  - [Saving the output of the application to a file](#saving-the-output-of-the-application-to-a-file)

## Prerequisites

This installation procedure assumes ruby is correctly installed on the system. If not, note that this application requires a version of ruby (>= 2.7.5).

## Installation

This section elaborates on how the complete application (Ontology gem + CLI application) can be installed.

1. Clone the contents of this repository using git

```bash
git clone https://github.com/kdp-cloud/Ontology.git
```

2. `cd` into the "Ontology" folder (or if you renamed it, the folder where the content was downloaded).

3. Execute the setup file in the "bin" folder

```bash
./bin/setup
```

This file will automatically install all dependencies, the 'Ontology' gem file and install it as an executable.

## Usage of the CLI application

The following section gives a brief description of how the use the CLI application.

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

This is an example of a simple request for an Ontology ID like 'efo':

```bash
ontology --id efo
```

The CLI app returns by default a json object of the Ontology ID provided by the user:

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

A user can choose to save the result of his query in a json or csv file. The user has to specify an `output directory`, the name of the `output file` and the `format` of the output file.

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
ontology --id efo --outputdir ./My_Directory/ --outputfile my_csv_file --format csv
```
