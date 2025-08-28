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
        minSdk = flutter.minSdkVersion
        targetSdk = 34

        // Baca dari local.properties
        versionCode = project.findProperty("flutter.versionCode")?.toString()?.toIntOrNull() ?: 1
        versionName = project.findProperty("flutter.versionName")?.toString() ?: "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
}
