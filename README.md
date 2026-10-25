# SQL coursework

Historical SQL coursework covering database design, queries, and a final assignment with a report and entity-relationship diagram. Original work by [David Tom](https://github.com/davidtomofficial).

**Status: Historical educational examples.** This collection is separate from current David Tom Solutions (DTS) and David Tom Publishing (DTP) offerings. Offline checks cover the revised batch structure and sample data; the full coursework script has not been retested against SQL Server.

The [SQL180 final assignment](SQL180/Final%20Assignment/) models a fictional
library with books, genres, members, staff, events, loans, and event registrations.
It includes a SQL script, a database report, and an entity relationship diagram.

## Requirements and setup

The script targets **Microsoft SQL Server 2016 or later**. Use SQL Server Management
Studio or `sqlcmd`, which recognize the script's `GO` batch separators. A C++
compiler or `build-essential` is not required.

1. Create an empty, disposable database for the assignment on a local/test SQL
   Server instance.
2. Connect to that database explicitly. Confirm it is the coursework database.
3. Open `SQL180/Final Assignment/cit180_david_tom_hwFinal.sql` and run the whole
   script with a client that recognizes `GO`.
4. Review the seven tables and seven views printed at the end.

**The script drops and recreates its sample tables and views.** Run it only in a
disposable database. Re-running it resets the sample data.

For `sqlcmd`, replace the server and database placeholders with your disposable
test environment:

```sh
sqlcmd -S "YOUR_TEST_SERVER" -d "YOUR_DISPOSABLE_DATABASE" -E -b -i "SQL180/Final Assignment/cit180_david_tom_hwFinal.sql"
```

`-E` uses integrated authentication; choose your environment's supported
authentication method when needed. `-b` returns a failing exit status for SQL
errors. Applications sending commands directly through a database driver must
split batches themselves because `GO` is a client command, not SQL syntax.

## Validation

```sh
python -m unittest discover -s tests -v
```

The offline tests check SQL Server view-batch structure and exercise the shared
table/fixture SQL in a temporary in-memory SQLite database. These checks do not
replace running the full script twice against SQL Server. See the
[assignment README](SQL180/Final%20Assignment/README.md) for expected results.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for changes and validation expectations.

## Authors

* **David Tom** - *Initial Work* - [davidtomofficial](https://github.com/davidtomofficial)

See this repository's [commit history](https://github.com/davidtomofficial/SQL/commits/main/) for recorded changes. Additional authors and course-provided material remain credited in their respective files.

## License

The existing licensing statement is retained:

> This project is licensed under the GNU General Public License Version 3.

Read the [GNU GPL version 3 text](https://www.gnu.org/licenses/gpl-3.0.html). This repository currently has no local `LICENSE` file. Earlier READMEs linked to a license in the separate GitHub profile repository; that file is not a project-local license.

Existing file-specific notices and third-party attribution remain unchanged. The maintainer still needs to document the scope of the repository-level statement, confirm the version wording where file-specific notices do not already settle it, and add the appropriate local license text. This documentation update does not change existing licensing terms.

## Acknowledgements

* A big thanks to any and all contributors, no matter how big or small the contribution it all helps.
