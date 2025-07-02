import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  static final  apiKey = dotenv.env['PEXELS_API_KEY']?? '';
}


