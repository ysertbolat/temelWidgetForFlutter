import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/screens/student_add.dart';
import 'package:temel_widget/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

//MyApp'i override edin
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String mesaj = "E-Sınav Sonuç Sistemi";

  Student selectedStudent = Student.withId(1,"","",0); //uydurma öğrenci yarattık sorun çıkmaması için

  List<Student> students = [
    Student.withId(1,"Yusuf", "Sertbolat", 65),
    Student.withId(2,"İshak Emre", "Kalaycı", 85),
    Student.withId(3,"Melih", "Eyüboğlu", 90),
    Student.withId(4,"Eren", "Kırcı", 30),
    Student.withId(5,"Fırat", "Aşğa", 20),
    Student.withId(6,"Göksel", "Yavuz", 49),
    Student.withId(7,"Melih Can", "Kırtoklu", 45),
    Student.withId(8,"Yasin Emre", "Karaman", 10)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mesaj),
        ),
        body: buildBody(context));
  }


  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      //AlertDialog bize uyarı penceresi açar
      title: Text("İşlem Sonucu:"),
      content: Text(mesaj),
    );
    //var alert olarak değişken atadığımız için bunu kullanmalıyız

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length, //listemizi çağırdık
                itemBuilder: (BuildContext context, int index) {
                  //listview'ın builder'ı eleman sayısı kadar bu kodu çalıştıracak
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2017/03/21/01/17/asian-2160794_960_720.jpg"),
                    ),
                    title: Text(students[index].firstName +
                        " " +
                        students[index]
                            .lastName), //listedeki ilgili özellikleri hangi kısma yazacağımızı gösterir
                    subtitle: Text("Sınavdan aldığı not : " +
                        students[index].grade.toString() +
                        "[" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index]; //sadece student[index] dememiz yeterli
                      });
                      print(selectedStudent.firstName);
                    },
                  );
                  //Text(students[index].firstName); //buradaki index for dongusundeki sayac gibi ilerliyor, students'dan bir özelliğini isteyecek
                })),
        Text("Seçili öğrenci : " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5.0,),
                    Text("Yeni öğrenci"
                        ""),
                  ],
                ),
                onPressed: () {
                  //Static Push
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAdd(students))); //ilgili context için ilgili ekrana gidecek
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.blueAccent,
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 5.0,), //boşluk oluşturmak için koyulan widget
                    Text("Güncelle"
                        ""),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.amberAccent,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    Text("Sil"
                        ""),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                    //removeAt belirttiğiniz objeyi siler, removeLast sonuncuyu siler, removeWhere belirttiğiniz yeri siler
                  });
                  var mesaj = "Silindi : " + selectedStudent.firstName;
                  mesajGoster(context, mesaj);
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.alarm);
    } else {
      return Icon(Icons.clear);
    }
  }
}
