class BaseApi {
  // BaseApi._constructor();
  // static final BaseApi _instance = BaseApi._constructor();
  // static BaseApi get instance => _instance;
  static const baseUrl = "business-api.staging.mrsool.co";
  static const generateOrderToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNjg4In0.xJtM62Hy3SEHJiVpJ5VHYBGsVkvNfER661cF-k9AYUk";
  static const ordersApiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNjg5In0.SXglhFJ2FQKsLOHPFvRiILZdkO9TrkJc8GPQNyQkEEU";

  static final defaultHeaders = {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Content-Type": "application/json",
  };
}
