from pathlib import Path
import re
import subprocess
import unittest


ROOT = Path(__file__).resolve().parent.parent


class PrivateKeyTests(unittest.TestCase):
    def test_tracked_files_do_not_contain_private_keys(self):
        pattern = re.compile(
            rb"-----BEGIN (?:OPENSSH|RSA|EC|DSA) PRIVATE KEY-----"
            rb".+?-----END (?:OPENSSH|RSA|EC|DSA) PRIVATE KEY-----",
            re.DOTALL,
        )
        names = subprocess.check_output(
            ['git', 'ls-files', '-z'], cwd=ROOT
        ).decode().split('\0')
        found = []
        for name in names:
            path = ROOT / name
            if name and path.is_file() and not path.is_symlink():
                if pattern.search(path.read_bytes()):
                    found.append(name)
        self.assertEqual(found, [], 'Private keys must not be committed or baked into images')


if __name__ == '__main__':
    unittest.main()

