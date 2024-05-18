import psycopg2


def create_connection(db_name, db_user, db_password, db_host, db_port):
    connection = None
    try:
        connection = psycopg2.connect(
            database=db_name,
            user=db_user,
            password=db_password,
            host=db_host,
            port=db_port
        )
        print("Connection to PostgreSQL DB successful")
        connection.autocommit = True
    except Exception as e:
        print(f"The error '{e}' occurred")
    return connection


def read_entry(connection, table_name):
    try:
        with connection.cursor() as cursor:
            cursor.execute(f"""
            select * from {table_name}
            """)
            result = cursor.fetchall()
        return result
    except Exception as e:
        print(f"The error '{e}' occurred")


def check_columns(connection, table_name):
    try:
        with connection.cursor() as cursor:
            column_name_query = f"""
                               SELECT column_name
                               FROM information_schema.columns
                               WHERE table_name = '{table_name}'
                               ORDER BY ordinal_position ASC;
                           """
            cursor.execute(column_name_query)
            columns = cursor.fetchall()
            column_names = [col[0] for col in columns]
            return column_names
    except Exception as e:
        print(f"The error '{e}' occurred")
        return None


def add_entry(connection, table_name, data):
    try:
        with connection.cursor() as cursor:
            user_records = ", ".join(["%s"] * len(data))
            column_names = check_columns(connection, table_name)
            insert_query = f"INSERT INTO {table_name} ({', '.join(column_names)}) VALUES {user_records}"
            cursor.execute(insert_query, data)
            return None
    except Exception as e:
        print(f"The error '{e}' occurred")
        return e


def update_entry(connection, table_name, row, uid):
    try:
        with connection.cursor() as cursor:
            column_names = check_columns(connection, table_name)
            update_values = row[0]
            user_records = ', '.join([f"{column} = %s" for column in column_names[1:]])
            update_description = f"""
                                   UPDATE {table_name} SET {column_names[0]} = %s, {user_records} WHERE {column_names[0]} = %s
                                   """
            print(update_description)
            cursor.execute(update_description, (*update_values, uid))
        return
    except Exception as e:
        print(f"The error '{e}' occurred")
        return e


def delete_entry(connection, table_name, row):
    try:
        with connection.cursor() as cursor:
            column_names = check_columns(connection, table_name)
            cursor.execute(f"DELETE FROM {table_name} WHERE {column_names[0]} = {row[0]}")
    except Exception as e:
        print(f"The error '{e}' occurred")


connect = create_connection("railway_db", "postgres", "postgresql", "localhost", "5432")
users = [(1, "male", "Denmark")]
update_entry(connect, "station_employees", users, 40)