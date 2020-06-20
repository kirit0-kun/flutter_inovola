extension DateParsing on String {
  String toEnglishNumbers() {
    return this
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }

  String simplifyAmPm() {
    final march = 'مارس';
    final marchPlaceHolder = 'placeholder';
    return this
        .replaceAll(march, marchPlaceHolder)
        .replaceFirst(' م', ' مساءاً')
        .replaceFirst(' ص', ' صباحاً')
        .replaceAll(marchPlaceHolder, march);
  }
}
