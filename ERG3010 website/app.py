from flask import Flask, render_template, request
import pymysql

app = Flask(__name__)


def get_mysql_cursor():
    conn = pymysql.connect('localhost', user="root", passwd="1020zxc..", db="reconstruct_2", port=3306)
    cursor = conn.cursor()
    return conn, cursor


@app.route('/', methods=['GET'])
def index():
    test_data = []
    return render_template('index.html', test_data=test_data)


@app.route('/search', methods=['POST'])
def search_data():
    conn, cursor = get_mysql_cursor()
    keyword = request.form.get("search")
    if keyword:
        select_sql_str = "select STATE_CODE_001, HIGHWAY_DISTRICT_002, COUNTY_CODE_003, STRUCTURE_NUMBER_008, YEAR_BUILT_027 from rawdata where STATE_CODE_001 = \'" + keyword + "\' limit 0, 20"
        print(select_sql_str)
        cursor.execute(select_sql_str)
        data = cursor.fetchall()
        if data:
            data = list(data)
            test_data = [list(item) for item in data]
        else:
            test_data = []
        return render_template('index.html', test_data=test_data)



if __name__ == '__main__':
    app.run(debug=True, port=5546)
