# Pocket-Kraft
Demo app using some of my favorite simple tools for building apps and now trying the hosting.

- [Astro](https://astro.build/) as static frontend
- [PocketBase](https://pocketbase.io) as CRM and backend
- [Unikraft](https://kraft.cloud) as hosting

## Dev
```sh
podman build -t pocket-kraft . 
podman run --rm -it -p 8090:8090 pocket-kraft
```

## Deploy
```sh
podman run -d --name buildkitd --privileged docker.io/moby/buildkit:latest 
kraft cloud deploy -p 443:8090 -M 300 --volume pocket-kraft:/app/pb_data .
```