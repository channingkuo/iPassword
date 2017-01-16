//1 新建一个类文件：
//fingerUnlock继承于NSObject就可以
//2 在这个文件中导入需要的系统框架 
import LocalAuthentication

class fingerUnlock : NSObject {

    class func userFigerprintAuthenticationTipStr(tipsStr: String) {
        let context = LAContext()
        var error: NSError?
        // 判断设备是否支持指纹解锁
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: tipsStr, reply: { (success, error) in
                if success {
                    print("验证成功")
                } else {
                    switch Int32(error!.code) {
                        // 身份验证失败
                        case kLAErrorAuthenticationFailed:
                            print("LAErrorAuthenticationFailed")
                        // 用户取消
                        case kLAErrorUserCancel :
                            print("kLAErrorUserCancel")
                            break
                        //验证失败
                        case kLAErrorUserFallback:
                            print("LAErrorUserFallback")
                            break
                        // 被系统取消，例如按下电源键
                        case kLAErrorSystemCancel:
                            print("kLAErrorSystemCancel")
                            break
                        // 设备上并不具备密码设置信息，也就是说Touch ID功能处于被禁用状态
                        case kLAErrorPasscodeNotSet:
                            print("kLAErrorPasscodeNotSet")
                            break
                        // 设备本身并不具备指纹传感装置
                        case kLAErrorTouchIDNotAvailable:
                            print("kLAErrorTouchIDNotAvailable")
                            break
                        // 已经设定有密码机制，但设备配置当中还没有保存过任何指纹内容
                        case kLAErrorTouchIDNotEnrolled:
                            print("kLAErrorTouchIDNotEnrolled")
                            break
                        // 输入次数过多验证被锁
                        case kLAErrorTouchIDLockout:
                            print("kLAErrorTouchIDLockout")
                            break
                        // app取消验证
                        case kLAErrorAppCancel:
                            print("LAErrorAppCancel")
                            break
                        // 无效的上下文
                        case kLAErrorInvalidContext:
                            print("LAErrorAppCancel")
                            break
                        default:
                            break
                    }
                }
            })
        } else {
            print("您的设备不支持touch id")
        }
    }
}