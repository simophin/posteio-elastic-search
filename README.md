# posteio-xapian
A [poste.io](https://poste.io) docker image compiled with [fts-elastic](https://github.com/filiphanes/fts-elastic) support.

## Additional Docker Environment
You can set the elasticsearch host by overriding this environment variable:

`ELASTICSEARCH_HOST=http://localhost:9200`

## Elasticsearch preparation
You must follow [this step](https://github.com/filiphanes/fts-elastic#elasticsearch-index) to initialise your Elasticsearch instance before you can do anything useful.
