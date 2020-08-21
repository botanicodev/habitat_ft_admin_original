import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxString _emailStream = ''.obs;
  RxString _passwordStream = ''.obs;
  RxBool _isLoadingStream;

  RxString get emailStream => _emailStream;
  RxString get passwordStream => _passwordStream;
  RxBool get isLoadingStream => _isLoadingStream;

  @override
  void onStart() {
    super.onStart();
    _isLoadingStream = false.obs;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      _isLoadingStream.value = true;
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return result.user;
    } catch (e) {
      print(e);
      _isLoadingStream.value = false;
      return null;
    }
  }
}
