cordova.define("cordova-plugin-gsewallet.GseWallet", function(require, exports, module) {
var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'GseWallet', 'coolMethod', [arg0]);
};

});
