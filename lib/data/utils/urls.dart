class Urls {
  static const String _apiKey = "SLyAJylyh/o3ww6K/Wp85Q==xc62IAl4ZCkw8Pks";
  static const String _baseUrl = "https://api.api-ninjas.com/v1";
  // static const String recipes = "$_baseUrl/recipe?X-Api-Key=$_apiKey";
  static const String recipes = "https://dummyjson.com/recipes";
  static String query(String? quary) =>
      "$_baseUrl/recipe?query=$quary&X-Api-Key=$_apiKey";

  static const String videoApi =
      "https://docs.google.com/spreadsheets/d/e/2PACX-1vS1GSZ06EqKcHxCOm3_KiOAvocx3Vtc-iKZIb7z_fW7m2YhEX5IQBbM_BfPb2ZrI537b6y0NwEaRo-q/pub?output=csv";
}
