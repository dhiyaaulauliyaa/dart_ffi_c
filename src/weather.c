double get_temperature()
{
  return 80.0f;
}

struct ThreeDayForecast
{
  double today;
  double tomorrow;
  double day_after;
};

double fahrenheit_to_celsius(double temperature)
{
  return (5.0f / 9.0f) * (temperature - 32);
}

struct ThreeDayForecast get_three_day_forecast(int useCelsius)
{

  struct ThreeDayForecast forecast;
  forecast.today = 87.0f;
  forecast.tomorrow = 88.0f;
  forecast.day_after = 89.0f;

  if (useCelsius == 1)
  {
    forecast.today = fahrenheit_to_celsius(forecast.today);
    forecast.tomorrow = fahrenheit_to_celsius(forecast.tomorrow);
    forecast.day_after = fahrenheit_to_celsius(forecast.day_after);
  }

  return forecast;
}
