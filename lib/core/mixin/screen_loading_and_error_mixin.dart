import 'package:get/get.dart';

mixin ScreenLoadingAndError {
  final RxBool _isLoading = true.obs;

  final RxnString _error = RxnString();

  void setLoadingTotrue() => _isLoading.value = true;

  void setLoadingToFalse() => _isLoading.value = false;

  void setError(String? errorString) => _error.value = errorString;

  bool get getIsloading => _isLoading.value;

  String? get getError => _error.value;
}
