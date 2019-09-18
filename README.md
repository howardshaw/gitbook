# gitbook
docker image for gitbook based on alpine

# version

- CLI version: 2.3.2
- GitBook version: 3.2.3
- node: v10.16.3
- npm: 6.9.0


# build image

```
docker build -t <image_tag> --no-cache --rm .
```
# usage
```
docker run --rm -it -v $PWD:/srv/gitbook -p 4000:4000 <image_tag>
```

Suppose you write your markdown file in src directory and output html to docs directory.

Now you can start to write your own gitbook.
