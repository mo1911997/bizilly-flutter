import 'package:VeViRe/repositories/Repositories.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationBloc {
  final repository = Repositories();

  final name = BehaviorSubject<String>();
  final code = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();

  Function get getName => name.sink.add;
  Function get getCode => code.sink.add;

  Function get getEmail => email.sink.add;
  Function get getPassword => password.sink.add;

  Future<String> registerUser() {
    return repository.registerUser(name.value, email.value, password.value);
  }

  Future<String> verifyEmail() {
    return repository.verifyEmail(email.value, code.value);
  }

  void dispose() {
    name.close();
    email.close();
    code.close();
    password.close();
  }
}

final registrationBloc = RegistrationBloc();
