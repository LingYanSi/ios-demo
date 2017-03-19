//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// let 表示常量 常量不可变
let A = 1

// var 表示变量 swift不要求每次都声明数据类型，系统会自动做首次的类型推断
str = "哈哈哈"
// print 用来log输出
print(str, A)


//: s不同 swift不会在if 语句对条件结果进行类型转换 要求其必须是Boolean类型

if true {
    print("我是if语句")
}

// 元组tuples 类似于js中数组与对象的合体， 可以使用结构赋值，结构赋值时左右元素必须相等，可用_表示省略
var tuples = (1, "sss", c: "2222")
var (a, b, _) = tuples
    
print(a, b, tuples.0 == a, tuples.c == tuples.1)

// function 

// Error Try Catch
// 枚举定义错误类型，以及错误的集中情况
enum FuckError: Error {
    case ageError
    // 可传递参数
    case ageOldError(MAX_AGE: Int)
}

func Fuck(name: String, age: Int) throws {
    let MIN_AGE = 14
    if age < MIN_AGE {
        print("\(name)的年级不足\(MIN_AGE)，不能被fuck")
        throw FuckError.ageError
    } else if age > 60 {
        // 传递参数
        throw FuckError.ageOldError(MAX_AGE: 60)
    }
}

do {
    // 如果try出错，则不会继续往下执行
    try Fuck(name: "dog", age: 12)
    try Fuck(name: "dog", age: 100)
} catch FuckError.ageError {
    print("sorry you are too young")
} catch FuckError.ageOldError( let age ) {
     print("sorry \(age) are too old")
}

// 运算符 ?? 表示nilH如果没有值，就取xx作为默认值
var nilH : String?
var xx = nilH ?? "xx"

// 区间运算符 1-5的所有值
for i in 1...5 {
    print("\(i)")
}
// 半开区间运算符 不包含3
for i in 1..<3 {
    print(i)
}

// 字符串
// Character 表示单字符 字符串
var singleStr : Character
singleStr = "!"
var Str = "sss"
// 添加
Str.append(singleStr)
print(Str)
// 是否为空
Str.isEmpty
// 插入指定位置
Str.insert(singleStr, at: Str.endIndex)
Str.insert(contentsOf: Str.characters, at: Str.startIndex)

// 以ss开头
Str.hasPrefix("ss")
// 以!结尾
Str.hasSuffix("!")
// 是否包含
Str.contains("ss")

// 数组 有序的同类型元素的集合
var arr: [Int] = [1, 2, 3]
var arr1 = Array(repeating: 11, count: 3)
arr1.append(1)
arr1.remove(at: 0)
// 数组合并
arr1 += arr
// 更该数组
arr1[0] = 10000
arr1[1...3] = [-1, -2, -3]
arr1.insert(111, at: 0)
arr1.count

// 遍历数组
for item in arr1 {
    print(item)
}

// set <Int> 无序不重复的集合
var set: Set<String> = ["1", "2", "1"]
set.insert("3") // 添加
set.remove("2") // 删除
set.sorted()
set.removeAll() // 删除全部

set = ["1", "2", "3"]
var set1: Set<String> = ["2", "5"]
set.intersection(set1) // 得到重叠部分
set.symmetricDifference(set1) // 两个Set不重叠的部分
set.union(set1) // 得到所有
set.subtract(set1) // 得到set中和set1不重叠的部分

/*
 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)
 */

// 字典 Dictionary key -> value
var dic = [String: Int]()
dic["name"] = 1
dic.count
// 置空
dic = [:]
var dic1: [String: String] = ["ss": "hahha"]
// 遍历
for (key, value) in dic1 {
    print("\(key) --> \(value)")
}

for key in dic1.keys {
    print(key)
}

for value in dic1.values {
    print(value)
}

// 条件控制
var num = 0
while num < 2 {
    print(num)
    num += 1
}

// repeat - while 和js中的do while一样
repeat {
    print(num)
    num += 1
} while num < 5

// switch swift中的case语句结尾不用声明break，swift会帮你做这件事情，不过你可以在语句的
// 中间位值提前break
func switchMatch(num: Int) {
    switch num {
    // 可以有多个值
    case 1, 2 ,3 ,4 ,5:
        print(1, "to little")
    case 6...10:
        print("range 匹配")
    case 5:
        print(5, "just so so")
        // 也可以是元组数据
    //case (1, 2):
      //  print("元组数据")
    // default为必须的
    default:
        print("default state")
    }
}
switchMatch(num: 1)

switchMatch(num: 7)

// guard语句 guard语句当条件被满足时执行guard后面的语句，反则执行else内语句
// else内语句需要退出当前scope
func testGuard(num : Int) {
    print("\(num)")
    guard num > 100 else {
        print("guard语句")
        return
    }
    
    print("\(num)大于100")
}
testGuard(num: 50)

if #available(iOS 1.0, *) {
    print("版本高于\(9.0)")
}

// 函数
// 参数需要制定数据类型
// 可设置默认值
// 可设置是否忽略参数标签
func testFunc (num: Int, str: String, defaultValue: String = "张无忌", _ ignoreArgTag: Int = 17) -> String {
    return "\(str) 今年 \(num) 岁了 \(defaultValue) 今年 \(ignoreArgTag)了"
}
let FUCK_STR = testFunc(num: 16, str: "周纸条", defaultValue: "赵敏", 19)

// 可变参数，表示可以传递多个同类型参数
func max(_ num: Int...) -> Int {
    
    return 1
}

// 函数类型 swift中函数可以作为：参数，或者返回值
var funcType: (Int, String) -> String
func Hah(age: Int, name: String) -> String {
    return "aa"
}

funcType = Hah

// swift中函数可以作为：参数，或者返回值
func testFunc(addNums: (Int...) -> Int, num: inout Int) -> (Int, String) -> String {
    num = 1
    // 函数参数在函数体内被隐式得得使用let声明，因此不可被修改
    addNums(num, num, num)
    
    // 函数内部也可以定义函数
    func funcType(age: Int, name: String) -> String {
        return "aa"
    }
    
    return funcType
}

func fuck(nums: Int...) -> Int {
    return 100
}

var fuckInoutNum = 1
testFunc(addNums:fuck , num: &fuckInoutNum)(100, "sss")

// 闭包 arguments in returnType statement
var clourse = [1, 2, 3].map({ $0 + 2 })
print(clourse)
// sort是对自身进行排序
clourse.sort(by: {$0 > $1})
print(clourse)

// struct 与 class struct是值类型 class是引用类型
struct FuckStruct {
    var name: String
    let length = 1
}

var fStruct = FuckStruct(name: "周")
fStruct.name
fStruct.length

class Ainmal {
    var name: String = ""
    // 防止被override
    final var type = "animal"
    // 类似于js中的get
    var intro: String {
        return "my name is \(name)"
    }
    
    init(nameStr: String){
        name = nameStr
    }
    
    func fuck(){
        print("哈哈")
    }
}

class Person {
    final var type = "people"
    var name = ""
    var intro : String {
        return name
    }
    init(){
        self.name = "哈哈哈"
    }
}

// 不支持多继承
class Pig : Ainmal {
    init(name: String){
        // 调用父类初始化
        super.init(nameStr: name)
    }
    // 重写
    override func fuck () {
        print("i dont know say what")
    }
    deinit {
        print("实例被垃圾回收前执行")
    }
}

var pig = Pig(name: "金正恩")
pig.fuck()
pig.intro

// as转换类型
let r = 0 as? Double
print(r!)










