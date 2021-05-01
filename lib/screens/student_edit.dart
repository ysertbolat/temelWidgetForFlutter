import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/validation/student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student selectedStudent; //liste göndermek yerine tek bir öğrenci göndereceğiz
  StudentEdit(Student selectedStudent){
    this.selectedStudent = selectedStudent;
  }
  @override //üzerine yazmak demektir zorunlu override edilebilir yapısı
  State<StatefulWidget> createState() {
    return _StudentEditState(selectedStudent);
  }
}

class _StudentEditState extends State with StudentValidationMixin{
  Student selectedStudent;
  var formKey = GlobalKey<FormState>(); //formun durumu için anahtar ürettik

  _StudentEditState(Student selectedStudent){
    this.selectedStudent = selectedStudent;
  }

  //form yapımız tamamen add ile aynı
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
      initialValue: selectedStudent.firstName,//güncelleme sayfası açıldığında içinde yazacak değerin ne olacağını belirler
      decoration: InputDecoration(labelText: "Öğrenci adı:", hintText: "Yusuf"), //diğer veriler için de bunu yapacağız
      //labelText = kullanıcıyı yönlendirmeye yönellik metin, hintText = ne gireceğini örnek vermek için
      validator: validateFirstName,//validasyon işlemleri burada yaparsınız bunun için ekstra package gereklidir(başka yerlerde de kullanmak için)
      onSaved: (String value){
        selectedStudent.firstName = value; //öğrencimizin adı yazdığımız değer olacak
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Öğrenci soyadı:", hintText: "Sertbolat"),
      validator: validateLastName,
      onSaved: (String value){
        selectedStudent.lastName = value;
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Aldığı not:", hintText: "50"),
      validator: validateGrade,
      onSaved: (String value){
        selectedStudent.grade = int.parse(value); //String alanı integer yaptık
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){//burada diğer methodlara yazdığımız onSaved'ları harekete geçirtmeliyiz(Formlardan yararlanarak)
        if(formKey.currentState.validate()){
          formKey.currentState.save(); //doğrulamayı geçerse kaydet anlamındadır
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() { //yaptığımız işlemleri doğrulamak için
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade);
  }
}