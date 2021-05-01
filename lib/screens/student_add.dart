import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/validation/student_validator.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;
  StudentAdd(List<Student> students){
    this.students = students;
  }
  @override //üzerine yazmak demektir zorunlu override edilebilir yapısı
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin{
  List<Student> students;
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>(); //formun durumu için anahtar ürettik

  _StudentAddState(List<Student> students){
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni öğrenci ekle"),
      ),
      body: Container(//bir şeyi içermek için kullanılır
        margin: EdgeInsets.all(20.0),
        //margin = container'ın elementle olan uzaklığını belirler EdgeInsets = bizim kenarlardan boşluk bırakmamızı sağlar padding = elemanların container'a olan uzaklığını belirler
        //all yerine only dersek belli yerden boşluk bırakır o yeri top:20.0, right:20.0 şeklinde belirtiriz(paddingde de bu vardır)
        child: Form(//form kısmımızı oluşturduk
          key: formKey,
          child: Column(//mobillerde kısıtlı büyüklük olduğu için Column'dan yararlanırız
            children: <Widget>[
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(//Formlar için Giriş yapılabilecek widget
      decoration: InputDecoration(labelText: "Öğrenci adı:", hintText: "Yusuf"), //diğer veriler için de bunu yapacağız
      //labelText = kullanıcıyı yönlendirmeye yönellik metin, hintText = ne gireceğini örnek vermek için
      validator: validateFirstName,//validasyon işlemleri burada yaparsınız bunun için ekstra package gereklidir(başka yerlerde de kullanmak için)
      onSaved: (String value){
        student.firstName = value; //öğrencimizin adı yazdığımız değer olacak
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci soyadı:", hintText: "Sertbolat"),
      validator: validateLastName,
      onSaved: (String value){
        student.lastName = value;
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı not:", hintText: "50"),
      validator: validateGrade,
      onSaved: (String value){
        student.grade = int.parse(value); //String alanı integer yaptık
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){//burada diğer methodlara yazdığımız onSaved'ları harekete geçirtmeliyiz(Formlardan yararlanarak)
        if(formKey.currentState.validate()){
          formKey.currentState.save(); //doğrulamayı geçerse kaydet anlamındadır
          students.add(student);
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() { //yaptığımız işlemleri doğrulamak için
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }
}
