// class 读写首选项
import { preferences } from '@kit.ArkData'

// 首选项
export class AuthManager {
  context?: Context

  // 获取仓库
  getStore() {
    return preferences.getPreferencesSync(this.context || getContext(), {
      name: 'auth_token'
    })
  }

  // 写入token
  async setToken(token: string) {
    const store = this.getStore() // 获取仓库
    store.putSync("auth", token)
    // 必须得flush一下
    await store.flush() // 写入磁盘
  }

  // 获取token
  getToken() {
    const store = this.getStore()
    return store.getSync("auth", "") as string
  }
}