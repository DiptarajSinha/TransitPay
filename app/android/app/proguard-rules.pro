## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

## Stripe
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

## Supabase / GoTrue / Postgrest
-keep class io.github.jan.supabase.** { *; }
-keep class io.ktor.** { *; }
-dontwarn io.ktor.**
-dontwarn kotlinx.serialization.**

## Isar
-keep class net.simonvandi.** { *; }

## AndroidX / Google Play
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
