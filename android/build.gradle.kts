plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace "com.example.qiraati"
    compileSdkVersion 34   // pastikan minimal 33 atau 34

    defaultConfig {
        applicationId "com.example.qiraati"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        multiDexEnabled true
    }

    // ✅ Aktifkan desugaring + Java 8
    compileOptions {
        coreLibraryDesugaringEnabled true
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source "../.."
}

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"

    // ✅ Tambahkan library desugar
    coreLibraryDesugaring "com.android.tools:desugar_jdk_libs:2.0.4"
}
