import io
import unittest

from bytes_buffer_io import BytesBufferIO

TEXT = "Hello world.\n"


class BytesBufferIOTest(unittest.TestCase):
    def test_value_available_after_close(self):
        bytesbufio = BytesBufferIO()
        with io.TextIOWrapper(bytesbufio, encoding='utf-8') as textout:
            textout.write(TEXT)
        self.assertEqual(TEXT, bytesbufio.getvalue().decode('utf-8'))
