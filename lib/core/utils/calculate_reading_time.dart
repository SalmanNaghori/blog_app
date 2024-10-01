int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTile = wordCount / 225;
  return readingTile.ceil();
}
