import 'dart:ffi';
import 'dart:io';

typedef TemperatureFunction = Double Function();
typedef TemperatureFunctionDart = double Function();

base class ThreeDayForecast extends Struct {
  @Double()
  external double get today;
  external set today(double value);

  @Double()
  external double get tomorrow;
  external set tomorrow(double value);

  @Double()
  external double get dayAfter;
  external set dayAfter(double value);

  @override
  String toString() {
    return 'Today : ${today.toStringAsFixed(1)}\n'
        'Tomorrow : ${tomorrow.toStringAsFixed(1)}\n'
        'Day After ${dayAfter.toStringAsFixed(1)}';
  }
}

typedef ThreeDayForecastFunction = ThreeDayForecast Function(
  Uint8 useCelsius,
);
typedef ThreeDayForecastFunctionDart = ThreeDayForecast Function(
  int useCelsius,
);

class FFIBridge {
  late TemperatureFunctionDart _getTemperature;
  late ThreeDayForecastFunctionDart _getThreeDayForecast;

  FFIBridge() {
    final dl = Platform.isAndroid
        ? DynamicLibrary.open('libweather.so')
        : DynamicLibrary.process();

    _getTemperature =
        dl.lookupFunction<TemperatureFunction, TemperatureFunctionDart>(
      'get_temperature',
    );

    _getThreeDayForecast = dl
        .lookupFunction<ThreeDayForecastFunction, ThreeDayForecastFunctionDart>(
      'get_three_day_forecast',
    );
  }

  double getTemperature() => _getTemperature();
  ThreeDayForecast getThreeDayForecast(bool useCelcius) =>
      _getThreeDayForecast(useCelcius ? 1 : 0);
}
