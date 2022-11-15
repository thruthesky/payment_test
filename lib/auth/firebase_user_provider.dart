import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PaymentTestFirebaseUser {
  PaymentTestFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

PaymentTestFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PaymentTestFirebaseUser> paymentTestFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<PaymentTestFirebaseUser>(
      (user) {
        currentUser = PaymentTestFirebaseUser(user);
        return currentUser!;
      },
    );
