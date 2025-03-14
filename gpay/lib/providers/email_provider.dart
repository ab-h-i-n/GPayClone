import 'package:flutter_riverpod/flutter_riverpod.dart';


final emailProvider = StateProvider<Map<String, String>>((ref) => {
  'email': '',
  'name': '',
  'imageUrl': '',
});
