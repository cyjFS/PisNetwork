# PisNetwork
==========
简单的get/post请求网络数据方法，内有json->model
---------------------------------------

导入network文件夹，这里只展示get方法
![](https://github.com/cyjFS/PisNetwork/raw/master/PisNetwork/1.png)

startCallBack中可以写加载动画，errorCallBack中写些关于加载失败的

这里的successCallBack中的BaseClass是用JSON Accelerator自动生成的model文件,modelObjectWithDictionary也是自动生成的方法，可以直接将json转变为Model

![](https://github.com/cyjFS/PisNetwork/raw/master/PisNetwork/2.png)

这是搜索豆瓣音乐api用JSON Accelerator工具自动生成的一些文件

项目中有自带的json->model方法，这里就不展示了，在network文件夹下JSON文件夹里
