# cwdb_importer

Imports [clues](http://otsys.com/clue/) data to mongodb. 

## Usage
1. Download raw clue database from [http://otsys.com/clue/](http://otsys.com/clue/)
2. Create connection_string file on root directory with string like `mongodb://<dbuser>:<dbpassword>@ds153239.mlab.com:53239/huseyin`
3. `ruby cwdb_importer.rb`