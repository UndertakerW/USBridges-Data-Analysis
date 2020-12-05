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

@app.route('/info/',methods=['GET'])
def info():
    return render_template('info.html')
    
@app.route('/search', methods=['POST'])
def search_data():
    conn, cursor = get_mysql_cursor()
    info_list = [request.form.get("statecode"), request.form.get("countrycode"), request.form.get("year1"),
                request.form.get("year2"), request.form.get("highway"), request.form.get("struct"), 
                request.form.get("option_1"), request.form.get("option_2")
    ]

    query = 'select STATE_CODE_001, HIGHWAY_DISTRICT_002, COUNTY_CODE_003, STRUCTURE_NUMBER_008, YEAR_BUILT_027 from rawdata '


    query_conditions = ['STATE_CODE_001 = ', 'COUNTY_CODE_003 = ', 'YEAR_BUILT_027 >= ', 'YEAR_BUILT_027 <= ', 
                            'HIGHWAY_DISTRICT_002 ', 'STRUCTURE_NUMBER_008 ']

    has_constain = False

    for i in range(6):
        if(info_list[i] and info_list[i].isspace() == False and info_list[i] != ''):
            if(has_constain == False):
                query += ' where '
                has_constain = True
            else:
                query += ' and '
            
            if(i <= 3):
                query += (query_conditions[i] + '\'' + info_list[i] + '\'')
            else:
                query += query_conditions[i]
                if(info_list[i+2] == "0"):
                    query += ('= \'' + info_list[i] + '\'')
                elif(info_list[i+2] == "1"):
                    query += ('like \'%' + info_list[i] + '\'')
                elif(info_list[i+2] == "2"):
                    query += ('like \'%' + info_list[i] + '%\'')
                else:
                    query += ('like \'' + info_list[i] + '%\'')

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
