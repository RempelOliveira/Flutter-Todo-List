import "package:email_validator/email_validator.dart";

Map<String, dynamic> formValidate(Map<String, Map<String, dynamic>> data)
{
    Map<String, dynamic> errors = {};

    data.forEach((String key, dynamic item)
    {
        if(key != "errors")
        {
			String value =
			    data[key]["value"].toString().trim();

			Map<String, dynamic> validation =
			    data[key]["validation"];

            if(validation.isNotEmpty)
            {
                if(validation["required"] == true && value.isEmpty)
                {
                    errors[key] = validation["code"] == true ? "All code fields are required" : "Required";

                }
                else if(validation["surname"] == true && value.indexOf(" ") == -1)
                {
                    errors[key] = "Name and surname must be entered";

                }
                else if(value.isNotEmpty && validation["min"] != null && value.length < validation["min"])
                {
                    errors[key] = "Enter at least ${validation["min"]} characters";

                }
                else if(value.isNotEmpty && validation["max"] != null && value.length > validation["max"])
                {
                    errors[key] = "Enter a maximum of ${validation["max"]} characters";

                }
                else if(validation["email"] == true && EmailValidator.validate(value) != true)
                {
                    errors[key] = "Invalid email address";

                }

            }

        }

    });

    return errors;

}