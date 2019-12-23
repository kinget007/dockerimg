FROM selenium/node-chrome:3.141.59-yttrium
#改变node的启动参数
ENV NODE_MAX_INSTANCES 10
ENV NODE_MAX_SESSION 10
# 配置中文
RUN sudo locale-gen zh_CN.UTF-8 &&\
 sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN sudo locale-gen zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8
#更新软件包索引
RUN sudo apt-get update -qqy
#安装基本字体
RUN sudo apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable
#安装文泉驿微米黑字体
RUN sudo apt-get -qqy install ttf-wqy-microhei \
  && sudo ln /etc/fonts/conf.d/65-wqy-microhei.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf
