# Github public repositories searcher

## How-to run

### Native
```bash
bundle install
puma
```

### Docker
```bash
docker build -t imagetag .
docker run --rm -p 9292:9292 imagetag 
```

Navigate to `localhost:9292`

### Further improvements
1. Add logging
2. Add monitoring
3. Add controller tests
4. Add ability to authenticate using Github to get better quotas on API usage