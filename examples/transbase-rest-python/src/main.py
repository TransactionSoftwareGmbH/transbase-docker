from flask import Flask, json
from transbase import transbase

connection = transbase.connect(url="//develop.transaction.de:8324/test",  # "//transbase.db:2024/sample",
                               user="test",
                               password="test")


def fetch_cashbooks():
    cursor = connection.cursor()
    cursor.execute("select * from test")
    result = cursor.fetchall()

    with_col_names = [{col[0]: row[index]
                       for index, col in enumerate(cursor.description)} for row in result]
    cursor.close()
    return with_col_names


api = Flask(__name__)


@api.route('/', methods=['GET'])
def get_cashbooks():
    return json.dumps(fetch_cashbooks())


if __name__ == '__main__':
    api.run(port=8080)
