enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

extension StringFormatting on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return '';
    }
    return this[0].toUpperCase() + substring(1);
  }
}
