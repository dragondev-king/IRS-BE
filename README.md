* Ruby version
ruby-3.0.3

This project' goal is to parse the xml and store the results into table, and provide API endpoints.
It provides RESTful API.


- To create tables, you need to migrate
$rails db:migrate

- After tables are created, you need to parse XML files and store the results into tables.
  These course could be performed by following rake command.
ex: $rake parse_and_store['sample_data/1.xml']

- Start server
$rails server
