# flutter_todo

My first flutter project.

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
