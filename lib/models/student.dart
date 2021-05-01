class Student{
  int id;
  String firstName;
  String lastName;
  int grade;
  String _status;

  Student.withId(int id, String firstName, String lastName, int grade){
    this.id = id; //güncelleme ve silme gibi operasyonlarda kullanacağız
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  //ekleme için named constructor yapıyoruz
  Student(String firstName, String lastName, int grade){
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }

  Student.withoutInfo(){

  }

  String get getFirstName{
    return "OGR - " + this.firstName;
  }

  void set setFirstName(String value){//firstName String olduğu için String verdik int de verilebilir
    //burda validasyon işlemleri yapabilirsiniz
    this.firstName = value;
  }

  //asıl işimiz burada
  String get getStatus{
    String message = "";
    if (this.grade >= 50) {
      message = "Geçti!";
    } else if (this.grade >= 40) {
      message = "Bütünlemeye kaldı!";
    } else {
      message = "Kaldı!";
    }
    return message;
  }
}