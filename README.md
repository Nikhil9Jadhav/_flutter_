# contact_list_app

My first flutter project.
(Note the original name and package name of this project is different, as the original name of this project was changed from flutter_todo to contact_list_app)
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Some logical learnings
To break a string into a list. you can use split()
 Example :

To concate the list into a string you can use join()
 Example
 String join(List list, [String separator = ',']) {
    if (list == null) {
      return null;
    }
    return list.join(separator);
  }

Date : 11-12-2020 (Learn how to setup firebase for authentication)
  How to Add Firebase Auth Module

  1) Create a project in firebase.
  2) You can disable google analytics if you want.
  3) Once the project is ready on google fire base.

  4) Choose the add firebase android if you want to configure firebase for android.
  5) Add the proper android package name . 
   > (You can find the package name in "AndroidManifest.xml" which you can find in following path specified...
     android > app > src > main > AndroidManifest.xml)   : For this project its "com.example.contact_list_app"
  6) Next download the google-services.json file.
  7) Save google-services.json file inside android > app folder
  8) Add proper sdks into respective project level and app level gradel files.
  9)After that add the required packages in yml file.
  10) Before testing make sure you have allow authentication at the firebase console.
  
