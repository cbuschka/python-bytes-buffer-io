import io
import unittest

TEXT = "Hello world.\n"


class BytesIOTest(unittest.TestCase):
    def test_value_not_available_after_close(self):
        with self.assertRaises(ValueError, msg="I/O operation on closed file."):
            bytesio = io.BytesIO()
            with io.TextIOWrapper(bytesio, encoding='utf-8') as textout:
                textout.write(TEXT)
            bytesio.getvalue().decode('utf-8')

    def test_with_underlying_bytearray_does_not_work(self):
        bytesbuf = bytearray()
        with io.TextIOWrapper(io.BytesIO(bytesbuf), encoding='utf-8') as textout:
            textout.write(TEXT)
        self.assertEqual('', bytesbuf.decode('utf-8'))
