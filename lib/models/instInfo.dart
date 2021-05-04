class InstInfo{
  String instId;
  String instName;
  String courseName;
  String season;
  String degree;

  InstInfo(
      this.instId, this.instName, this.courseName, this.season, this.degree);


  bool get isNotEmpty => instName.isNotEmpty && courseName.isNotEmpty && season.isNotEmpty && degree.isNotEmpty;
}