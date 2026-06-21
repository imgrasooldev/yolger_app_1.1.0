import 'package:hyper_local/config/api_base_helper.dart';
import 'package:hyper_local/config/api_routes.dart';
import '../../../services/location/location_service.dart';

class ProductDetailRepository {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<Map<String, dynamic>> fetchProductDetail({required String productSlug}) async {
    try{
      final locationService = LocationService.getStoredLocation();
      final latitude = locationService!.latitude;
      final longitude = locationService.longitude;
      final response = await apiBaseHelper.getAPICall(
        '${ApiRoutes.productDetailApi}$productSlug', {}
      );
      return response.data;
    }catch(e){
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchSimilarProduct({required List<String> excludeProductSlug}) async {
    try{
      final locationService = LocationService.getStoredLocation();
      final latitude = locationService!.latitude;
      final longitude = locationService.longitude;

      String apiUrl = '';
      if(excludeProductSlug.isNotEmpty){
        String excludeParam = excludeProductSlug.join(",");
        apiUrl = '${ApiRoutes.getSimilarProductApi}?exclude_product=$excludeParam';
      } else {
        apiUrl = '${ApiRoutes.getSimilarProductApi}';
      }
      final response = await apiBaseHelper.getAPICall(
          apiUrl,
          {}
      );
      return response.data;
    } catch(e){
      throw ApiException('Failed to fetch similar product');
    }
  }
}