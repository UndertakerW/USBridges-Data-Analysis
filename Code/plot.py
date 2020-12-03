import pymysql
from matplotlib import pyplot as plt
from matplotlib.font_manager import FontProperties
# 获取出版社和书数量
def getbookinfo():
    # 1- 连接数据库
    connect = pymysql.connect(host="localhost",
                              user="root",
                              password="CPTBTPTP",
                 database="erg3010",
                              port=3306,
                              charset='utf8')
    # 2- 执行sql
    cursor = connect.cursor()
    select = """
            select STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B, YEAR_BUILT_027, count(*) from design_load
group by STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B
order by STRUCTURE_KIND_043A, STRUCTURE_TYPE_043B;
            """
    cursor.execute(select)
    result = cursor.fetchall()
    x = []   # 存储10个出版社
    y = []   # 存储10个出版社的书籍数量
    z = []
    for r in result:
        # print(r)  # 出版社,数量
        x.append(int(r[0]))    # 出版社
        y.append(int(r[1]))    # 数量
        z.append(int(r[2]))
    return x,y,z  # 返回两个结果


def getbookinfo2(a):
    # 1- 连接数据库
    connect = pymysql.connect(host="localhost",
                              user="root",
                              password="CPTBTPTP",
                 database="erg3010",
                              port=3306,
                              charset='utf8')
    # 2- 执行sql
    cursor = connect.cursor()
    select = "select "+a+",avg(BRIDGE_IMP_COST_094) from find_cost where "+a+" != \'\' group by "+a+" order by "+a+";"
    if(a=='Q2_1'):
        select='''select attr1, stddev(num) from stddev_attr
group by attr1
order by attr1;
'''
    if(a=='Q2_2'):
        select='''

select attr2, stddev(num),max(num) from stddev_attr
group by attr2
order by attr2'''
    cursor.execute(select)
    result = cursor.fetchall()
    x = []   # 存储10个出版社
    y = []   # 存储10个出版社的书籍数量
    
    for r in result:
        if(r[0]==''or r[1]==''): continue
        # print(r)  # 出版社,数量
        if(r[0]=="N"): continue
        x.append(int(r[0]))    # 出版社
        y.append(int(r[1]))    # 数量
        
    return x,y  # 返回两个结果



def pltit(x1,y,name):
    
    plt.style.use('ggplot')
    fig=plt.figure(1)
    width = 0.25
    plt.bar(x1, y, width)
    #ax3.bar(x + width, y2, width, color=plt.rcParams['axes.color_cycle'][2])
    #plt.set_xticks(x1 + width)
    #plt.set_xticklabels(x1)
    plt.savefig("C:\\Users\\10514\\Desktop\\ERG3010 fig\\"+name+".png")
    plt.show()


# 绘制图形，显示结果
def books_bar(x,y,z,name):
    
    fig = plt.figure()
    ax = fig.gca(projection='3d')
    ax.plot(x,y,z)
    plt.savefig("C:\\Users\\10514\\Desktop\\ERG3010 fig\\"+name+".png")
    plt.show()




if __name__ == "__main__":
    A=['STRUCTURE_KIND_043A','STRUCTURE_TYPE_043B', 'APPR_KIND_044A', 'APPR_TYPE_044B', 'DECK_COND_058','SUPERSTRUCTURE_COND_059',
'SUBSTRUCTURE_COND_060','CHANNEL_COND_061','WORK_PROPOSED_075A','WORK_DONE_BY_075B']
    
    for i in A:
        
        plt.style.use('ggplot')
        x,y= getbookinfo2(i)
        plt.xlabel(i,fontsize=10)
        plt.ylabel("average of cost",fontsize=10)
        pltit(x,y,i)
    x,y=getbookinfo2('Q2_1')
    plt.xlabel('STURCT_TYPE')
    plt.ylabel('stddev')
    pltit(x,y,'Q2_1')
    x,y=getbookinfo2('Q2_2')
    plt.xlabel('DESIGN_TYPE')
    plt.ylabel('stddev')
    pltit(x,y,'Q2_2')

    #books_bar(x,y,z,'Q2')
