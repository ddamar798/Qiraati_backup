plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.qiraati"
    compileSdk = 34

    defaultConfig {
    applicationId = "com.example.qiraati"
    minSdk = 21
    targetSdk = 34

    val flutterVersionCode = project.findProperty("flutter.versionCode") as? String ?: "1"
    val flutterVersionName = project.findProperty("flutter.versionName") as? String ?: "1.0"

    versionCode = flutterVersionCode.toInt()
    versionName = flutterVersionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    // Jika kamu tidak pakai multidex, hapus baris multiDexEnabled
    // Tapi jika target SDK 34+, biasanya tidak perlu
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    // Hanya tambahkan jika kamu benar-benar pakai multidex
    // implementation("androidx.multidex:multidex:2.0.1")
}