; 可调用API在本文件的最后
; 这里必须带有一个跟插件文件名一致的标签，Vimcore加载插件时，会运行之
<Temp>:
	; 一般用来定义全局变量
	Global Test
	; 添加插件对应的描述，用于帮助里的动作说明
	CustomActions("<TempAction1>","例子1")
	; 也可以添加其它预运行的功能，例如TConly里，就是预加载文件模板功能的菜单
	; 可以参考TConly.ahk
return

; %Class%_CheckMode()
; Vimcore运行模式区分，即什么时候是普通模式，什么时候是编辑模式
; 可以通过自定义CheckMode()函数来实现
; Vimcore在解析每个热键时，都会用WinGetClass来获取当前窗口的类Class
; 然后调用%Class%_CheckMode(),如在TC中会调用TTOTAL_CMD_CheckMode()
; 如果函数返回真，则相当于编辑模式，如果函数返回False，则普通模式

; 以下以控制notepad.exe为例子
Notepad_CheckMode()
{
	ControlGetFocus,ctrl,AHK_CLASS NotePad
	If RegExMatch(ctrl,"Edit")
		Return True
	return False
}

; 每个插件里可以带至少一个动作，动作以标签形式进行描述
; 下面的<TempAction1>标签就是Temp.ahk里的一个动作
<TempAction1>:
	TempAction1()
return
; 建议通过标签调用函数，这样可以减少不同人员开发的插件之间全局变量的影响
TempAction1()
{
	Msgbox % "Hello World"
}
; VimCore的API
; =======================================================

; RegisterHotkey(Scope,Key,Action,ViClass)
; 注册热键功能，定义的热键将会有模式的控制
; -------------------------------------------------------

; Scope  作用域 用S代表全局可用，用H代表只在ViClass类的窗口中可用
; Key    热键，可以是单键，组合键,区分大小写
;        单键  a    b    c    1    ,  <ctrl>a <alt>b 等...
;        组合键  ga  oK    JK  J<ctrl>j<lwin>k 等...
; Action 动作，热键对应的动作，一般是这样形式的："<TempAcion1>"
; ViClass  窗口类，可以通过AHK的Windows Spy查看对应的窗口类，如果Scope指定为H的时候，注册的热键将只在ViClass变量对应的窗口类中生效

; =======================================================

; SetHotKey(sKey,sAction,Class)
; 设置热键，与RegisterHotkey()区分开来,通过此函数定义的热键不受模式影响
; 一般用于设置Esc，如SetHotkey("Escape","<Esc_TC>","TTOTAL_CMD")

; -------------------------------------------------------
; sKey   热键,只能是单键，而且不支持<ctrl><alt><shift><win>
;        只能是AHK支持的热键变体
; sAction 动作，热键对应动作。
; Class  定义SetHotkey()函数的热键对应生效的窗口类

; =======================================================
