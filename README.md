# MOEMO

在多模态优化任务中，主要目的是寻找多个最优解(全局和局部)，以便用户在搜索空间中更好地了解不同的最优解，当需要时，可以将当前的解切换到另一个合适的最优解。进化优化算法(EA)之所以成为可行的方法，主要是因为它们能够在一次模拟运行中发现和捕获种群中的多个解决方案。在本文中,我们使用一个完全不同的策略，在单目标多峰优化问题转化为一个合适的二元目标优化问题，其中第一个目标为原问题的函数值，第二个目标来体现个体的多样性。并且提出了一种基于均值漂移的聚类方法进行检测峰点，寻找可能存在最优解的峰值。最后在近似适应度范围内的检测峰内进行局部搜索。并且在CEC2020的20个测试函数进行实验，由实验结果可以看出有较好的结果。

该算法是在EMO-MMO的基础上修改的。

- `main.m`：算法主函数

- `MMO_main.m`：一次算法的函数
- `Fun_info.m`：返回不同测试函数的信息
- `Fun_value.m`：计算元MMO的函数值

- 多目标优化算法(MOP)
  - `Initialization.m`：初始化种群
  - `MatingSelection.m`：生成mating pool
  - `EnvironmentalSelection.m`：环境选择(非支配排序+拥挤度选择)
  - `NDSort.m`：非支配排序
  - `CalculCrowdDistance.m`：拥挤度选择
  - `Reproduction.m`：复制产生后代
  - `second_d.m`：计算第二维多样性指标
- `cluster.m`：mean shift聚类算法
- 局部搜索
  - `CSO.m`：采用粒子群算法
- `Print.m`：根据结果生成每次run的结果文件
- `data_read.m`：根据结果文件统计数据
- `draww.m`：在report中插图的代码

