# cowsay-warp
speaking cow

```
docker run -d -p 3000:3000 --name cowsay-warp --restart always pdericson/cowsay-warp
```

## Marathon

```
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" localhost:8080/v2/apps -d @app.json
```
