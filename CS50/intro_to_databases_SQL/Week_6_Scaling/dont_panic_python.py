"""
In hack.py, write a Python program to achieve the following:
Connect, via Python, to a SQLite database.
Alter, within your Python program, the administrator’s password.
"""

from cs50 import SQL
# Data base name
db_name = "dont-panic"
# Establishing connection to the database
db = SQL(f"sqlite:///{db_name}.db")
# User input password
password = input("Enter a password: ")
# Execute SQL code
db.execute(
    """
    UPDATE "users"
    SET "password" = ? -- Placeholder for user´s input
    WHERE "username" = 'admin';
    """,
    password # Tell the execute method to substitute the placeholder ?, with the variable password
)
print("Hacked!")
