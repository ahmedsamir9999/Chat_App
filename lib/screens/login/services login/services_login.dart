import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ServicesLogin {
  final auth = FirebaseAuth.instance;
  final googleAuth = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  signIn({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  createWithGoogle() async {
    final createAccount = await googleAuth.signIn();
    final authentication = await createAccount?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );
    final authResult = await auth.signInWithCredential(authCredential);
    final user = authResult.user;
    print(user);
  }
}
