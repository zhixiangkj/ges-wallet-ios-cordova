cordova.define("cordova-plugin-gsewallet.GseWallet", function(require, exports, module) {
  var exec = require('cordova/exec');

  exports.pay = function (params, success, error) {
    const paramsStr = JSON.stringify(params)
    exec((dataStr) => {
      const info = JSON.parse(dataStr)
      success(info)
      }
    , (errStr) => {
      const err = JSON.parse(errStr)
      error(err)
    }, 'GseWallet', 'pay', [paramsStr])
  };
  exports.closeWebView = function (arg0, success, error) {
    exec(success, error, 'GseWallet', 'closeWebView', [arg0]);
  };
  exports.isLocationAuthorized = function (arg0, success, error) {
    exec(success, error, 'GseWallet', 'isLocationAuthorized', [arg0]);
  };
});
