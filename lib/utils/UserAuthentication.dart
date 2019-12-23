import "package:encrypt/encrypt.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:jaguar_jwt/jaguar_jwt.dart";

setAuthUser([ String token = "", bool remember = false ]) async
{
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    remember = remember || prefs.getBool("69127pigpu9p14ul_remember");

    if(token.isNotEmpty)
    {
        try
        {
			final Map<String, dynamic> user =
			    verifyJwtHS256Signature(token, "5u896p9p14ulnq6912li7pigpuoea1ig")["user"];

            if(remember == true)
            {
				prefs.setString("69127pigpu9p14ul", token);
				prefs.setBool("69127pigpu9p14ul_remember", true);

            }
            else
                print("sessionStorage.removeItem(TOKEN_KEY)");

            return {
                "id": user["id"], "type": user["type"], "name": user["name"], "email": user["email"], "score": user["score"]

            };

        }
        on JwtException catch (err)
        {}

    }
    else
    {
        if(remember)
        {
            prefs.remove("69127pigpu9p14ul");
            prefs.remove("69127pigpu9p14ul_remember");

        }
        else
            print("sessionStorage.removeItem(TOKEN_KEY)");

    }

}

String setAuthPassword(String password)
{
    return Encrypter(AES(Key.fromUtf8("5u896p9p14ulnq6912li7pigpuoea1ig"), mode: AESMode.cbc, padding: "PKCS7"))
        .encrypt(password, iv: IV.fromUtf8("69127pigpu9p14ul")).base64;

}