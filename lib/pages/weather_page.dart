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
  double? temperature;
  int? intTemp;
  String? cityName;
  String? condition;
  int? weatherId;
  double? windSpeed;
  String? imageName = "lib/assets/icons/white.jpg";
  bool isLoading = true;

  //setting values for weather
  Future<void> setWeatherData(String userCityName) async {
    WeatherService weatherService = WeatherService(cityName: userCityName);
    dynamic weatherData = await weatherService
        .getWeatherData(); // await is used to wait for data to be processed before moving ahead

    // setState is used to make changes in the UI
    setState(() {
      weatherId = weatherData["weather"][0]["id"];
      if (weatherId! >= 200 && weatherId! < 400) {
        imageName = "lib/assets/icons/storm.gif";
      } else if (weatherId! >= 500 && weatherId! < 600) {
        imageName = "lib/assets/icons/rain.gif";
      } else if (weatherId! >= 600 && weatherId! < 700) {
        imageName = "lib/assets/icons/snow.gif";
      } else if (weatherId! >= 700 && weatherId! < 800) {
        imageName = "lib/assets/icons/foggy.gif";
      } else if (weatherId! == 800) {
        imageName = "lib/assets/icons/sun.gif";
      } else if (weatherId! > 800) {
        imageName = "lib/assets/icons/clouds.gif";
      } else {
        imageName = "lib/assets/icons/error.gif";
      }
      cityName = userCityName;
      temperature = weatherData['main']['temp'];
      intTemp = temperature!.toInt();
      condition = weatherData['weather'][0]['main'];
      windSpeed = double.parse(weatherData['wind']['speed'].toString());

      isLoading = false;
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
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Weather Now",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          //Search bar and search button in the row
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
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Search City...",
                contentPadding: const EdgeInsets.all(6.0),
                suffixIcon: IconButton(
                  onPressed: () => textController.text = "",
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          cityName ?? "Cannot fetch data",
                          style: GoogleFonts.comfortaa(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        imageName!,
                        height: 180,
                        width: 180,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "$intTemp °C",
                          style: GoogleFonts.comfortaa(
                            color: Colors.black,
                            fontSize: 42,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "$condition ◆ $windSpeed kmph",
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
        ],
      ),
    );
  }
}
