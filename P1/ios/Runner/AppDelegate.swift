import Flutter
import UIKit
import GoogleMaps

GMSServices.provideAPIKey("AIzaSyCuFqiqLNQlXqQuyVb8X3nzXFHRD2srbh4")
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
