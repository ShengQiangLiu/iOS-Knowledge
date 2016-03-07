# iOS-Knowledge

###一、Objective-C
#####1、@property中有哪些属性关键字？
#####2、使用weak声明的属性需要在dealloc中置nil么？
#####3、@synthesize和@dynamic分别有什么作用？
#####4、ARC下，不显式指定任何属性关键字时，默认的关键字都有哪些？
#####5、用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？
#####6、@synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？
#####7、在有了自动合成属性实例变量之后，@synthesize还有哪些使用场景？ 
#####8、objc中向一个nil对象发送消息将会发生什么？
#####9、objc中向一个对象发送消息**[obj foo]**和**objc_msgSend()**函数之间有什么关系？
#####10、什么时候会报unrecognized selector的异常？
#####11、一个objc对象如何进行内存布局？（考虑有父类的情况）
#####12、一个objc对象的isa的指针指向什么？有什么作用？
#####13、下面的代码输出什么？ 
@implementation Son : Father
    - (id)init
    {
      self = [super init];
         if (self) {
             NSLog(@"%@", NSStringFromClass([self class]));
             NSLog(@"%@", NSStringFromClass([super class]));
         }
         return self;
    }
    @end

#####14、runtime如何通过selector找到对应的IMP地址？（分别考虑类方法和实例方法）
#####15、使用runtime Associate方法关联的对象，需要在主对象dealloc的时候释放么？
#####16、objc中的类方法和实例方法有什么本质区别和联系？
#####17、**_objc_msgForward**函数是做什么的，直接调用它将会发生什么？
#####18、runtime如何实现weak变量的自动置nil？
#####19、能否向编译后得到的类中增加实例变量？能否向运行时创建的类中添加实例变量？为什么？
#####20、runloop和线程有什么关系？
#####21、runloop的mode作用是什么？
#####22、以**+ scheduledTimerWithTimeInterval...**的方式触发的timer，在滑动页面上的列表时，timer会暂定回调，为什么？如何解决？
#####23、猜想runloop内部是如何实现的？ 
#####24、objc使用什么机制管理对象内存？
#####25、ARC通过什么方式帮助开发者管理内存？
#####26、不手动指定autoreleasepool的前提下，一个autorealese对象在什么时刻释放？（比如在一个vc的viewDidLoad中创建）
#####27、BAD_ACCESS在什么情况下出现？
#####28、苹果是如何实现autoreleasepool的？
#####29、使用block时什么情况会发生引用循环，如何解决？
#####30、在block内如何修改block外部变量？
#####31、使用系统的某些block api（如UIView的block版本写动画时），是否也考虑引用循环问题？ 

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

###三、iOS 多线程

###四、网络协议

###五、数据结构

