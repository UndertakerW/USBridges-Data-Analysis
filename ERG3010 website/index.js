//var con = new XMLHttpRequest("ADODB.Connection")
//var rs = new XMLHttpRequest("ADODB.Recordset")
function here(){
  console.log("function here");
  var con = new ActiveXObject("ADODB.Connection");
  var rs = new ActiveXObject("ADODB.Recordset");
  try{
    con.ConnectionString = "DSN=ERG3010;SERVER=localhost;User ID=root;Password=1020zxc..;Database=erg3010;Port=3307;"//"DRIVER={MySQL ODBC 8.0 Unicode Driver};OPTION=3;SERVER=localhost;User ID=root;Password=1020zxc..;Database=erg3010;Port=3307";  
    con.open;
    var sql = " select count(*) from design_load where YEAR_BUILT_027>2014; ";
    rs.open(sql, con);
    while (!rs.eof) {
      echo(rs.fields("YEAR_BUILT_027"+"\t"));
      rs.moveNext;
    }
  }
  catch(e){
    //异常报告
    echo("error");
    document.write(e.message);
    } finally{
    }
};

/*

  
  while (!rs.eof) {
    echo(rs.fields("YEAR_BUILT_027"+"\t"));
    rs.moveNext;
  }
  rs.close();
  rs = null; 
  con.close();
  con = null;
};*/

var hd=0;
var sn=0;
var sd=0;
var cd=0;
var y2=0;
var y1=0;
var hdv=0;
var snv=0;

function equal() {
  hd=1;
};
function equal1() {
  sn=1;
};
function start_with() {
  hd=2;
};
function start_with1() {
  sn=2;
};
function contains() {
  hd=3;
};
function contains1() {
  sn=3;
};
function end_with() {
  hd=4;
};
function end_with1() {
  sn=4;
};
function readtext() {
  sd=document.getElementById("input").value; 
  cd=document.getElementById("input1").value; 
  y1=document.getElementById("input2").value; 
  y2=document.getElementById("input3").value; 
  hdv=document.getElementById("input4").value; 
  snv=document.getElementById("input5").value; 
  console.log(sd);
};
