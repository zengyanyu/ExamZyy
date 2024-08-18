// 主页
import { http } from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';
import { HmList } from '../components/HmList';
import { promptAction } from '@kit.ArkUI';
import { image } from '@kit.ImageKit';

@Entry
@Component
struct MainPage {
  private controller: TabsController = new TabsController();
  // 定位到我的
  @State currentIndex: number = 3;
  @State
  list: Channel[] = []
  @State
  listStr: string[] = ['1', '2', '3', '4', '5', '6', '7', '8']
  @State
  objectArr: ObjectInfo1[] = [{ name: '1' }, { name: '2' }, { name: '3' }]

  // 生命周期初始化函数
  aboutToAppear() {
    this.getHttpInfo()
  }

  // 获取所有频道
  async getHttpInfo() {
    const req = http.createHttp();
    const result = await req.request('https://toutiao.itheima.net/v1_0/channels');
    const res = JSON.parse(result.result + "") as ObjectInfo
    this.list = res.data.channels;
    this.listStr = res.data.channels.map(item => item.name);
  }

  async onRefresh() {
    // this.queryParams.page = 1 // 重新请求第一页数据
    // await this.getTaskList(true) // 重新请求数据
  }

  // 首页
  @Builder
  firstPage() {
    Column() {
      HmList({
        finished: false, // 是否加载完成
        renderItem: (item) => {
          // this.renderItem(item)
        },
        dataSource: this.objectArr,
        onLoad: async () => {
          //await this.getTaskList()
        },
        onRefresh: async () => {
          await this.onRefresh()
          promptAction.showToast({ message: '刷新成功' })
        },
        loadingText: '在加拉',
        finishText: '我也是有底线的'
      })
    }
    .width('100%')
    .height("100%")
  }

  // 视频
  @Builder
  getVideoBuilder() {
    Column({ space: 10 }) {
      Row() {
        Text('视频')
          .fontWeight(700)
          .fontSize(20)
      }.width('100%')
      .height(20)
      .justifyContent(FlexAlign.Center)

      ForEach([1, 2], (item: number, index: number) => {
        Column({ space: 6 }) {
          Text('格力电器将继续发展手机业务,并将向全产业覆盖!')
          Image('http://gips2.baidu.com/it/u=195724436,3554684702&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960')
            .width('100%')
            .aspectRatio(1)
          Text('1563次播放').fontSize(12)
        }.width('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      })
    }.width('100%')
    .height('100%')
    .padding(20)
  }

  // 问答
  @Builder
  getQuestion() {
    Column({ space: 20 }) {
      ForEach([1, 2, 3, 4, 5], (item: number) => {
        Row({ space: 20 }) {
          Row() {
            Column({ space: 10 }) {
              Text('作为 IT 行业的过来人，你有什么话想对后辈说的？')
              Text('赞同 1000+评论 500+1小时前').fontColor(Color.Gray)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .height('100%')
          }
          .layoutWeight(1)

          Image('http://gips2.baidu.com/it/u=195724436,3554684702&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960')
            .width(100)
            .aspectRatio(1)
        }.width('100%')
        .height(100)
      })
    }.width('100%')
    .height('100%')
    .padding(20)
  }

  build() {
    Column() {
      Column() {
        Tabs({ controller: this.controller }) {
          ForEach(this.listStr, (item: string, index: number) => {
            TabContent() {
              // Column() {
              //   Text(item)
              // }
            }.tabBar(
              SubTabBarStyle.of(item)
                .indicator({
                  color: Color.Orange,
                  height: 3,
                  width: 20,
                  marginTop: 5
                })
                .labelStyle({
                  // 设置选中颜色
                  selectedColor: Color.Orange,
                  // 设置未选中颜色
                  unselectedColor: Color.Gray
                })
            )
          })
        }.barMode(BarMode.Scrollable)
        .animationDuration(0)
        .onAnimationStart((index: number, targetIndex: number) => {
          this.currentIndex = targetIndex;
        })
        .onTabBarClick((index) => {
          // promptAction.({
          //   message: '显示当前索引:' + index
          // })
        })
      }.width("100%")
      .height(50)

      Column() {
        Tabs({
          // 位置设置为下方
          barPosition: BarPosition.End,
          // 实现双向绑定
          index: $$this.currentIndex
        }) {
          TabContent() {
            this.firstPage();
          }.tabBar("首页")

          TabContent() {
            this.getQuestion()
          }.tabBar("问答")

          TabContent() {
            this.getVideoBuilder();
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
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
  }
}

export class ObjectInfo {
  data: Data = new Data()
}

export class Data {
  channels: Channel[] = []
}

export class Channel {
  id: number = -1
  name: string = ''
}

export class ObjectInfo1 {
  name: string = ''
}