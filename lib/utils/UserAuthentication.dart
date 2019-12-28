import "package:encrypt/encrypt.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:jaguar_jwt/jaguar_jwt.dart";

setAuthUser([ String token = "", bool remember = false ]) async
{
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    remember = remember || prefs.getBool("69127pigpu9p14ul_remember") == true;

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

            return {
                "id": user["id"], "type": user["type"], "name": user["name"], "email": user["email"], "score": user["score"]

            };

        }
        on JwtException catch (_){ return; }

    }
    else
    {
        if(remember)
        {
            prefs.remove("69127pigpu9p14ul");
            prefs.remove("69127pigpu9p14ul_remember");

        }

    }

    return;

}

getAuthUser([ bool getToken = false, String token = "" ]) async
{
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

	token = prefs.getBool("69127pigpu9p14ul_remember") == true ? prefs.getString("69127pigpu9p14ul") : token;

	if(token.isNotEmpty)
	{
		if(!getToken)
		{
			try
			{
                final Map<String, dynamic> user =
                    verifyJwtHS256Signature(token, "5u896p9p14ulnq6912li7pigpuoea1ig")["user"];

                return {
                    "id": user["id"], "type": user["type"], "name": user["name"], "email": user["email"], "score": user["score"]

                };

			}
			catch (err)
			{
				return setAuthUser();

			}

		}
		else
			return "Bearer " + token;

	}

	return "";

}

String setAuthPassword(String password)
{
    return Encrypter(AES(Key.fromUtf8("5u896p9p14ulnq6912li7pigpuoea1ig"), mode: AESMode.cbc, padding: "PKCS7"))
        .encrypt(password, iv: IV.fromUtf8("69127pigpu9p14ul")).base64;

}