class Helpers {
  static String getMonth(int month, String format) {
    String m = '';
    bool isLong = format == 'M';

    switch (month) {
      case 1:
        m = isLong ? 'January' : 'Jan';
        break;
      case 2:
        m = isLong ? 'Febuary' : 'Feb';
        break;
      case 3:
        m = isLong ? 'March' : 'Mar';
        break;
      case 4:
        m = isLong ? 'April' : 'Apr';
        break;
      case 5:
        m = 'May';
        break;
      case 6:
        m = isLong ? 'June' : 'Jun';
        break;
      case 7:
        m = isLong ? 'July' : 'Jul';
        break;
      case 8:
        m = isLong ? 'August' : 'Aug';
        break;
      case 9:
        m = isLong ? 'September' : 'Sept';
        break;
      case 10:
        m = isLong ? 'October' : 'Oct';
        break;
      case 11:
        m = isLong ? 'November' : 'Nov';
        break;
      case 12:
        m = isLong ? 'December' : 'Dec';
        break;
      default:
    }

    return m;
  }
}
