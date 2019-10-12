<template>
  <div id="app">
    <!--<router-view/>-->
    <button @click="useScanner">{{this.isScanning ? '关闭扫码' : '开始扫码'}}</button>
    <button @click="lightOn">
      {{this.isLightOn ? '关灯' : '开灯'}}
    </button>
    <button @click="useGeolocation">
      {{this.isLocating ? '关闭定位' : '开始定位'}}</button>
    <div class="result" v-if="qrcodeStr">
      <h3>扫码结果</h3>
      <h5>{{qrcodeStr}}</h5>
    </div>
    <ul v-if="paths && paths.length > 0" class="path-list">
      <li
        :key="index"
        v-for="(item, index) in paths">
        <div>
          {{item.coords.latitude}}
        </div>
        <div>
          {{item.coords.longitude}}
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
// 节流函数: 防止函数高频调用
export const throttle = (func, time = 300) => {
  let canRun = true
  return (data) => {
    if (!canRun) return
    func(data)
    canRun = false
    setTimeout(function () {
      canRun = true
    }, time)
  }
}
export default {
  name: 'App',
  data () {
    return {
      canRun: true,
      isLightOn: false,
      isScanning: false,
      isLocating: false,
      watchID: null,
      qrcodeStr: null,
      paths: []
    }
  },
  watch: {
    paths (v) {
      console.log(v)
    }
  },
  methods: {
    // 扫码
    useScanner () {
      if (this.isScanning) {
        window.QRScanner.cancelScan((status) => {
          console.log(status)
          this.isScanning = false
        })
        // window.QRScanner.hide((status) => {
        //   console.log(status)
        // })
        // window.QRScanner.pausePreview((status) => {
        //   console.log(23333)
        //   console.log(status)
        //   this.isScanning = false
        // })
        return
      }
      const displayContents = (err, text) => {
        console.log(err, text)
        if (err) {
          // an error occurred, or the scan was canceled (error code `6`)
        } else {
          this.qrcodeStr = text
          // The scan completed, display the contents of the QR code:
          setTimeout(() => {
            this.qrcodeStr = ''
            window.QRScanner.scan(displayContents)
          }, 3000)
        }
      }
      window.QRScanner.scan(displayContents)
      // Make the webview transparent so the video preview is visible behind it.
      window.QRScanner.show((result) => {
        console.log(result)
        this.isScanning = true
      })
    },
    // 开灯
    lightOn () {
      if (this.isLightOn) {
        window.QRScanner.disableLight((err) => {
          if (!err) {
            this.isLightOn = false
          }
        })
      } else {
        window.QRScanner.enableLight((err) => {
          if (!err) {
            this.isLightOn = true
          }
        })
      }
    },
    // 实时定位
    useGeolocation () {
      if (this.isLocating) {
        this.isLocating = false
        this.paths = []
        if (this.watchID) navigator.geolocation.clearWatch(this.watchID)
        return
      }
      const options = {}
      const onSuccess = (result) => {
        this.isLocating = true
        this.paths.push(result)
      }
      const onError = (err) => {
        if (err.code === 1) {
          alert(err.message || '应用没有定位权限')
        } else {
          alert(err.message)
        }

        console.error(err)
      }
      this.watchID = navigator.geolocation.watchPosition(throttle(onSuccess), throttle(onError), options)
    }
  }
}
</script>

<style lang="less">
  html, body, #app{
    background-color: rgba(0, 0, 0, 0);
  }
  html, body{
    height: 100%;
  }
  body {
    margin: 0;
    display: flex;
    flex-direction: column;
  }
  ul{
    list-style: none;
    margin: 0;
    padding: 0;
  }
  h1, h2, h3, h4, h5, h6{
    margin: 0;
  }
#app {
  text-align: center;
  position: relative;
  flex: 1;
  padding-top: 60px;
  padding-left: 160px;
  .result{
    margin-top: 20px;
    background-color: #eee;
    padding: 10px 0;
  }
  .path-list{
    position: absolute;
    background-color: #eee;
    left: 0;
    top: 0;
    height: 100%;
    width: 160px;
    overflow: auto;
    li{
      background-color: #fff;
      margin-bottom: 10px;
      padding: 10px 0;
    }
  }
}
</style>
