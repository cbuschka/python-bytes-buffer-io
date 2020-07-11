# Releasing

```bash
make clean tests

git tag v1.2.3

make dist

git push origin --tags

make upload
```
