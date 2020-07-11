# Python BytesBufferIO

This repo demonstrates an issue with io.BytesIO. The value of an BytesIO object cannot be accessed after the object has been closed.

* [Test that shows the problem](./tests/bytesio_issue_test.py)
* [Fixed implementation - BytesBufferIO](./src/bytesio_issue/bytes_buffer_io.py)

### Example
```python
import io

from bytes_buffer_io import BytesBufferIO

bytesbufio = BytesBufferIO()
with io.TextIOWrapper(bytesbufio, encoding='utf-8') as textout:
    textout.write("Hello world.")

text = bytesbufio.getvalue().decode('utf-8') # BytesIO would have raised an ValueError here 
print(text)
```

### Related
[Python Issue 23099](https://bugs.python.org/issue23099)

### License
[MIT](./license.txt)
