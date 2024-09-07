# Flutter and Dart
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.iid.** { *; }
-keep class com.google.firebase.crashlytics.** { *; }

# Play Services
-keep class com.google.android.gms.** { *; }
-keep interface com.google.android.gms.** { *; }

# Gson
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken
-keepattributes Signature
-keepattributes *Annotation*

# Retrofit and OkHttp
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }
-keep class com.google.gson.** { *; }

# Firebase Firestore (if using Firestore)
-keep class com.google.firestore.** { *; }
-keepclassmembers class * {
    @com.google.firebase.database.PropertyName <methods>;
}
-keepnames @com.google.firebase.firestore.PropertyName class *

# Firebase Authentication (if using Authentication)
-keep class com.google.firebase.auth.** { *; }
-keepattributes Exceptions, InnerClasses

# Firebase Analytics (if using Analytics)
-keep class com.google.firebase.analytics.** { *; }

# Optional: Keep your app's model classes (if they are being removed)
-keep class com.example.volt.model.** { *; }

# Recommended: Prevent stripping out support annotations (useful for UI)
-dontwarn android.support.**
-keep class android.support.annotation.** { *; }
-keep interface android.support.annotation.** { *; }

# General settings to avoid removing code or resources used dynamically
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep class * extends android.app.Activity
-keep class * extends android.app.Application
-keep class * extends android.app.Service
-keep class * extends android.content.BroadcastReceiver
-keep class * extends android.content.ContentProvider
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keepclassmembers class * {
    @androidx.webkit.JavascriptInterface <methods>;
}
-keepclassmembers class * {
    @android.annotation.JavascriptInterface <methods>;
}

# For R8, enable optimizations and reduce APK size
# You can uncomment these for further optimization, but be careful as it might strip out necessary code.
# -optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
# -allowaccessmodification
# Firebase specific ProGuard rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Keep classes used for serialization/deserialization
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}