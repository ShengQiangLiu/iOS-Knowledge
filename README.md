# iOS-Knowledge

###一、Objective-C


###二、UI
#####1、什么是key window?
keyWindow是指定的用来接收键盘以及非触摸类的消息，而且程序中每一个时刻只能有一个window是keyWindow。
#####2、在UIKit中、frame和bounds的区别？
frame：参照点为父视图的坐标系统

bouunds：参照点为本身的坐标系统

从下面可以理解，bounds的x、y是一直为本身的坐标系统值（0、0）

-(CGRect)frame{
    return CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
}
-(CGRect)bounds{
    return CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
}

###3、iOS 几种加密算法的区别？
AES：更快，兼容设备，安全级别高

SHA1：公钥后处理回传

DES：本地数据，安全级别低

RSA：非对称加密，有公开密钥（publickey）和私有密钥（privatekey）
公开密钥与私有密钥是一对，如果用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；如果用私有密钥对数据进行加密，那么只有用对应的公开密钥才能解密

MD5：防篡改

###三、多线程

###四、网络协议

###五、数据结构

