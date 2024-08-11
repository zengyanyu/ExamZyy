import { http } from '@kit.NetworkKit';
import { promptAction, router } from '@kit.ArkUI';
import { AuthManager } from './AuthManager';

@Entry
@Component
struct LoginPage {
  NUMBER_FLG: number = 60;
  @State
  mobile: string = '19859732425'
  @State
  code: string = '' // 验证码
  @State
  count: number = 60; // 验证码倒计时
  @State
  timer: number = 0;

  // 发送验证码
  sendCode() {
    // 倒计时时间为60秒,并且有手机号
    if (this.count === this.NUMBER_FLG && this.mobile) {
      this.sendHttp();
      // 开始倒计时
      this.beginRun();
    }
  }

  // 开始倒计时
  beginRun() {
    this.timer = setInterval(() => {
      if (this.count === 0) {
        clearInterval(this.timer)
        this.count = this.NUMBER_FLG;
        return
      }
      this.count--;
    }, 1000)
  }

  getBtnEnabled() {
    if (this.mobile && this.code) {
      return true;
    }
    return false;
  }

  async sendHttp() {
    const request = http.createHttp();
    await request.request(`https://toutiao.itheima.net/v1_0/sms/codes/${this.mobile}`)
    promptAction.showToast({ message: '发送验证码成功' })
    // 把请求对象销毁
    request.destroy()
  }

  // 登录操作
  async login() {
    const req = http.createHttp()
    const result = await req.request("https://toutiao.itheima.net/v1_0/authorizations", {
      method: http.RequestMethod.POST,
      header: {
        "Content-Type": "application/json" // 约束传入的body参数为对象类型
      },
      extraData: {
        mobile: this.mobile,
        code: this.code
      }
    })
    req.destroy()

    const res = JSON.parse(result.result as string) as ResponseData<TokenObj>
    promptAction.showToast({ message: res.data!.token })
    new AuthManager().setToken(res.data!.token) // 设置首选项  为了写入磁盘 为了进入判断
    AppStorage.setOrCreate<string>("token", res.data!.token) // 用起来很简单
    // 页面跳转
    router.pushUrl({
      url: 'pages/MainPage'
    })
  }

  build() {
    Column({ space: 20 }) {
      Column() {
        Text('短信登录').fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({
            bottom: 80
          })
      }.width('100%')
      .justifyContent(FlexAlign.Start)

      TextInput({
        placeholder: '请输入手机号',
        // 双向绑定数据
        text: $$this.mobile
      })
      Row({ space: 10 }) {
        TextInput({
          placeholder: '请输入验证码',
          // 双向绑定数据
          text: $$this.code
        })
          .layoutWeight(1)

        Text(this.count === 60 ? '发送验证码' : `还剩${this.count}秒`)
          .onClick(() => {
            // 发送验证码
            this.sendCode();
          })
      }
      .width('100%')

      Button("登录")
        .fontColor(Color.White)
        .fontSize(20)
        .width('100%')
        .type(ButtonType.Normal)
        .backgroundColor('rgb(222, 114, 61)')
        .height(60)
        .borderRadius(5)
        .onClick(() => {
          // 登录操作
          this.login();
        })
        .enabled(this.getBtnEnabled())
    }
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .width('100%')
    .padding(20)
  }
}

class ResponseData<T> {
  data: T | null = null
  message: string = ''
}

class TokenObj {
  token: string = ""
  refresh_token: string = ""
}

