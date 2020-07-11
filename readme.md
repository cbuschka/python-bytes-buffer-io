# Python BytesBufferIO

This repo demonstrates an issue with io.BytesIO. The value of an BytesIO object cannot be accessed after the object has been closed.

* [Test that shows the problem](./tests/bytesio_issue_test.py)
* [Fixed implementation - BytesBufferIO](./src/bytesio_issue/bytes_buffer_io.py)

### Related
[Python Issue 23099](https://bugs.python.org/issue23099)

### License
[MIT](./license.txt)
