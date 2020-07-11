import io
import unittest

from bytesio_issue.bytes_buffer_io import BytesBufferIO

TEXT = "Hello world.\n"


class IssueTest(unittest.TestCase):
    def test_show_issue(self):
        with self.assertRaises(ValueError, msg="I/O operation on closed file."):
            bytesio = io.BytesIO()
            with io.TextIOWrapper(bytesio, encoding='utf-8') as textout:
                textout.write(TEXT)
            self.assertEqual(TEXT, bytesio.getvalue().decode('utf-8'))

    def test_show_fix(self):
        bytesio = BytesBufferIO()
        with io.TextIOWrapper(bytesio, encoding='utf-8') as textout:
            textout.write(TEXT)
        self.assertEqual(TEXT, bytesio.getvalue().decode('utf-8'))
