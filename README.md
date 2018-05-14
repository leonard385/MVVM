# MVVM
MVVM-C架构工程，MVVM实现参考
Colin Eberhardt于2014年7月3日发布的
[MVVM Tutorial with ReactiveCocoa](https://www.raywenderlich.com/74106/mvvm-tutorial-with-reactivecocoa-part-1) FlickrSearchProject工程。
##改进：
在此基础上改进：

1. 将原工程model层，业务逻辑实现Impl类实例方法改为类方法，方便ViewModel层引用。
2. 去除原RWTViewModelServices(原工程负责1.获取model业务逻辑Impl类2.负责跳转)以及相关实现类。(1)减少不必要的代码实现,model层业数据请求直接调用类方法形式，无需实例化。（2）页面跳转通过coordinate实现。
3. 引入Coordinator 有的人也称之为flowController,将架构调整为MVVM-C，提高ViewModel的复用性，以及工程的可扩展性。


##通过这个工程你可以看到：
1. coordinator 在实际项目中的工程结构，coordinator正反向传值、ViewModel->Coordinator以及子Coordinator--->父coordinator 交互。
2. model层业务逻辑剥离，使用类方法提供给外部调用，model层不在只是基本数据结构。
3. ViewModel与View交互实例 包括两方面(1)viewmodel提供给View，给View展示数据，并处理View用户事件。(2)viewModel业务逻辑处理过程中需要View展示用户的情景。

相关博文地址:[IOS-MVVM架构实践以及架构优化](https://www.jianshu.com/p/de98240ffcda)

欢迎提出宝贵的意见。

