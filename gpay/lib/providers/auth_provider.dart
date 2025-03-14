import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StateProvider<Map<String, String>>((ref) => {
  'email': '',
  'name': '',
  'imageUrl': '',
});
