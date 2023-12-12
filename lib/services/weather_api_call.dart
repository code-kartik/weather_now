import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  String apiKey =
      "fa7ff9c1f890d9e2ab861788a886f310"; // API key given by OpenWeatherApi
  String cityName = "Palo Alto";

  WeatherService({required this.cityName});

  Future<dynamic> getWeatherData() async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric"); // parsing the url to get the data in json format
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var weatherData = jsonDecode(response.body);
      return weatherData;
    } else {
      throw Exception("Can't connect to API");
    }
  }
}
