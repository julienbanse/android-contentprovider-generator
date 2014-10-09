Android ContentProvider Generator
=================================

A small tool to generate an Android ContentProvider.
It takes a set of entity (a.k.a "table") definitions as the input, and generates:
- a `ContentProvider` class
- a `SQLiteOpenHelper` class
- one `BaseColumns` interface per entity 
- one `CursorWrapper` class per entity
- one `ContentValues` class per entity
- one `Selection` class per entity

How to use
----------

### The `_config.json` file

This is where you declare a few parameters that will be used to generate the code.

These are self-explanatory so here is an example:
```json
{
	"toolVersion": "1.6",
	"projectPackage": "com.example.app",
	"providerPackage": "com.example.app.provider",
	"providerClassName": "ExampleProvider",
	"sqliteHelperClassName": "ExampleSQLiteOpenHelper",
	"authority": "com.example.app.provider",
	"databaseName": "example.db",
	"enableForeignKeys": true
}
```

### Entity files

Create one file per entity, naming it `<entity name>.json`.
Inside each file, declare your fields (a.k.a "columns") with a name and a type.
You can also optionally declare a default value, an index flag and a nullable flag.

Currently the type can be:
- `String` (SQLite type: `TEXT`)
- `Integer` (`INTEGER`)
- `int` (`INTEGER`) with default value 0 if not set
- `Long` (`INTEGER`)
- `long` (`INTEGER`) with default value 0 if not set
- `Float` (`REAL`)
- `float` (`REAL`) with default value 0 if not set
- `Double` (`REAL`)
- `double` (`REAL`) with default value 0 if not set
- `Boolean` (`INTEGER`)
- `boolean` (`INTEGER`) with default value 0 if not set
- `Date` (`INTEGER`)
- `byte[]` (`BLOB`).

You can also optionally declare table contraints.

Here is a `person.json` file as an example:

```json
{
	"fields": [
		{
			"name": "first_name",
			"type": "String",
			"default_value": "John"
		},
		{
			"name": "last_name",
			"type": "String",
			"nullable": true,
			"default_value": "Doe"
		},
		{
			"name": "age",
			"type": "Integer",
			"index": true
		}
	],
	"constraints": [
		{
			"name": "unique_name",
			"definition": "unique (first_name, last_name) on conflict replace"
		}
	]
}
```

A new entity type can be used : View

```json
{
    "type":"view",
	"fields": [
		{
            "table": "person",
            "name": "_id",
            "type": "long"
        },
		{
		    "table": "person",
			"name": "first_name",
			"type": "String"
		},
		{
		    "table": "person",
			"name": "last_name",
			"type": "String"
		},
		{
		    "table": "company",
			"name": "name",
			"new_name": "company_name",
			"type": "String"
		}
	],
	"from": "company, person",
	 "where": "person.company_id = company._id"
}
```

A more complete example is available in the `etc/sample` folder.

### The `header.txt` file (optional)

If a `header.txt` file is present, its contents will be inserted at the top of every generated java file.


### Run the app

`java -jar android-contentprovider-generator-1.6-bundle.jar -i <input folder> -o <output folder>`
- Input folder: where to find _config.json and your entity json files
- Output folder: where the resulting files will be generated

### Use the generated files

- When querying a table, use the corresponding `Selection` class as shown in this example:

```java
PersonSelection where = new PersonSelection();
where.firstName("John").or().age(42);
Cursor c = context.getContentResolver().query(PersonColumns.CONTENT_URI, projection,
        where.sel(), where.args(), null);
```
- When using the results of a query, wrap the resulting `Cursor` in the corresponding `CursorWrapper`.  You can then use
the generated getters directly as shown in this example:

```java
PersonCursorWrapper person = new PersonCursorWrapper(c);
String lastName = person.getLastName();
Long age = person.getAge();
```
- When updating or inserting into a table, use the corresponding `ContentValues` class as shown in this example:

```java
PersonContentValues values = new PersonContentValues();
values.putFirstName("John").putAge(42);
context.getContentResolver().update(personUri, values.getContentValues(), null, null);
```

Building
--------

You need maven to build this app.

`mvn package`

This will produce `android-contentprovider-generator-1.6-bundle.jar` in the `target` folder.


Licence
-------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*Just to be absolutely clear, this license applies to this program itself,
not to the source it will generate!*
