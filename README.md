## Artifactory


Run [Artifactory](http://www.jfrog.com/home/v_artifactory_opensource_overview) inside a Docker container. Ported from the artificatory image provided by [Matt Gruter](https://registry.hub.docker.com/u/mattgruter/artifactory/).


### Volumes
Artifactories `data`, `logs` and `backup` directories are exported as volumes:

    /artifactory/data
    /artifactory/logs
    /artifactory/backup

### Ports
The web server is accessible through port `8081`.

### Start the Container


    docker run -p 8081:8081 ankursingh081/jfrog-aarch64

### URLs
The artifactory servlet is available at the `artifactory/` path. However a filter redirects all paths outside of `artifactory/` to the artifactory servlet. Thus instead of linking to the URL http://localhost:8080/artifactory/libs-release-local you can just link to http://localhost:8080/libs-release-local (i.e. omitting the subpath `artifactory/`).
