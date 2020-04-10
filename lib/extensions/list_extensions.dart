extension ListExtensions on List<String> {
  /// Humanize List
  ///
  /// Takes a list of string and makes a human friendly version
  /// ['one'] -> 'one'
  /// ['one', 'two'] -> 'one and two'
  /// ['one', 'two', 'three'] -> 'one, two, and 'three'
  ///
  /// Example
  /// const list = ['one', 'two'];
  /// list.humanize();
  String humanize() {
    if (this == null) {
      throw Exception('Item cannot be null');
    }
    switch (length) {
      case 0:
        return '';
      case 1:
        return first;
      case 2:
        return '$first and $last';
      default:
        final allButLast = sublist(0, length - 1);
        return '${allButLast.join(', ')} and $last';
    }
  }
}
