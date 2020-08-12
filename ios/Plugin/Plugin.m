#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(BluetoothLEClient, "BluetoothLEClient",
    CAP_PLUGIN_METHOD(connect, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(disableNotifications, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(disconnect, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(discover, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(enable, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(enableNotifications, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(getCharacteristic, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(getCharacteristics, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(getService, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(getServices, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(hasPermissions, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(isAvailable, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(isEnabled, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(read, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(readDescriptor, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(scan, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(write, CAPPluginReturnPromise);
)
