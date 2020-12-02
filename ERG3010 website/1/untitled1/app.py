from flask import Flask, render_template, request
import pymysql

app = Flask(__name__)


def get_mysql_cursor():
    conn = pymysql.connect('localhost', user="root", passwd="1020zxc..", db="erg3010", port=3306)
    cursor = conn.cursor()
    return conn, cursor

@app.route('/',methods=['GET', 'POST'])
def home():
    return render_template('home.html')

@app.route('/view/',methods=['GET'])
def view():
    return render_template('view.html')


@app.route('/index', methods=['GET'])
def index():
    test_data = []
    return render_template('index.html', test_data=test_data)
    
@app.route('/search', methods=['POST'])
def search_data():
    conn, cursor = get_mysql_cursor()
    info_list = [request.form.get("statecode"), request.form.get("countrycode"), request.form.get("year1"),
                request.form.get("year2"), request.form.get("highway"), request.form.get("struct"), 
                request.form.get("option_1"), request.form.get("option_2")
    ]

    query = 'select STATE_CODE_001, HIGHWAY_DISTRICT_002, COUNTY_CODE_003, STRUCTURE_NUMBER_008, YEAR_BUILT_027 from rawdata '
    print(query)
    print(info_list[6])
    print(info_list[7])            

    cursor.execute(query)
    data = cursor.fetchall()
    if data:
        data = list(data)
        test_data = [list(item) for item in data]
    else:
        test_data = []
    return render_template('index.html', test_data=test_data)



if __name__ == '__main__':
    app.run(debug=True, port=5546)
