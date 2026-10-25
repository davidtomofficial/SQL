"""Offline SQL structure/fixture checks, not SQL Server runtime validation."""

from pathlib import Path
import re
import sqlite3
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / 'SQL180/Final Assignment/cit180_david_tom_hwFinal.sql'
SQL = SCRIPT.read_text(encoding='utf-8')
BATCHES = re.split(r'(?im)^\s*GO\s*$', SQL)
COUNTS = {'Genre': 4, 'Book': 4, 'Member': 4, 'Staff': 4,
          'Event': 4, 'Loan': 4, 'MemberEvent': 8}


class SqlBatchTests(unittest.TestCase):
    def test_each_create_view_starts_an_independent_batch(self):
        found = []
        for batch in BATCHES:
            without_comments = re.sub(r'(?m)--.*$', '', batch).strip()
            if re.search(r'\bCREATE\s+VIEW\b', without_comments, re.IGNORECASE):
                match = re.fullmatch(r'CREATE VIEW (View_\w+) AS SELECT \* FROM (\w+);',
                                     without_comments, re.IGNORECASE)
                self.assertIsNotNone(match, 'CREATE VIEW must occupy its own batch')
                found.append(match.group(2))
        self.assertEqual(set(found), set(COUNTS))
        self.assertEqual(len(found), len(COUNTS))

    def test_drop_views_are_conditional_and_precede_table_resets(self):
        first_table_drop = SQL.index('DROP TABLE')
        for table in COUNTS:
            self.assertLess(SQL.index('DROP VIEW IF EXISTS View_' + table + ';'),
                            first_table_drop)


class SqlFixtureTests(unittest.TestCase):
    def setUp(self):
        self.database = sqlite3.connect(':memory:')
        self.database.execute('PRAGMA foreign_keys = ON')
        self.addCleanup(self.database.close)
        # These simple DDL/DML statements are also accepted by SQLite. Removing
        # client GO commands does not certify SQL Server syntax or semantics.
        self.fixture_sql = '\n'.join(BATCHES)

    def assert_fixture(self):
        for table, expected in COUNTS.items():
            with self.subTest(table=table):
                self.assertEqual(self.database.execute('SELECT COUNT(*) FROM ' + table).fetchone()[0],
                                 expected)
                table_rows = self.database.execute('SELECT * FROM ' + table).fetchall()
                view_rows = self.database.execute('SELECT * FROM View_' + table).fetchall()
                self.assertEqual(table_rows, view_rows)
        self.assertEqual(self.database.execute('PRAGMA foreign_key_check').fetchall(), [])

    def test_first_run_creates_fixture_and_matching_views(self):
        self.database.executescript(self.fixture_sql)
        self.assert_fixture()

    def test_second_run_resets_data_and_rebuilds_views(self):
        self.database.executescript(self.fixture_sql)
        self.database.execute("INSERT INTO Genre VALUES (99, 'Extra', 'Disposable test row')")
        self.database.executescript(self.fixture_sql)
        self.assert_fixture()

    def test_missing_foreign_key_is_rejected(self):
        self.database.executescript(self.fixture_sql)
        with self.assertRaises(sqlite3.IntegrityError):
            self.database.execute('INSERT INTO Loan (LoanID, BookID, MemberID) VALUES (99, 999, 1)')


if __name__ == '__main__':
    unittest.main()
