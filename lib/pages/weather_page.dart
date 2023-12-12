import 'package:flutter/material.dart';
import 'package:weather_now/services/weather_api_call.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // declaring variables
  var textController =
      TextEditingController(); // text editing controller to control text given in text field
  double temperature = 0;
  int intTemp = 0;
  late String cityName = "City";
  late String condition = '';
  late int weatherId = 0;
  late int windSpeed = 0;
  late String imageName = "lib/assets/icons/white.jpg";

  //setting values for weather
  Future<void> setWeatherData(String userCityName) async {
    WeatherService weatherService = WeatherService(cityName: cityName);
    dynamic weatherData = await weatherService.getWeatherData();
    setState(() {
      weatherId = weatherData["weather"][0]["id"];
      if (weatherId >= 200 && weatherId < 400) {
        imageName = "lib/assets/icons/storm.gif";
      } else if (weatherId >= 500 && weatherId < 600) {
        imageName = "lib/assets/icons/rain.gif";
      } else if (weatherId >= 600 && weatherId < 700) {
        imageName = "lib/assets/icons/snow.gif";
      } else if (weatherId >= 700 && weatherId < 800) {
        imageName = "lib/assets/icons/foggy.gif";
      } else if (weatherId == 800) {
        imageName = "lib/assets/icons/sun.gif";
      } else if (weatherId > 800) {
        imageName = "lib/assets/icons/clouds.gif";
      } else {
        imageName = "lib/assets/icons/error.gif";
      }
      cityName = userCityName;
      temperature = weatherData['main']['temp'];
      intTemp = temperature.toInt();
      condition = weatherData['weather'][0]['main'];
      windSpeed = weatherData['wind']['speed'];
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Search City Name widget
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  setWeatherData(
                      value); // when tapping done, setWeatherData is called and values are set
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
              imageName,
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
                "$condition ⋄ $windSpeed kmph",
                style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
