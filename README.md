# Gremlin Console
This Docker image contains the [Gremlin Console](https://tinkerpop.apache.org/docs/current/tutorials/the-gremlin-console/)
(running on Java 8). It also allows configuration via the `/conf` directory, and has another volume mounted, where you can
export and import data.

## Run the console
To run the console, and mount the configuration and data directories (`~/temp/gremlin-conf/` and `~/temp/gremlin-data`,
respectively), run the following command:

```bash
docker run -v ~/temp/gremlin-data:/opt/gremlin/data -v ~/temp/gremlin-conf:/opt/gremlin/conf/extra  --rm -it cruftlab/gremlin-console
```

## Configuration volume
You can mount configurations in the `/opt/gremlin/data/extra` volume. Here are a few examples of what you can do:

* [Connect to a Neptune DB instance](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-gremlin-console.html)
* [Connect to a Cosmos DB instance](https://docs.microsoft.com/en-us/azure/cosmos-db/create-graph-gremlin-console#ConnectAppService)

## Data volume
You can use the data volume to export and import data to your database. In the following examples `~/temp/gremlin-data` 
is mounted to `/opt/gremlin/data`.

[Read the docs](https://tinkerpop.apache.org/docs/current/reference/#_gremlin_i_o) for more information on how to use
this volume, or read the examples below.

### Export graph
To export the "Modern" graph as GraphSON, run the following command in the console:

```
graph = TinkerFactory.createModern()
graph.io(graphson()).writeGraph("data/tinkerpop-modern.json")
```

The "Modern" graph will now be available in GraphSON format in `~/temp/gremlin-data/tinkerpop-modern.json`

### Import graph
To import a graph from a GraphSON file, stored under `~/temp/gremlin-data/my-graph.json`, run the following command in the console:

```
graph = TinkerGraph.open();
graph.io(graphson()).readGraph("data/my-graph.json");
```
