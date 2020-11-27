from flask import Flask, render_template, request
import pymysql

app = Flask(__name__)


def get_mysql_cursor():
    conn = pymysql.connect('localhost', user="root", passwd="1020zxc..", db="erg3010", port=3306)
    cursor = conn.cursor()
    return conn, cursor


@app.route('/', methods=['GET'])
def index():
    test_data = []
    return render_template('index.html', test_data=test_data)
def home():
    test_data1 = []
    return render_template('home.html', test_data1=test_data1)


@app.route('/search', methods=['POST'])
def search_data():
    conn, cursor = get_mysql_cursor()
    keyword = request.form.get("search")
    country = request.form.get("country")
    if keyword:
        select_sql_str = f"select * from rawdata where  COUNTY_CODE_003 like '%{country}%'  limit 0,20"
        cursor.execute(select_sql_str)
        data = cursor.fetchall()
        if data:
            data = list(data)
            test_data = [list(item) for item in data]
        else:
            test_data = []
        return render_template('index.html', test_data=test_data)



if __name__ == '__main__':
    app.run(debug=True, port=5546)
