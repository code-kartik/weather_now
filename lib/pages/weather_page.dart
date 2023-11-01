import 'package:flutter/material.dart';
import 'package:weather_now/services/weather_api_call.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var textController = TextEditingController();
  double temperature = 0;
  int intTemp = 0;
  late String cityName = "City";
  late String condition = '';

  Future<void> setWeatherData(String userCityName) async {
    WeatherService weatherService = WeatherService(cityName: cityName);
    dynamic weatherData = await weatherService.getWeatherData();
    setState(() {
      cityName = userCityName;
      temperature = weatherData['main']['temp'];
      intTemp = temperature.toInt();
      condition = weatherData['weather'][0]['main'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              //Search City Name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    setWeatherData(value);
                  },
                  controller: textController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    hintText: "Search City...",
                    contentPadding: const EdgeInsets.all(6.0),
                    suffixIcon: IconButton(
                      onPressed: () => textController.text = "",
                      icon: const Icon(Icons.close),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cityName,
                  style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Image.asset(
                'lib/assets/icons/clouds.gif',
                height: 80,
                width: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$intTemp °C",
                  style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontSize: 42,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  condition,
                  style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
