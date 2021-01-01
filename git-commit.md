git与语义化规范
Git commit规范

作用：

能加快 Code Review 的流程
根据 Git Commit 的元数据生成 Changelog
后续维护者可以知道 Feature 被修改的原因
技术方案



提交的格式要求

一般来说



 

 

type
type 代表了某次提交的类型，比如是修复一个 bug 还是增加了一个新的 feature。所有的type 类型如下：

feat：新增 feature
fix：修复 bug
docs：仅仅修改了文档，比如 README、CHANGLELOG 等等
style：仅仅修改了空格、格式缩进、多行等等，不改变逻辑
refactor：代码重构，没有加新的功能或者修复 bug
perf：优化相关，比如提升性能、体验等
test：测试用例，包括单元测试、集成测试等
chore：改变构建流程，或者增加依赖库、工具等
revert：回滚到上一个版本
Scope
scope 字段用于说明本次 commit 所影响的范围，比如视图层、数据模型或者路由模块等，是一个可选参数。

subject
:
