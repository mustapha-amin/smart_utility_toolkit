abstract final class GreetingUtils {
  static String getGreeting() {
    final hour = DateTime.now().hour;
    return switch (hour) {
      >= 5 && < 12 => 'Good morning 🌅',
      >= 12 && < 17 => 'Good afternoon 🕑',
      >= 17 && < 21 => 'Good evening 🌆',
      _ => 'Good night 🌃',
    };
  }
}
