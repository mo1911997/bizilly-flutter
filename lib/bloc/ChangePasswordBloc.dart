import 'package:VeViRe/repositories/Repositories.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc
{
  final repository = Repositories();
  final email = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  final code = BehaviorSubject<String>();
  
  Function get getEmail => email.sink.add;
  Function get getPassword => password.sink.add;
  Function get getCode => code.sink.add;

  Future<String> getEmailAddress() async
  {
    return repository.getUserEmail(email.value);
  }

  Future<String> verifyCode() async
  {
    return repository.verifyCode(email.value,code.value);
  }

  Future<String> changePassword() async
  {
    return repository.changePassword(email.value,password.value);
  }

  void dispose()
  {
    email.close();
    password.close();
    code.close();    
  }
}

final changePasswordBloc = ChangePasswordBloc();