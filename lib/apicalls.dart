import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vocalpal/apikey.dart';
class apicall{
  final List<Map<String,String>>messages=[];
  Future<String>isart(String prompt)async{
    try {
final res=await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $apikey'
},
body: jsonEncode({
  "model": "gpt-3.5-turbo",
  "messages": [
  {
    "role": "user",
    "content": "Does this prompt want to generate AI image,Arto or anything similar?$prompt,Simply answer this In yes or no"
  },]
}));
print(res.body);
if(res.statusCode==200){
 String content=jsonDecode(res.body)['choices'][0]['message']['content'];
 content=content.trim();

 switch (content) {
   case 'Yes':
   case 'yes':
   case 'Yes.':
   case 'yes.':
     final res = await dalle(prompt);
     return res;
   default:
     print(content);
     final res = await chatgpt(prompt);
     return res;
 }

}return 'an internal error occured';
    }
    catch(e){
return e.toString();
    }
  }
  Future<String>chatgpt(String prompt)async{
    messages.add({
      "role": "user",
      "content":'$prompt'
    });
    try {
      final res=await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apikey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages":
             messages}));

      if(res.statusCode==200){
        String content=jsonDecode(res.body)['choices'][0]['message']['content'];
        content=content.trim();
       messages.add({
      "role": "system",
      "content":'$content'
       });
       return content;
      }
      return 'an internal error occured';


    }
    catch(e){
      return e.toString();
    }
  }
  Future<String>dalle(String prompt)async{
    messages.add({
      "role": "user",
      "content":'$prompt'
    });
    try {
      final res=await http.post(Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apikey'
          },
          body: jsonEncode({
           'prompt':prompt,
          'n':1}));

      if(res.statusCode==200){
        String image=jsonDecode(res.body)["data"][0]["url"];
        image=image.trim();
        messages.add({
          "role": "system",
          "content":'$image'
        });
        return image;
      }
      return 'an internal error occured';


    }
    catch(e){
      return e.toString();
    }
  }


}
