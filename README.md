# SimpleNote

一个简单干净的LaTeX笔记模板。

模板基于[ElegantLaTeX](https://github.com/ElegantLaTeX/)，并对配置进行了整理和简化。


特点如下：

- 支持中英文，中文预设了几种开源字体方案
- 支持pdfLaTeX（仅英文）和XeLaTeX（中英文）

测试环境为：

- TeX Live 2023, Win11
- TeX Live 2023, WSL2(Ubuntu 22.04)
- TeX Live 2023, Overleaf

注意：在Linux上全局使用自定义模板时，可以将.cls文件存放的路径添加到相应的环境变量中，例如在.bashrc中添加
```bash
LATEX_PATH="path/to/simplenote"
export TEXINPUTS="${LATEX_PATH}/simplenote:${TEXINPUTS}"
```
