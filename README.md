# Contact server
## Steps to run the server
1. The server has been connected to a MySQL database.\
you will need to have a [mysql server](https://dev.mysql.com/downloads/mysql/).\
You can see more database details in [config/database.yml](https://github.com/RaquelGG/contacts-server/blob/main/config/database.yml).

1. Download this repository 

2. Go to the project folder and install dependencies\
   ```
   bundle install
   ```
   **In case of error** installing MySQL with bundle:\
    &nbsp;&nbsp;&nbsp; The `mysql-connector-c-6.1.11` is needed, you can get it [here](https://downloads.mysql.com/archives/c-c/).\
    &nbsp;&nbsp;&nbsp; For windows, get the .zip one.
    - Extract it in `[your-path]/mysql-connector-c-6.1.11-[your-OS]` and in the project folder run:
        ```
        bundle config --local build.mysql2 --with-mysql-lib="[your-path]/mysql-connector-c-6.1.11-[your-os]"
        ```

3. Prepare your database
   ``` 
   rails db:migrate
   ```
4. If you want to run the tests
    ```
    rails db:migrate RAILS_ENV=test
    ```
    And then run the tests
    ```
    rails exec rspec
    ```
5. Finally, run Rails
   ```
   rail server
   ```


### The following tables will be created in MySQL from rails models

| contacts |        | changes    |
|---------:|:------:|------------|
|          |        | id         |
|       id | <- 1:* | id_contact |
|     name |        | date       |
|  surname |        | name       |
|    email |        | surname    |
|      tel |        | email      |
|          |        | tel        |

## Additional dependecies
- Readapt
- FactoryBot
- Faker
- CleanDatabase
  
## Possible improvements
- Use mock test without depending on the test database
- Add authentication
- HTTPS
- Remove unused routes
- Serve the frontend files from the backend