# CIT 180 final assignment: Library database

> Historical educational example. See the [repository overview](../../README.md) for context and validation limits.

Coursework by David Tom, originally dated December 10, 2023.

| File | Purpose |
| --- | --- |
| [cit180_david_tom_hwFinal.sql](cit180_david_tom_hwFinal.sql) | Recreate the sample SQL Server tables, insert fictional data, and show tables and views. |
| [cit180_david_tom_hwFinal.docx](cit180_david_tom_hwFinal.docx) | Original database report. |
| [cit180_ERD_hwFinal.drawio.pdf](cit180_ERD_hwFinal.drawio.pdf) | Original entity relationship diagram. |

## Run and verify

Follow the [repository setup instructions](../../README.md). Use SQL Server 2016
or later and a client that recognizes `GO` batches. This script **drops and
recreates its sample tables and views**; use a disposable database.

Run the complete script once in an empty database and once again in the same
disposable database. Both runs should finish without missing-view or view-batch
errors and produce these row counts:

| Table and corresponding `View_` view | Rows |
| --- | ---: |
| Genre | 4 |
| Book | 4 |
| Member | 4 |
| Staff | 4 |
| Event | 4 |
| Loan | 4 |
| MemberEvent | 8 |

Each view should return the same rows as its table. The data is fictional and is
intended for demonstrating relationships and queries, not a production library
system. The original DOCX and PDF remain historical coursework artifacts.

The script separates every `CREATE VIEW` into its own batch and drops existing
views before rebuilding the tables. Microsoft documents these rules in
[CREATE VIEW](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-view-transact-sql),
[DROP VIEW](https://learn.microsoft.com/en-us/sql/t-sql/statements/drop-view-transact-sql),
and [GO](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/sql-server-utilities-statements-go).

## Contributing

See the repository-local [contribution guide](../../CONTRIBUTING.md) for reporting issues and submitting focused pull requests while preserving the educational context.

## Authors

* **David Tom** - *Initial Work* - [davidtomofficial](https://github.com/davidtomofficial)

See this repository's [commit history](https://github.com/davidtomofficial/SQL/commits/main/) for recorded changes. Additional authors and course-provided material remain credited in their respective files.

## License

See the [repository licensing notes](../../README.md#license) for the retained GNU GPL version 3 statement, existing file-specific notices, and the scope clarification still needed before adding local license documentation.

## Acknowledgements

* A big thanks to any and all contributors, no matter how big or small the contribution it all helps.
