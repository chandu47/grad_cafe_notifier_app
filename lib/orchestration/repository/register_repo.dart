import 'package:grad_cafe_notifier_app/orchestration/model/user.dart';
import 'package:grad_cafe_notifier_app/orchestration/network/register_client.dart';
import 'package:grad_cafe_notifier_app/tools/request_type.dart';
import 'package:grad_cafe_notifier_app/tools/result.dart';
import 'package:http/http.dart';

class RegisterRepo{

  RegisterClient client = RegisterClient(Client());

  Future<Result> registerUser(User user) async{
    try{
      final response = await client.request(requestType: RequestType.POST, param: user.toJson());
      if(response.statusCode == 200){
        return Result<User>.success(User.fromRawJson(response.body));
      } else{
        return Result.error("Register api failed");
      }
    } catch(error){
      return Result.error("Something went wrong");
    }
  }

}