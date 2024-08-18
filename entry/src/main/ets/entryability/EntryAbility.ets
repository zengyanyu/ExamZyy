import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { UserSettingClass } from '../utils/setting';
import { TOKEN_KEY } from '../constants';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // 设置首选项
    const setting = new UserSettingClass(this.context)
    // 判断是否有TOKEN
    const token = setting.getToken()
    AppStorage.setOrCreate(TOKEN_KEY, token)
    if (token) {
      // 需要判断一下有没有token
      windowStage.loadContent("pages/MainPage") // 正常加载主页
    } else {
      windowStage.loadContent("pages/LoginPage") // 跳转到登录
    }
    // windowStage.loadContent('pages/LoginPage');
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
