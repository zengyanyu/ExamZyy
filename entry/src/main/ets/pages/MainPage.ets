// 主页
import { http } from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct MainPage {
  // 定位到我的
  @State currentIndex: number = 3;

  // 生命周期初始化函数
  aboutToAppear() {
    this.getHttpInfo()
  }

  // 获取所有频道
  async getHttpInfo() {
    const req = http.createHttp();
    const result = await req.request('https://toutiao.itheima.net/v1_0/channels');
    const res = JSON.parse(result.result + "") as ObjectInfo

    // console.log("rs.data = " + JSON.stringify(res.data));
    // const r = JSON.parse(res.data + "") as ObjectInfos


    // const r = JSON.parse(res.data + "") as Channels[]
    //const channels = res.channels;
    console.log("result_" + r);

    // AlertDialog.show({
    //   message: r + ""
    // })
    // console.log("result_" + r);
  }

  build() {
    Tabs({
      // 位置设置为下方
      barPosition: BarPosition.End,
      // 实现双向绑定
      index: $$this.currentIndex
    }) {
      TabContent() {
        Text('首页' + this.currentIndex).fontSize(30)
      }.tabBar("首页")

      TabContent() {
        Text('问答' + this.currentIndex).fontSize(30)
      }.tabBar("问答")

      TabContent() {
        Text('视频' + this.currentIndex).fontSize(30)
      }.tabBar("视频")

      TabContent() {
        Column() {
          Row() {
            Row() {
              Image($r('sys.media.ohos_ic_public_arrow_left'))
                .width('80')
                .fillColor(Color.Red)
                .borderRadius(50)
                .aspectRatio(1)
              Text('19859732425')
            }

            Row({ space: 10 }) {
              Text('个人信息')
              Image($r('sys.media.ohos_ic_public_arrow_right'))
                .width(40)
                .aspectRatio(1)
            }
          }
          .width('100%')
          .height(100)
          .justifyContent(FlexAlign.SpaceBetween)

          // 动态 关注 粉丝 被赞
          Row() {
            Column() {
              Text('0')
              Text('动态')
            }

            Column() {
              Text('0')
              Text('关注')
            }

            Column() {
              Text('0')
              Text('粉丝')
            }

            Column() {
              Text('0')
              Text('被赞')
            }

          }.width('100%')
          .height(100)
          .justifyContent(FlexAlign.SpaceEvenly)

          Row() {
            Column() {
              Text('0')
              Text('系统通知')
            }

            Column() {
              Text('0')
              Text('我的收藏')
            }

            Column() {
              Text('0')
              Text('阅读历史')
            }

            Column() {
              Text('0')
              Text('我的作品')
            }

          }
          .width('100%')
          .height(100)
          .justifyContent(FlexAlign.SpaceEvenly)
          .backgroundColor('rgb(243, 243, 243)')
          .borderRadius(10)

          Column() {
            Row() {
              Text("更多服务")
                .fontWeight(FontWeight.Bold)
                .fontSize(20)
            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .padding({
              left: 20,
              top: 20
            })

            Row({ space: 30 }) {
              Column() {
                Text('0')
                Text('用户反馈')
              }

              Column() {
                Text('0')
                Text('小智同学')
              }
            }
            .width('100%')
            .height(100)
            .padding({
              left: 20
            })
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .height(150)
          .backgroundColor('rgb(243, 243, 243)')
          .margin(20)
          .borderRadius(20)

        }
        .width('100%')
        .height('100%')
        .padding(20)
      }.tabBar("我的")
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgb(248, 248, 248)')
  }
}

class ObjectInfo {
  data: [] = []
  message: string = ''
  channels: [] = []
}

class ObjectInfos {
  channels: [] = []
}

class Channels {
  id: number = -1
  name: string = ''
}