# <div align=center>About iPassword</div>

>现在只要是个App或是个网站基本都会让你注册账号，这就导致有大堆的账号密码要记。虽然可以都用同一个账号密码，但有时候网站或App在注册时有一些限制或账号名已被注册等因素，还是会产生许多不同的账号密码！要一一记住这些账号密码就是个头疼的问题了。在App Store里一搜password有一大堆管理账号密码的App，但是别人的App就是有点信不过，而且一些好一点App价格好高，记得iPassword(不是我写的这个)这个App在App Store里面Mac版的400多大洋，我的天-_---。我自己又有一堆的密码要记，所以就自己写了个App用来记录平时的账号密码

>因为是自己使用的，也没打算提交到App Store。所有设计上面就没有考虑太多。

- [App ScreenShots](#app-screenshots)
- [About BackDoor](#about-backdoor)
- [Requirements](#requirements)
- [Others](#others)
- [License](#license)

## App ScreenShots

在iPassword的TableView页面上通过pinch(双指合拢)可以进入BackDoor页面；同样的在BackDoor页面链接到数据选择后也是通过pinch操作来把数据加入到本地SQlite中
<br><br>
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/LaunchWithTouchID.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/TableView.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/Delete.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/PeekAndPreviewAction.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/Add.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/BackDoor.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/ConnectBackDoor.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />
<img src="https://raw.githubusercontent.com/channingwei/iPassword-swift/master/ScreenShots/AddBackDoorData.PNG" width = "188" height = "334" alt="ConnectBackDoor" align=center />

## About BackDoor

>总会想偷懒一下下的！所以就加了一个接口，可以在PC端把数据先构造好写在txt文件里，然后通过接口把数据传送到手机。这样就极大地方便了添加记录的便利性。

- 在仓库的donet文件夹中写了一个简单的示例程序，只需把我发布到donet/BackDoor的文件夹在IIS下搭建一个站点，即可通过访问Api来获取donet/BackDoor/DataInfoFile.txt中的数据
- Api我是用C#写的，用其他语言也是完全可以的，只是C#用的最顺手而已。下面是简单的介绍从txt文件中获取数据并添加Api方法：<br>
```c#
// 从txt文件中获取数据
public List<DataInfo> GetDataInfosFromFile()
{
	string line;
	var dataInfo = new List<DataInfo>();
	var sr = new StreamReader(AppDomain.CurrentDomain.BaseDirectory + "DataInfoFile.txt", Encoding.Default);
	while ((line = sr.ReadLine()) != null)
	{
		var settings = new JsonSerializerSettings {
			ContractResolver = new DefaultContractResolver()
		};
		dataInfo.Add(JsonConvert.DeserializeObject<DataInfo>(line, settings));
	}
	return dataInfo;
}
```
```c#
public class BackDoorController : ApiController
{
	// Api的Get方法
	[HttpGet]
	public List<DataInfo> OpenBackDoor()
	{
		return new BackDoorCommand().GetDataInfosFromFile();
	}
}
```

## Requirements

- iOS 10.0+
- Xcode 8.1+
- Swift 3.0+

## Others

if you have any question you can open an issue.

if you have any suggestion you can pull request or contact me by channingkuo@icloud.com

if you like the repository you can star this

## License

iPassword is released under the MIT license. See LICENSE for details.