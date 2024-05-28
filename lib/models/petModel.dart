class Pet {
  late String name;
  late String image;
  late String gender;
  late int age;
  late String healthCondition;
  late String report;
  late String funfact;

  Pet(this.name, this.image, this.gender, this.age, this.healthCondition,
      this.report, this.funfact);

// Getters
  String getName() {
    return name;
  }

  String getImage() {
    return image;
  }

  String getGender() {
    return gender;
  }

  int getAge() {
    return age;
  }

  String getHealthCondition() {
    return healthCondition;
  }

  String getReport() {
    return report;
  }

  String getFunfact() {
    return funfact;
  }
}
