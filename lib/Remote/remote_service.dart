import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Utils/helper_methods.dart';
import '../main.dart';
import 'api_config.dart';
import 'app_exceptions.dart';

class RemoteService {
  Future<http.Response?> callGetApi({
    required String url,
    bool? isUseBaseUrl = true,
  }) async {
    http.Response? responseJson;
    try {
      var urlValue = "";
      if (isUseBaseUrl == true) {
        urlValue = '$BASE_URL$url';
      } else {
        urlValue = url;
      }

      final response =
          await http.get(Uri.parse(urlValue), headers: <String, String>{
        'Content-Type': 'application/json',
      });
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      throw FetchDataException('No Internet connection'+exception.message);
    } catch (e) {
      log(e.toString());
    }
    log(responseJson!.body.toString());
    return responseJson;
  }

  Future<http.Response?> callPostApi({
    required String url,
    required Map<String, dynamic> jsonData,
  }) async {
    http.Response? responseJson;
    try {
      final response = await http.post(Uri.parse('$BASE_URL$url'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(jsonData));

      // print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message: exception.message.toString());
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message:
              '${exceptionData['message'].toString()} ${exceptionData['status'].toString()}');
    }
    log('Api Url : $BASE_URL$url');
    log('Api request : $jsonData');
    return responseJson;
  }

  Future<http.Response?> callMultipartApi({
    required String url,
    required Map<String, String> requestBody,
    File? file,
    String? fileParamName,
    String? requestName,
  }) async {
    http.Response? responseJson;

    var request =
        http.MultipartRequest(requestName ?? 'POST', Uri.parse(BASE_URL + url));
    request.headers.addAll(<String, String>{
      'Content-Type': 'multipart/form-data',
    });
    if (fileParamName != null && file != null) {
      request.files.add(http.MultipartFile(
          fileParamName, file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split("/").last));
    }
    request.fields.addAll(requestBody);
    try {
      final response = await http.Response.fromStream(await request.send());
      responseJson = _returnResponse(response);
    } on SocketException catch (exception) {
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message: exception.message.toString());
    } catch (e) {
      log('main catch error $e');
      final exceptionData = jsonDecode(e.toString());
      showSnackBar(
          context: navigatorKey!.currentContext,
          isSuccess: false,
          message:
              '${exceptionData['message'].toString()} ${exceptionData['status'].toString()}');
    }
    log('Api Url : $BASE_URL$url');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        return response;
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        return response;
      case 409:
        return response;
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
