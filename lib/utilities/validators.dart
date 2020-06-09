class Validate{
  static bool email(String email){
    if((email.isEmpty)||(!email.contains('@'))){
      return false;
    }
    return true;
  }
  static bool password(String pass){
    if((pass.isEmpty)&&(pass.length<=4)){
      return false;
    }
    return true;
  }
}