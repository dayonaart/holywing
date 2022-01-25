import 'dart:convert';

import 'package:app/contoller/main_controller.dart';
import 'package:app/model/wrap_response_model.dart';
import 'package:app/widget/loading.dart';
import 'package:app/widget/snack_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

String BASE_URL = 'https://api.jsonbin.io/b/';
String CAROUSEL = "6152c7974a82881d6c56d30c";
String SONG_CHART = "6152c7f6aa02be1d445015a4";
MainController PRO = Provider.of(Get.context!, listen: false);
MainController STATE(BuildContext context) =>
    Provider.of<MainController>(context);
PR(dynamic object) => debugPrint(jsonEncode(object), wrapWidth: 1024);
Future<ConnectivityResult> checkNetwork() async {
  return await (Connectivity().checkConnectivity());
}

class Api {
  BaseOptions _baseDioOption({
    String? customBaseUrl,
  }) =>
      BaseOptions(connectTimeout: 60000, baseUrl: customBaseUrl ?? BASE_URL);
  String? _unknowError(dynamic error) {
    try {
      return error['message'];
    } catch (e) {
      return null;
    }
  }

  Future<WrapResponse?> POST(
    String url,
    dynamic body, {
    bool useLoading = true,
    bool useToken = false,
    bool useSnackbar = true,
    Map<String, String>? customHeader,
    String? customBaseUrl,
  }) async {
    // check user networt
    var _net = await checkNetwork();

    try {
      useLoading ? Loading.show() : null;
      var _execute = Dio(_baseDioOption(customBaseUrl: customBaseUrl)).post(url,
          data: body,
          // calculate receiving data progresss
          onReceiveProgress: (int sent, int total) =>
              PRO.onReceiveProgresss(sent, total),
          // calculate send data progresss
          onSendProgress: (int sent, int total) =>
              PRO.onSendProgresss(sent, total),
          // Header
          options: Options(
              headers: (useToken
                  ? {
                      "Content-Type": 'application/json',
                      // "Authorization": "Bearer ${PRO.userData?.token}",
                    }
                  : {
                      "Content-Type": 'application/json',
                    })));
      // Execute
      var _res = await _execute;
      Loading.hide();
      return WrapResponse(
          message: _res.statusMessage,
          statusCode: _res.statusCode,
          data: _res.data);
    } on DioError catch (e) {
      Loading.hide();
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 401) {
          useSnackbar
              ? ERROR_SNACK_BAR("${e.response?.statusCode}",
                  _unknowError(e.response?.data) ?? e.response?.statusMessage)
              : null;
          // PRO.clearAllData();
          return null;
        } else if (e.response!.statusCode! >= 400 &&
            e.response!.statusCode! != 401) {
          useSnackbar
              ? ERROR_SNACK_BAR("${e.response?.statusCode}",
                  _unknowError(e.response?.data) ?? e.response?.statusMessage)
              : null;
          return WrapResponse(
              message: e.response?.statusMessage ?? e.message,
              statusCode: e.response?.statusCode ?? 0,
              data: e.response?.data);
        } else {
          useSnackbar
              ? ERROR_SNACK_BAR(
                  '${e.response?.statusCode}', e.response?.statusMessage)
              : null;
          return WrapResponse(
              message: e.response?.statusMessage ?? e.message,
              statusCode: e.response?.statusCode ?? 0,
              data: e.response?.data);
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        useSnackbar
            ? ERROR_SNACK_BAR("Perhatian", "Koneksi tidak stabil")
            : null;
        return WrapResponse(
            message: "connection timeout",
            statusCode: e.response?.statusCode ?? 0);
      } else if (_net == ConnectivityResult.none) {
        ERROR_SNACK_BAR("Perhatian", "Pastikan Anda terhubung ke Internet");
        return WrapResponse(message: "connection timeout", statusCode: 000);
      } else {
        ERROR_SNACK_BAR("Perhatian", "Terjadi Kesalahan");
        return WrapResponse(message: "connection timeout", statusCode: 999);
      }
    }
  }

  Future<WrapResponse?> PUT(
    String url,
    dynamic body, {
    bool useLoading = true,
    bool useToken = false,
    bool useSnackbar = true,
  }) async {
    var _net = await checkNetwork();
    try {
      useLoading ? Loading.show() : null;
      var _execute = Dio(_baseDioOption()).put(url,
          data: body,
          // onReceiveProgress: (int sent, int total) => PRO.onSendProgress(sent, total),
          // onSendProgress: (int sent, int total) => PRO.onSendProgress(sent, total),
          options: Options(
              headers: useToken
                  ? {
                      "Content-Type": 'application/json',
                      // "Authorization": "Bearer ${PRO.userData?.token}",
                      'Accept': 'application/json'
                    }
                  : {
                      "Content-Type": 'application/json',
                    }));
      var _res = await _execute;
      Loading.hide();
      return WrapResponse(
          message: _res.statusMessage,
          statusCode: _res.statusCode,
          data: _res.data);
    } on DioError catch (e) {
      // print(e.requestOptions.data);
      Loading.hide();
      ERROR_SNACK_BAR("ERROR", "${e.response?.data}");
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode! == 401) {
          useSnackbar
              ? ERROR_SNACK_BAR(
                  "${e.response?.statusCode}", e.response?.statusMessage)
              : null;
          // PRO.clearAllData();
          return null;
        } else if (e.response!.statusCode! >= 400 &&
            e.response!.statusCode! != 401) {
          useSnackbar
              ? ERROR_SNACK_BAR("${e.response?.statusCode}",
                  _unknowError(e.response?.data) ?? e.response?.statusMessage)
              : null;
          return WrapResponse(
              message: e.response?.statusMessage ?? e.message,
              statusCode: e.response?.statusCode ?? 0,
              data: e.response?.data);
        } else {
          useSnackbar
              ? ERROR_SNACK_BAR("${e.response?.statusCode}",
                  _unknowError(e.response?.data) ?? e.response?.statusMessage)
              : null;
          return WrapResponse(
              message: e.response?.statusMessage ?? e.message,
              statusCode: e.response?.statusCode ?? 0,
              data: e.response?.data);
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        useSnackbar
            ? ERROR_SNACK_BAR("Perhatian", "Koneksi tidak stabil")
            : null;
        return WrapResponse(
            message: "connection timeout",
            statusCode: e.response?.statusCode ?? 0);
      } else if (_net == ConnectivityResult.none) {
        ERROR_SNACK_BAR("Perhatian", "Pastikan Anda terhubung ke Internet");
        return WrapResponse(message: "connection timeout", statusCode: 000);
      } else {
        ERROR_SNACK_BAR("Perhatian", "Terjadi Kesalahan");
        return WrapResponse(message: "connection timeout", statusCode: 999);
      }
    }
  }

  Future<WrapResponse?> GET(
    String url, {
    bool useLoading = true,
    bool useToken = false,
    bool useSnackbar = true,
    String? customBaseUrl,
  }) async {
    var _net = await checkNetwork();
    try {
      useLoading ? Loading.show() : null;
      var _execute = Dio(_baseDioOption(customBaseUrl: customBaseUrl)).get(url,
          onReceiveProgress: (int sent, int total) =>
              PRO.onReceiveProgresss(sent, total),
          options: Options(
              headers: useToken
                  ? {
                      "Content-Type": 'application/json',
                      // "Authorization": "Bearer ${PRO.userData?.token}",
                    }
                  : {
                      "Content-Type": 'application/json',
                    }));
      var _res = await _execute;
      Loading.hide();
      return WrapResponse(
          message: _res.statusMessage,
          statusCode: _res.statusCode,
          data: _res.data);
    } on DioError catch (e) {
      Loading.hide();
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode! == 401) {
          useSnackbar
              ? ERROR_SNACK_BAR(
                  "${e.response?.statusCode}", e.response?.statusMessage)
              : null;
          // await PRO.clearAllData();
          return null;
        } else if (e.response!.statusCode! >= 400 &&
            e.response!.statusCode! != 401) {
          useSnackbar
              ? ERROR_SNACK_BAR("${e.response?.statusCode}",
                  _unknowError(e.response?.data) ?? e.response?.statusMessage)
              : null;
          return WrapResponse(
              message: e.response?.statusMessage ?? e.message,
              statusCode: e.response?.statusCode ?? 0,
              data: e.response?.data);
        } else {
          useSnackbar
              ? ERROR_SNACK_BAR("${e.response?.statusCode}",
                  _unknowError(e.response?.data) ?? e.response?.statusMessage)
              : null;
          return WrapResponse(
              message: e.response?.statusMessage ?? e.message,
              statusCode: e.response?.statusCode ?? 0,
              data: e.response?.data);
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        useSnackbar
            ? ERROR_SNACK_BAR("Perhatian", "Koneksi tidak stabil")
            : null;
        return WrapResponse(
            message: "connection timeout",
            statusCode: e.response?.statusCode ?? 0);
      } else if (_net == ConnectivityResult.none) {
        ERROR_SNACK_BAR("Perhatian", "Pastikan Anda terhubung ke Internet");
        return WrapResponse(message: "connection timeout", statusCode: 000);
      } else {
        ERROR_SNACK_BAR("Perhatian", "Terjadi Kesalahan");
        return WrapResponse(message: "connection timeout", statusCode: 999);
      }
    }
  }
}
