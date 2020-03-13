# image_upload

An app to demonstrate image upload to firebase and storage of the download url to cloud firestore.

## Getting Started

To use this project, set up a firebase app with cloud firestore and a storage bucket. Then, register the app with the appropriate package name (Default = me.chrisicaudill.image_upload) and place the google-services.json file in the appropriate location.

You will also need to change the storage bucket URL in image_capture.dart's _storage variable to the URL of your storage bucket.

## Firebase Settings:

In 'Authentication', enable anonymous sign in.

Adjust database and storage rules to either allow reading and writing from all sources, or just from authenticated sources.

Security Rules Docs: https://firebase.google.com/docs/rules/get-started?authuser=0