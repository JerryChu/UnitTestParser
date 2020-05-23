# UnitTestParser

单元测试数据解析脚本&工具，快速解析单元测试执行概况及各种维度的代码覆盖率。

> [UnitTestDemo](https://github.com/JerryChu/UnitTestDemo) 项目是单元测试及覆盖率统计的Demo工程，可以使用该工程进行本项目提供的脚本的学习和使用。

## 特性

- 解析单元测试执行概况
- 解析代码覆盖率
- 解析增量代码覆盖率（TODO）
- 解析个人代码覆盖率（TODO）
- 模块分模块代码覆盖率

## 单元测试执行概况

获取单元测试方法个数、执行失败个数、执行时长等。

```shell
ruby unitTestInfo.rb --xcresult-path=path/to/xcresult_file --output-file=/path/to/output_file
```

参考 [单元测试结果数据解析文档](./docs/UnitTestInfo.md)

## 代码覆盖率

获取整体覆盖率以及各个target的代码覆盖率数据。

```shell
ruby targetCoverage.rb --cov-json-path=path/to/json_file --output-file=path/to/output_file
```

参考 [代码覆盖率解析文档](./docs/targetCoverage.md)

- 增量代码覆盖率

- 个人代码覆盖率

- 分模块代码覆盖率
