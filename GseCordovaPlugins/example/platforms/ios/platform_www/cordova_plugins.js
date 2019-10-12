cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
  {
    "id": "cordova-plugin-gsepay.GsePay",
    "file": "plugins/cordova-plugin-gsepay/www/GsePay.js",
    "pluginId": "cordova-plugin-gsepay",
    "clobbers": [
      "cordova.plugins.GsePay"
    ]
  },
  {
    "id": "cordova-plugin-gsewallet.GseWallet",
    "file": "plugins/cordova-plugin-gsewallet/www/GseWallet.js",
    "pluginId": "cordova-plugin-gsewallet",
    "clobbers": [
      "GseWallet"
    ]
  }
];
module.exports.metadata = 
// TOP OF METADATA
{
  "cordova-plugin-whitelist": "1.3.3",
  "cordova-plugin-gsepay": "0.0.1",
  "cordova-plugin-gsewallet": "0.0.1"
};
// BOTTOM OF METADATA
});