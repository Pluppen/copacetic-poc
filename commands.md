
1. Save Image Env variable
```bash
export IMAGE=docker.io/library/nginx:1.21.6
```

2. Run normal trivy scan
```bash
trivy image --vuln-type os --ignore-unfixed $IMAGE
```

3. Run trivy scan and output to JSON
```bash
trivy image --vuln-type os --ignore-unfixed -f json -o $(basename $IMAGE).json $IMAGE
```

4. Path image using Copa and Trivy output
```bash
copa patch -r $(basename $IMAGE).json -i $IMAGE
```

5. Run trivy scan to check patched image
```bash
trivy image --vuln-type os --ignore-unfixed $IMAGE-patched
```
