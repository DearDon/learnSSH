# learnSSH 
这是一个用来学习SSH三大框架的仓库。</br>
由于版权原因，没有直接把随书源码传上来，仓库记录的是自己学习每章时改写的代码。</br>
下面写下学习过程的记录。学习基于电子工业出版社的《JavaEE主流开源框架》一书第一版。
###案例中用的mysql的配套数据库表:
database ssh,其下table customer,包含custname(unique) char(20),pwd char(45),age int,address char(45)</br>
###log01(2015/05/08):
####chapter01
今天终于把第一章的struts2快速入门搞定了，基于struts2完成了一个简单的login应用，由于只是为了体验struts2的工作方法和模式，整个应用的功能很简单，都没有用到数据库。其实本质上struts2框架就是对servlet进行了一些封装，我们知道简单说来servlet就是在JavaSE基础上加上了与web浏览器打交道的功能(通过httprequest或httpresponse)。struts2框架就是为了将该过程分离，使得MVC中的M业务逻辑能从servlet中脱离，完全用JavaSE实现。由于servlet获得http的参数时还是挺繁琐的，重复代码很多，重复编程的大忌。所以struts2加入了一个浏览器与业务逻辑程序的中间媒介，通过MVC中的C控制层(过滤器，拦截器，Action)来完成servlet中的http部分的功能，成功得到浏览器请求中各参数合适形式后，交给适当的M层中的JavaSE程序。M层执行完指定适当的V显示层再次通过C层传至浏览器。总之在struts2的框架中，与浏览器交互的请求和响应都是通过C层的中间过程。这也是struts2框架的意义所在，将web应用中服务器端程序与浏览器的交互通过C层完成，分离出了应用程序核心的M层，可单独用JavaSE编写。这除了简化一些http代码，更重要的是模块分离使得单独用JavaSE中的方法调试M层成为可能，而在之前未分离的情况下必须通过http请求才能使应用程序执行，调试的目标性不强。由于struts2框架只是封闭的servlet类，使用struts2框架只要在web程序中导入适当的包，并配置好struts.xml，过滤器等就ok，不用单独安装其它程序。</br>
另外说一下，学习过程序中遇到的问题，第一次用struts2框架时，即便是很简单的应用，最常见的问题是访问时404错误。这个问题最常见的情况是需要的包未导入全，xml配置不正确。具体要看运行出错时console的出错提示而定。自己当时就是遇到了struts2.xml配置中extends="struts-default"这句多写了个s，使default写成了defaults，导致一直404找不到文件。总之细看console的出错提示，刚开始的出错一般都是文件存放位置不对，配置不正确或必要文件缺失。</br>
###log02(2015/05/09):
今天学完了第二、三、四章。但只把第二章相关的改写代码同步到了库，第三、四章内容较少，直接在这里写下记录就不上传代码了。</br>
####chapter02
首先说第二章，该章主要大致讲了下三类控制器，没有深入讲细节，这一章主要是用struts2框架实现 了用户登陆功能，以及在M层与mysql的交互(按功能共分为了action,dao,exception,service,vo五个包)，虽然该章没有深入讲struts2的内容，但项目的M层基本实现，跨出了第一步，在M层用JDBC连接了MYSQL，加入了不少包(dao,vo,exception)来规范完成这一功能，后面只要把该系统的注册和查看信息功能实现就行。</br>
####chapter03
再来说下第三章，该章节深入讲了拦截器，其自定义的方式就是自己写个java类，实现struts2 API提供的拦截器接口，特别要重写该实现中的intercept方法。拦截器是在action调用前后搭配用的，在用java类实现了拦截器后，使用时要先在struts.xml中定义自定义的拦截器(栈)的名字，然后依旧在struts.xml中设置该拦截器(栈)要与哪个action搭配使用,所谓的拦截器栈就是一系列的拦截器按顺序组合在一起，调用时会依次进行调用。由于struts.xml中定义的包继承了struts-default.xml，默认是整个包内的action都使用了struts-default.xml中定义的defaultStack拦截器栈的。但当自己设置了某个action使用特定的拦截器时，想仍旧使用defaultStack就必须显示指定。</br>
####chapter04
最后说一下第四章，这部分主要讲Action的，Action完成了表单参数封装，业务逻辑调用及根据业务层结果实现页面导航选择输出，可以说是控制层中工作最多的，而且基本都要用户自己实现。这里说实现是因为struts2API定义了Action的接口，但是由于提供的接口的默认功能很少，且基本没什么意义，所以也规定可以不实现该Action接口，而直接自己新建按一定规范要求写的类(要求完成表单变量的get,set等封闭功能，并且其中有个返回值为String的无参数方法，该方法默认名为execute)。当该Action规范类中的执行方法不为execute时(有时不想用该名，或该中有很多个完成不同功能的执行方法，不可能都叫execute)，在调用使用时必须显示说明方法名，这有两大类方法，第一类为在struts.xml中定义Action类名称与类名时同时设置method为该执行方法名，这种方法还能用通配符一次设置该类中多个执行方法的对应名称，第二类方法是在JSP文件中设置，这又分为两种小方法，一种是在表单的action名称设置处将action名称改为actionname!methodname的方式设置，另一种是表单的提交submit项中加入method参数设置。</br>
###log03(2015/05/11):
####chapter05
刚完成了第五章的内容，并根据所学的改写了自己的代码，目前该程序除之前做的登陆之外，还完成了注册及查看其它新户的信息(简易交友系统的基本功能实现了)。这一章主要讲的是如何在Action类中与Servlet API交互，由于struts2框架是MVC框架，为了M层为完全的普通JavaSE程序，在C层必然要实现客户端http与java交互的功能，这主要在过滤器，拦截器中自动实现了。但在C层的第三部分Action类中，是C层中直接调用M层的一部分，由于基本需要用户自己改写，为了单元测试方便，最好是能与servlet解耦，也成为普通的JavaSE程序。通常情况下这确实是可以的，拦截器可以直接把表单元素传给Action类，Action类完全不用知道这些变量来自于网络表单，在它看来与普通Java类中的参数传递没有什么不同。但是有的时候要求得到更多信息，这时第一种方式是使用ActionContext类，该类是Action运行时的上下文(好专业...)，其中包含了会话、请求参数等信息。所以通过该ActionContext对象可方便的获得或设置请求、会话、上下文中的属性，注意是操作它们的属性，来进行值传递。这种通过ActionContext来完成Action与ServletAPI交互的方式的好处是，Action依然与Servlet没什么关系，可当作普通Java程序运行，测试。第二种方式是使用ServletActionContext，这种方式从名字中可以发现比第一种方式多了个Servlet，也暗示了它与Servlet是耦合的，必须要在网络容器(如tomcat)下进行测试，但由于它利用了Servlet技术，可以直接获得请求、会话或上下文对象，并对其进行操作。第一种方式并没有获得这些网络对象，而是通过这些网络对象相关联的Map对象来操作其属性。第三种方式是IoC(Inverse of Control)控制反转方式，这会在Spring部分学习。Action类通过实现一系列的XXXAware接口，可以获得XXX网络对象(XXX可为ServletResponse,ServletRequest,ServletContext)，这是系统容器装配好的。在Action类的execute方法中便可以直接操作这些对象，由于要直接操作这些网络对象，并且还需要系统容器为其装配控制，所以也是与Servlet耦合的，比第二种方式更耦合得紧密，但使用也更为方便。本章完成查看其它用户信息的时候就是通过第一种ActionContext的方式在request属性中传递了所有用户信息集合，并传递到jsp进行显示。</br>
另外要注意的是，在jsp显示所有用户信息时，为了代码简洁，兼容性好，没有手动一行行输出用户信息，而是类似for循环的方式输出，这用到了JSTL标签库和EL迭代功能。EL(Expression Language)是一种表达式语言,如果只是使用EL表达式，不需要引入任何jar包，只要jsp/servlet容器实现了J2EE1.4/servlet2.4、JSP2.0规范就可以。但是要使用JSTL标签库，必须要有jstl.jar,standard.jar两个jar包和标签库对应的tld文件(用来配置与jar包中定义的java类功能中对应的标签名，有点类似xml文件的作用)，所需文件
[下载地址](http://tomcat.apache.org/taglibs/standard)。两个jar包直接放在工程lib目录或其它目录再导入工程的library库中都行。而对应tld(有多个tld后缀的文件，一起放在tld目录下)的文件夹拷到工程的WEB-INF目录下即可。另外有一个小细节，JSTL目前有1.0和1.1版(好象1.2版也出来了，没用过)，它们是不同的。它们的tld文件中设置的uri都不一样，在1.0版中为<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>，而1.1版为<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>。这在导致在jsp页面设置默认引用的uri要对应改到，否则找不到对应标签库。
###log04(2015/05/12):
上午学习了第六、七章的内容，这两章对所做的项目案例并没有太大改动，也没有新增什么功能，所以学习的代码没有push到github上来。记录一下学习体验，学完后发现第五、六、七章内容都是很相关的，讨论的都是Action类中存取、传递值或对象的一些技术手段，所以对这三章分别评价下，好对Action类传递值的技术了解更系统。由于Action类是C层中最底下的一层，直接与M层和V层打交道，所以对这几层间的值传递功能有很大需求。</br>
先温习下第五章，该部分主要说的是Action利用ServletAPI完成客户端传来的各种网络对象获取，并将其转交给M层处理。由于要获得网络对象，这与Servlet功能紧密相关，除了ActionContext方式外，ServletActionContext和IoC方式要求Action类与Servlet相耦合，使得测试运行必须在系统容器中进行。</br>
####chapter06
第六章则介绍了另一种交互技术，通过拦截器在Action执行前后帮助封装网络的请求参数(Field-Driven方式)或对象(Model-Driven方式)，由于这都是通过拦截器来调用实现封装的，所以在Action类中要按规范定义请求的参数或对象，并设置好对应的setXXX(在Action之前的拦截器用来往Action类中传递值)和getXXX(在Action之后的拦截器用来调用方便取出Action类中的属性值，好传递给之后的jsp文件等)，这种交互技术的存取值都是通过拦截器完成的，所以Action类可完全与Servlet节耦，方便单元测试。</br>
####chapter07
第七章更进一步利用第六章的技术，将Action类的属性进一步开发，除了第六章讲的封装客户端传来的请求参数或对象，还可以封装struts.xml中配置的参数，或自己在Action类中自定义属性(这时该属性可以没有setXXX方法，因为不需要上层传值过来，也就是不用拦截器为其赋值，但要想将该属性传给之后调用的jsp，必须要有getXXX方法，这样之后的拦截器才能取出该值传给对应的jsp)。由于Action的属性可以封闭如此多东西（网络请求范围内的参数和对象，或自定义的配置参数、属性），所以Action属性显然可以用于在不同文件或层之间进行传值用，可以实现客户端传来的网络对象（参数）、M层的对象（参数）、V层的对象（参数）间的传递和交互。第七章最后还详细介绍了Jsp如何通过getXXX方法获得Action请求范围内属性值。</br>
综合第五、六、七章的技术，总结一下。Action类有两大类传值方式：一类是通过ServletAPI的方式，这种方式通常与Servlet耦合(ActionContext方式除外，但只能操作请求属性)，也因此具有Servlet的网络特性，可以全面地操作网络请求、会话和上下文对象。另一类是通过Action类属性的封装，这种方式由于利用拦截器完成属性封装，所以Action类与Servlet是解耦的，也因此Servlet的功能较少，仅能获取网络请求的对象或参数(至少书中没说可以操作会话或上下文对象，可以是因为网络请求的操作要求最频繁，所以在Action类属性的封闭方法中实现了网络请求范围的操作，当然如何第二类方法要是还能操作会话或上下文对象的话，几乎完全替代了第一类方法的功能，还保证解耦，那应该也就不需要第一大类方法了，所以估计是实现不了)，但是Action类属性很灵活，可以自定义除网络传递来的对象外的任意对象，并保存于请求范围属性中，只要满足getXXX要求，都能传递给之后的jsp等文件。所以简单一句话就是第一类方式在Action类中操作网络对象比较强大，第二类方式操作自定义的对象或网络请求对象比较灵活。
###log05(2015/05/18):
至今天，Struts2框架部分已经学习完了。今天统一更新一下chapter08-chapter14学习的内容记录。其中chapter09中提到的国际化以及chapter10和chapter13利用Ajax完成表单校验的功能自己综合改写并进行统一，更新到了github仓库标签chapter14。</br>
####chapter08
首先是关于第八章，这部分讲的值栈和OGNL。值栈是Struts2框架里很关键的一个部分，它是针对线程的，每次网络请求都会开启一个线程，同时生成一个值栈。这个值栈可供整个请求过程使用，在内存层面，也正是由值栈来处理Action类的值传递问题的。同一个请求用到的所有Action类实例对象(也就是该Action类中申明的所有成员变量)都是存在一个值栈中，所以保证了可以很方便地通过值栈的读取而传递Action类对象中的变量。当然值栈中还存有些其它如OGNL表达式计算过程中的中间变量或结果。OGNL是一种强大的EL表达式，它可以方便地在JSP文件中读取该次请求过程中的ActionContext。ActionContext是Action上下文，也是线程安全的，包括了Action类运行所需要的所有对象，如网络请求request、会话session等。由于ActionContext是OGNL所能访问的所有内容，也有人称它为广义的值栈(包含了传统的值栈)。关于OGNL要知道它可以方便地存取ActionContext的内容就行，OGNL需要额外导入ognl类包后使用。该章主要难点是理解ActionContext,session,Action等的相互关系，它们间的关系如下的分层图所示。
```
ActionContext:Action上下文,也被人称为广义值栈,是OGNL所能访问的范围/
├── 值栈:StackValue,是OGNL访问时的根目录/
│   ├── Action类的对象,包含其中定义的所有成员变量等
│   └── OGNL表达式的计算结果或中间变量,如循环语句中计数变量等
├── application:可访问ServletContext
├── session:可访问HttpSession
├── request:可访问HttpServletRequest
├── parameters:可访问请求参数
└── attr:按page-request-session-application顺序访问
```
值栈的重要意义是实现了Action类中属性用拦截器赋值的底层过程，引用[某博客上关于该过程的介绍](http://www.cnblogs.com/jerryxing/archive/2012/04/23/2467299.html)。
    "众所周知，Strut 2的Action类通过属性可以获得所有相关的值，如请求参数、Action配置参数、向其他Action传递属性值（通过chain结果）等等。要获得 这些参数值，我们要做的唯一一件事就是在Action类中声明与参数同名的属性，在Struts 2调用Action类的Action方法（默认是execute方法）之前，就会为相应的Action属性赋值。要完成这个功能，有很大程度上，Struts 2要依赖于ValueStack对象。这个对象贯穿整个Action的生命周期（每个Action类的对象实例会拥有一个ValueStack对象）。当 Struts 2接收到一个.action的请求后，会先建立Action类的对象实例，但并不会调用Action方法，而是先将Action类的相应属性放到 ValueStack对象的顶层节点（ValueStack对象相当于一个栈）。只是所有的属性值都是默认的值，如String类型的属性值为 null，int类型的属性值为0等。在处理完上述工作后，Struts 2就会调用拦截器链中的拦截器，当调用完所有的拦截器后，最后会调用Action类的Action方法，在调用Action方法之前，会将 ValueStack对象顶层节点中的属性值赋给Action类中相应的属性。大家要注意，在这里就给我们带来了很大的灵活性。也就是说，在Struts 2调用拦截器的过程中，可以改变ValueStack对象中属性的值，当改变某个属性值后，Action类的相应属性值就会变成在拦截器中最后改变该属性 的这个值。 从上面的描述很容易知道，在Struts 2的的Action类可以获得与属性同名的参数值就是通过不同的拦截器来处理的，如获得请求参数的拦截器是params，获得Action的配置参数的拦 截器是staticParams等。在这些拦截器内部读取相应的值，并更新ValueStack对象顶层节点的相应属性的值。而ValueStack对象 就象一个传送带，将属性值从一个拦截器传到了另一个拦截器（当然，在这其间，属性值可能改变），最后会传到Action对象，并将ValueStack对 象中的属性的值终值赋给Action类的相应属性。"</br>
####chapter09
接下来说一下第9章，该章主要说利用Struts2框架中的properties文件定义key=value对，以抽象页面显示内容，以实现国际化。所谓国际化就是针对不同浏览器的语言设置显示不同语言版本的网页，但是网页框架是同一个，仅是显示语言进行了修改。思想很简单，就是把要显示的信息抽象出来在properties中定义，这就类似于编程语言中的宏，一个简单的抽象和替换思想。注意一点的是，国际化的测试在IE浏览器尝试成功，但360浏览器失败，不管语言顺序如何，一直显示中文版。猜想应该是360浏览器自作聪明，查看了本地操作系统的默认语言是中文，所以即使设置了优先语言是英文的情况下还是输出的中文版本。</br>
####chapter10
第十章是介绍校验技术，因为常常需要在表单数据与数据库交互前进行检验，以发现是否满足基本要求，当不满足时可直接对应处理而不必与数据库进行交互，以减少服务器的载荷和时间消耗。传统的校验方式要经过一个完整的http请求，需要消耗不少网宽和时间，使用Ajax可优化该过程。其实仔细一想，大部分校验Ajax都不用，应该不用和服务器通信，在浏览器端就能完成，可以用javascript离线完成。但是这需要网络传输javascript代码，时间和网络开销可能得另外考虑。</br>
####chapter11
第十一章详细介绍了在Jsp使用struts2标签。标签主要分为UI标签(生成页面元素，也就是可见的部分)和通用标签(实现逻辑、数据控制等，如循环、分支等控制标签)。该章主要介绍了在V层如何用struts2的标签进行开发。</br>
####chapter12
第十二章介绍异常处理，主要因M层常可能出现异常，需要一定处理。在struts2框架下，M层抛出的异常可直接由Action类捕获处理，也可以Action不处理，继续抛出，在struts.xml中声明该异常映射处理方式。异常可设定特定信息，交由jsp显示给用户。</br>
####chapter13
第十三章介绍了Ajax技术，Ajax技术是由很多成熟的技术组合出来的，并不是新创。Ajax最常见的用途就是优化第十章的校验技术，可以在用户填写表单的同时进行异步校验。当不用框架，直接完成Ajax的功能完成异步请求时要经过很繁琐的过程，在Jsp中要加入大量javascript代码，为了简化这一过程于是很多框架被开发了。struts2框架中只是集成了这些简化Ajax操作的框架中很流行的两个——dojo和DWR框架，并没有单独开发实现这一部分的框架。以DWR为例，配置dwr.xml文件便能集成DWR于struts2中，而关于要进行ajax异步校验的jsp中的代码与之前基本一致，仅仅是主题进行了设置theme="ajax"，检验便会用异步技术完成。Ajax技术的所有底层细节都在引用的dwr包中完成了，不用自己手动繁琐完成。</br>
####chapter14
该章总结了struts2框架中各技术所用到的配置文件(xml,properties)，xml文件将所有组件联系在了一起，properties文件主要是完成key-values定义(相当于宏定义)，简单的key-values定义也可以在xml中用constant标签完成。</br>
####Struts2框架总结
至此struts2框架已经学习完了，最后总结一下。该框架主要是处理客户端与服务器的交互(MVO模型实现)。</br>
2-8章主要讲C层如何存取、传递对象或参数。2-6章讲Action类从客户请求获取参数并传递给M层，6-8章讲Action类的对象或参数如何传递给V层(jsp)。</br>
9-13章则讲解了struts2框架在V层的应用，均是关于用户体验可见的部分。如国际化(语言版本控制)、表单信息校验(Ajax方式与传统方式)及提醒消息(异常消息机制提醒)，以及各种可用于开发jsp的struts2标签用法。
###log06(2015/05/22):
完成了struts2框架的学习后，开始了hibernate的学习。但是万事开头难，主要自己没用教材上的MyEclipse开发环境，坚持了Eclipse，所以成功编写第一个基于hibernate框架的java程序还是遇到不少问题。因为hibernate框架和前面struts2框架不同的是，它用Eclipse和Myeclipse这两个IDE下开发时有较大差异(当然是指Eclipse没有装那么多插件的情况下)，之前的struts2框架使用在Eclipse和MyEclipse下基本没有差别，均导入类包就行。但hibernate在两个IDE下的开发插件有些许差别，导致了上手比较麻烦，折腾大半天总算把问题都弄清楚，程序整成功了吧。把第一个写好的程序push到了chapter16的tag标签</br>
PS:课本上SSH这三部分每部分的章节都是第1章开始起头，为了仓库备份命名方便，改了章节命名，接上之前章节，该部分从第15章开始。
####chapter15
hibernate框架是ORM(Object-Ralational Mapping)框架，流程结构相对比较简单。该框架主要要求用户提供3部分文件(po类,hbm.xml映射文件,cfg.xml或properties配置文件)即可运行，PO(Persistent Objects)是可持久化类，用来代表要操作的数据库中的表单内容，PO对应的hbm.xml指明PO与数据库中哪个表的哪些字段对应，而cfg.xml或properties文件则配置了如数据库连接帐号密码、驱动等配置参数。前面提到不同IDE下利用hibernate开发操作有差别，但是hibernate的原理是相通的，只要提供了前面说的那3个部分和jar包，肯定就能运行。主要是那3个文件手工编写都比较困难，又容易出错，所以一编利用相关的插件工具以简化生成过程(如正逆向工程)，不同IDE下这工具有些许差别。Eclipse和MyEclipse两个IDE所用的简化hibernate开发的插件工具不同，导致很多操作有区别。</br>
####chapter16
该章试写了第一个Hibernate框架的程序，果然第一步问题多多，主要出现了两个问题。解决后该程序成功运行了。</br>
第一个问题首先是开发需要的插件及使用方法，关于eclipse下hibernate插件安装(MyEclipse中集成了开发插件，不用装)可参考一条百度经验[Eclipse 在线配置 Hibernate Tools](http://jingyan.baidu.com/article/db55b609959d154ba20a2f5d.html),利用该插件配置cfg.xml及逆向工程生成po类和hbm.xml映射文件的方法(逆向工程的操作也与在MyEclipse中有差别)可参考csdn的一篇文章[eclipse从数据库逆向生成Hibernate实体类](http://blog.csdn.net/wangpeng047/article/details/6877720)。至此,Eclipse下开发hibernate的插件及利用该插件生成所必须的三部分文件都弄好了，向工程中导入Hibernate必要的jar包就可以用了(MyEclipse中默认导入了，不用再导入)。啰嗦一句，在新环境或新工具在使用一种技术要抓住该技术的关键原理(如此处hibernate的三个主要部分)，这样就不怕找不着方向了。我下的Hibernate4.3版本，教材中用的是3.X版本，这个版本差异带来了之后的第二个问题。</br>
前面的第一个问题是Eclipse和MyEclipse环境不同导致的，第二个问题是由Hibernate版本不同导致的，4.3版本居然不兼容3.x的版本，在该版本中某些旧版本的方法已经被废除了~|~。在hibernate操作数据库的时候要新建SessionFacroty类的对象，在教材中(Hibernate4.0之前的旧版)中是对Configuration类的对象,设对象名为configuration，用configuration.buildSessionFactory()便可返回一个SessionFacroty类的对象。但buildSessionFactory()方法在4.0版后便被废除了。上网查到了解决办法，说是4以后版本提供了ServiceRegistry来取代之前的方法，具体可见两个网页[Hibernate4中buildSessionFactory方法废弃问题。](http://blog.csdn.net/iaiti/article/details/9211905)和[Hibernate SessionFactory Example](http://www.roseindia.net/hibernate/hibernate4/HibernateSessionFactory.shtml)。两个网页说的方法一样，可一试，居然又提示这两网页所使用的方法中某方法被抛弃了，又上网查，发现在4.3版ServiceRegistry这种取得SessionFactory的方法也被抛弃了，用了另外的方式来实现(改动太快了...),找到了4.3版对应的更新替代方法(用了StandardServiceRegistryBuilder类)[Is buildSessionFactory() deprecated in hibernate 4?](http://stackoverflow.com/questions/8621906/is-buildsessionfactory-deprecated-in-hibernate-4)。终于成功利用教材上的测试数据库功能代码操作数据库。关于第2个问题说下感想，对于这种问题解决必须要看控制台的错误提示以及IDE提供的源码文件的错误或警告(如何用IDE的话)，然后见机行事，根据线索查找资料。</br>
PS:为保证隐私，控制台输出的数据库操作语句对表单数据的value统一用"?"代替显示了，开始还以为是编码有问题，mysql与输入编码不同，不识别之类的问题，发现多虑了，只是为隐私考虑。

