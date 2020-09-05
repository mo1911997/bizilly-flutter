import 'package:VeViRe/repositories/Repositories.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc 
{
  final repository = Repositories();
  final email = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();

  Function get getEmail => email.sink.add;
  Function get getPassword => password.sink.add;

  Future<String> checkLogin()
  {
    return repository.checkLogin(email.value, password.value);
  }
  void dispose()
  {
    email.close();
    password.close();
  }
}

final loginBloc = LoginBloc();