## 代码覆盖率统计

>  建议先阅读[单元测试结果数据解析文档](./unitTestInfo.md)。

统计整体代码覆盖率以及各个target的代码覆盖率数据。


### 解析代码覆盖率文件

使用苹果官方提供的命令行工具`xccov`即可完成代码覆盖率的解析。解析后我们接可以获取到整体的代码覆盖率及各个模块的代码覆盖率。

```
xcrun xccov view --report --json #{xcresult_path} > #{json_path}
```

拿到json文件后，我们就可以通过解析json文件来获取代码覆盖率。  
我们使用 [*moduleCov.rb*](https://git.code.oa.com/QQNews_iOS/AwesomeDevOps/blob/master/unit_test/moduleCov.rb) 来解析整体代码覆盖率和分模块的代码覆盖率。

```
# 传入文件为使用`xccov`解析之后的json文件
ruby moduleCov.rb --cov-json-path=path/to/json_file --output-file=path/to/output_file
```

例如执行：

```
╰─± ruby moduleCov.rb --cov-json-path=result.json --output-file=result.html
```

我们就可以得到如下的结果：

> 第一行展示总体数据，后面每一行都展示各模块的数据。模块及模块负责人定义在 *QQNews_Tests/MODULE_OWNER.yml* 文件中，是腾讯新闻iOS客户端特有的统计。其他业务可以参考实现自己的模块覆盖率检测。

```
模块	    代码覆盖率	非UI代码覆盖率	测试用例数	负责人
All	        13.2%	   15.0%	      792	
Common	    25.2%	   28.0%          61	yuanxuhan, jerrychu
QNListKit	52.0%	   76.5%	      35	jerrychu
QNLottie	54.9%	   54.9%	      26	yuanxuhan
......
```
