# python bytesio issue

This repo demonstrates an issue with bytesio. The value of an BytesIO object cannot be accessed after the object has been closed.

* [Test that shows the problem](./tests/bytesio_issue_test.py)
* [Fixed implementation - BytesBufferIO](./src/bytesio_issue/bytes_buffer_io.py)

### License
[MIT](./license.txt)
