# iOS-Knowledge

###一、Objective-C
####——基础部分
#####1、@property中有哪些属性关键字？
#####2、使用weak声明的属性需要在dealloc中置nil么？
#####3、@synthesize和@dynamic分别有什么作用？
#####4、ARC下，不显式指定任何属性关键字时，默认的关键字都有哪些？
#####5、用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？
#####6、@synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？
#####7、在有了自动合成属性实例变量之后，@synthesize还有哪些使用场景？ 
#####20、runloop和线程有什么关系？
#####21、runloop的mode作用是什么？
#####22、以**+ scheduledTimerWithTimeInterval...**的方式触发的timer，在滑动页面上的列表时，timer会暂定回调，为什么？如何解决？
#####23、猜想runloop内部是如何实现的？ 
#####24、objc使用什么机制管理对象内存？
#####25、ARC通过什么方式帮助开发者管理内存？
#####26、不手动指定autoreleasepool的前提下，一个autorealese对象在什么时刻释放？（比如在一个vc的viewDidLoad中创建）
#####27、BAD_ACCESS在什么情况下出现？
#####28、苹果是如何实现autoreleasepool的？
#####42、如何调试BAD_ACCESS错误
#####43、lldb（gdb）常用的调试命令？
#####39、IBOutlet连出来的视图属性为什么可以被设置成weak?
#####40、IB中User Defined Runtime Attributes如何使用？

####——runtime部分
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

####——block部分
#####29、使用block时什么情况会发生引用循环，如何解决？
	
    //造成循环引用
    _handlerBlock = ^{
    	// _string 为成员变量
        NSLog(@"log self = %@", _string);
    };
    _handlerBlock();
    
造成循环引用的原因：
这里的_string相当于是self->_string；那么block是会对内部的对象进行一次retain。也就是说，self会被retain一次。当self释放的时候，需要block释放后才会对self进行释放，但是block的释放又需要等self的dealloc中才会释放。如此一来变形成了循环引用，内存永远释放不了，导致内存泄露。

	//__weak方式避免循环引用
    __weak RetainCycleViewController *weakSelf = self;
    _handlerBlock = ^{
        NSLog(@"weak self = %@", weakSelf);
    };
    _handlerBlock();
    
    //__block方式避免循环应用
    __block RetainCycleViewController *blockSelf = self;
    _handlerBlock = ^{
        NSLog(@"block self = %@", blockSelf);
        
        blockSelf = nil; //记的一定要置为nil，否则还是会造成内存泄露
    };
    _handlerBlock(); //同时该block需要执行,才可以


    
#####30、在block内如何修改block外部变量？
在变量前加 __block 标识符就可以在block内部修改变量

#####31、使用系统的某些block api（如UIView的block版本写动画时），是否也考虑引用循环问题？ 

所谓循环引用，是因为当前控制器在引用着block，而block又引用着self即当前控制器，这样就造成了循环引用。系统的block调用并不在当前控制器中调用，那么这个self就不代表当前控制器，那自然也就没有循环引用的问题。以上引用均指强引用。 


####——KVC、KVO部分
#####32、**addObserver:forKeyPath:options:context:**各个参数的作用分别是什么，observer中需要实现哪个方法才能获得KVO回调？
#####33、如何手动触发一个value的KVO？
#####34、若一个类有实例变量NSString *_foo，调用setValue:forKey:时，可以以foo还是_foo作为key？
#####35、KVC的keyPath中的集合运算符如何使用？
#####36、KVC和KVO的keyPath一定是属性么？
#####37、如何关闭默认的KVO的默认实现，并进入自定义的KVO实现？
#####38、apple用什么方式实现对一个对象的KVO？ 
 


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

#####3、iOS 几种加密算法的区别？
AES：更快，兼容设备，安全级别高

SHA1：公钥后处理回传

DES：本地数据，安全级别低

RSA：非对称加密，有公开密钥（publickey）和私有密钥（privatekey）
公开密钥与私有密钥是一对，如果用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；如果用私有密钥对数据进行加密，那么只有用对应的公开密钥才能解密

MD5：防篡改

###三、iOS 多线程
#####1、GCD的队列（dispatch_queue_t）分哪两种类型？
GCD的队列分为Serial Dispatch Queue 串行分发队列 和 Concurrent Dispatch Queue 并行分发队列 两种。

生成串行分发队列的方式：通过dispatch_get_main_queue()函数，获取的主队列，主队列属于串行队列。通过设置dispatch_queue_create()函数第二个参数类型为DISPATCH_QUEUE_SERIAL，获取串行队列。

生成并行分发队列的方式：通dispatch_get_global_queue()函数，获取全局队列，全局队列属于并行队列。通过设置dispatch_queue_create()函数第二个参数类型为DISPATCH_QUEUE_CONCURRENT，获取并行队列。

dispatch_queue_create("com.example.gcd", DISPATCH_QUEUE_SERIAL) 
dispatch_queue_create("com.example.gcd", DISPATCH_QUEUE_CONCURRENT)


#####2、如何用GCD同步若干个异步调用？（如根据若干个url异步加载多张图片，然后在都下载完成后合成一张整图）
方案一、使用dispatch_group_create()函数，创建一个组队列；然后使用 dispatch_group_notify()函数监听组队列，等组队列里面的线程全部执行完之后，执行回调处理。

		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	    // 创建一个组队列
	    dispatch_group_t group = dispatch_group_create();
	    
	    dispatch_group_async(group, queue, ^{
	        NSLog(@"加载图片1");
	    });
	    
	    dispatch_group_async(group, queue, ^{
	        NSLog(@"加载图片2");
	    });
	    
	    dispatch_group_async(group, queue, ^{
	        NSLog(@"加载图片3");
	    });
	    
	    /*
	     dispatch_group_notify 函数监听dispatch group，全部执行完成之后，执行回调处理
	     */
	    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
	        NSLog(@"done，合并图片");
	    });
	    
方案二、使用dispatch_barrier_async()函数，这个函数会等待追加到该Concurrent Dispatch Queue 上的并行执行的处理全部结束之后，再将指定的处理追加到该 Concurrent Dispatch Queue 中，然后执行block回调操作。

		// 1、首先 dispatch_queue_create 函数生成 Concurrent Dispatch Queue，在dispatch_async 加载图片
	    dispatch_queue_t queue = dispatch_queue_create("com.example.gcd", DISPATCH_QUEUE_CONCURRENT);
	    dispatch_async(queue, ^{
	        NSLog(@"加载图片1");
	    });
	    
	    dispatch_async(queue, ^{
	        NSLog(@"加载图片2");
	    });
	    
	    // 2、等待追加到该Concurrent Dispatch Queue 上的并行执行的处理全部结束之后，再将指定的处理追加到该 Concurrent Dispatch Queue 中，然后执行合并操作
	    dispatch_barrier_async(queue, ^{
	        NSLog(@"done，合并图片");
	    });


#####3、dispatch_barrier_async的作用是什么？
dispatch_barrier_async()函数的作用，上面题目中已经给出了答案。

在并行队列中，为了保持某些任务的顺序，需要等待一些任务完成后才能继续进行，使用 barrier 来等待之前任务完成，避免数据竞争等问题。 dispatch_barrier_async 函数会等待追加到Concurrent Dispatch Queue并行队列中的操作全部执行完之后，然后再执行 dispatch_barrier_async 函数追加的处理，等 dispatch_barrier_async 追加的处理执行结束之后，Concurrent Dispatch Queue才恢复之前的动作继续执行。

（注意：使用 dispatch_barrier_async ，该函数只能搭配自定义并行队列 dispatch_queue_t 使用。不能使用： dispatch_get_global_queue ，否则 dispatch_barrier_async 的作用会和 dispatch_async 的作用一模一样。 ）

#####4、苹果为什么要废弃dispatch_get_current_queue?
dispatch_get_current_queue 容易造成死锁，详解请参考：

[http://blog.csdn.net/yiyaaixuexi/article/details/17752925](http://blog.csdn.net/yiyaaixuexi/article/details/17752925)

#####5、以下代码运行结果如何？ 
	- (void)viewDidLoad
	{
	    [super viewDidLoad];
	    NSLog(@"1");
	    dispatch_sync(dispatch_get_main_queue(), ^{
	        NSLog(@"2");
	    });
	    NSLog(@"3");
	}
	
会打印1，然后死锁了。在主线程中执行指定的black，并等待其执行结束，而其实在主线程中正在执行这些源代码。

死锁还有如下几种：

	- (void)viewDidLoad
	{
	   // 死锁二，主队列
	   dispatch_queue_t queue = dispatch_get_main_queue();
	   dispatch_async(queue, ^{
	       dispatch_sync(queue, ^{
	           NSLog(@"死锁了......");
	       });
	   });
	   
	   // 死锁三，Serial Dispatch Queue
	   dispatch_queue_t serialQueue = dispatch_queue_create("com.example.gcd", NULL);
	   dispatch_async(serialQueue, ^{
	       dispatch_sync(serialQueue, ^{
	           NSLog(@"死锁了......");
	       });
	   });
	   
    }

    
从上面总结

**死锁：动作1的结束依赖于动作2的结束，动作2的开始依赖于动作1的结束**

**禁忌：不要在主线程里给主队列同步添加任务**
	
#####6、
#####7、
#####8、
#####9、
#####10、
#####11、
#####12、
#####13、
#####14、
#####15、
#####16、
#####17、
#####18、
#####19、



###四、网络协议

###五、数据结构






这些知识点大部分网络上面搜集的，主要参考网址：

[http://blog.sunnyxx.com/2015/07/04/ios-interview/](http://blog.sunnyxx.com/2015/07/04/ios-interview/)
[https://github.com/ChenYilong/iOSInterviewQuestions/blob/master/01%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88/%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88%EF%BC%88%E4%B8%8A%EF%BC%89.md](https://github.com/ChenYilong/iOSInterviewQuestions/blob/master/01%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88/%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88%EF%BC%88%E4%B8%8A%EF%BC%89.md)




