
import 'dart:collection';

enum TypeToken
{
     webAccess,
     monitorAccess,
     connectAccess,
     remoteAPIAccess
}

class OAuthResult
{
     String token = "";
     String refreshToken = "";
     TypeToken? tokenType;
     DateTime? validToUtc;

     OAuthResult.fromJson(Map<String, dynamic> dataJson)
     {
          LinkedHashMap<String, dynamic> map = new LinkedHashMap(
                  equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
                  hashCode: (key) => key.toLowerCase().hashCode,
          );
          map.addAll(dataJson);
          token = map["token"];
          refreshToken = map["refreshtoken"];
          tokenType = TypeToken.values.firstWhere((element) =>
               element.toString().toLowerCase()=="typetoken."+map["tokentype"]);
          validToUtc = DateTime.parse(map["validtoutc"]);
     }
}
