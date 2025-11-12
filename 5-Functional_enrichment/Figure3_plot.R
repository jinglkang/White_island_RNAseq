library(ggsci)
library(gridExtra)
library(stringr)
library(data.table)
library(ggplot2)
library(ggVennDiagram)
library(ggpubr)

# pH
setwd("5-Functional_enrichment/")
cts <- read.table(file="WI_sample_pH.txt",header=TRUE,sep = "\t")
names(cts)
cts$Site
pos <- position_jitter(width = 0.2, seed = 1)
p1<-ggplot(cts,aes(x=Site,y=pH..Mettler., colour=Site)) +
  theme_bw() + geom_boxplot(lwd=0.7,width=0.5) + geom_point(size=3, position = pos,shape=1)+
  theme(axis.text.x=element_text(colour="black",family="Times",size=20), #设置x轴刻度标签的字体显示倾斜角度为15度，并向下调整1(hjust = 1)，字体簇为Times大小为20
        axis.title.x=element_blank(),
        axis.text.y=element_text(family="Times",size=18,face="plain",colour = "black"), #设置y轴刻度标签的字体簇，字体大小，字体样式为plain
        axis.title.y=element_text(family="Times",size = 20,face="plain"), #设置y轴标题的字体属性
        legend.position = "", panel.border = element_blank()) +
  theme(axis.line = element_line(color = 'black')) +
  #scale_color_manual(name = "Site", values = c("Vs"="#E64B35FF","Cs"= "#1B1919FF", "wVn"="#109910")) +
  theme(strip.text.y = element_text(face="plain", family="Times", colour="black", size=12)) + #设置图例的子标题的字体属性
  theme(legend.text = element_text(family="Times",size = 13,face="plain"),
        legend.title = element_text(family="Times",size = 13,face="plain"),
        axis.ticks.length=unit(.25, "cm")) +
  ylab("pH") + scale_color_nejm()
p1

# DEGs nb
data<-read.table("DEGs_num_barplot.txt",header = TRUE,sep = "\t")
head(data)
p2<-ggplot(data, aes(x=Species, y=Num,fill=Type)) + 
  geom_bar(stat = "identity", position = "dodge",width = 0.5)+ theme_bw() +
  xlab("") + theme_classic()+
  theme(axis.text.x=element_text(colour="black",family="Times",size=15), #设置x轴刻度标签的字体显示倾斜角度为15度，并向下调整1(hjust = 1)，字体簇为Times大小为20
        axis.text.y=element_text(family="Times",size=15,face="plain",colour = "black"), #设置y轴刻度标签的字体簇，字体大小，字体样式为plain
        axis.title.y=element_text(family="Times",size = 15,face="plain"), #设置y轴标题的字体属性
        axis.ticks.length=unit(.2, "cm"), # set tick length
        # panel.border = element_blank(),axis.line = element_line(colour = "black"), #去除默认填充的灰色，并将x=0轴和y=0轴加粗显示(size=1)
        legend.text=element_text(face="plain", family="Times", colour="black", size=15),  #设置图例的子标题的字体属性
        legend.title=element_text(face="plain", family="Times", colour="black", size=15), #设置图例的总标题的字体属性
        panel.grid.major = element_blank(), legend.position = c(0.15,0.88),  #不显示网格线
        panel.grid.minor = element_blank())+ylab("DEGs number") +  
  scale_fill_manual(name = "Type", values = c("1V1 vs. Control" = "#925E9F",
                                              "2V2 vs. Control" = "#0099B4"))
p2

# DEGs overlap
dat <- read.table("../DEGs_all_spe.txt",header=TRUE,sep="\t",fill=TRUE, na.strings = "")
library(VennDiagram)
Blenny <- dat$blenny[!is.na(dat$blenny)]
Blueeyed <- dat$blue.eyed[!is.na(dat$blue.eyed)]
Common <- dat$Common[!is.na(dat$Common)]
Yaldwyn <- dat$Yaldwin[!is.na(dat$Yaldwin)]
venn.plot<-venn.diagram(list(Blenny=Blenny,Blueeyed=Blueeyed,Common=Common, Yaldwin=Yaldwin), 
                        fill=c("#EE0000","#008B4F","#631879","#008280"),filename = NULL, cex=2, cat.cex=2)
pdf(file="venn_DEGs.pdf")
grid.draw(venn.plot)
dev.off()

# GO function
data<-read.table("../Enrichment/Consistent_sigFunc_plot.txt",header = TRUE,sep = "\t")
pd <- position_dodge(0.7)
p3<-ggplot(data,aes(Species,-log10(FDR),group=Type,colour=Type,size=Gene_num))+ 
  theme_bw()+ facet_wrap(.~Cmp, ncol=2) + #背景变为白色
  geom_point(position=pd)+
  theme(axis.text.x=element_text(colour="black",family="Times",size=16), #设置x轴刻度标签的字体显示倾斜角度为15度，并向下调整1(hjust = 1)，字体簇为Times大小为20
        axis.text.y=element_text(family="Times",size=18,face="plain",colour = "black"), #设置y轴刻度标签的字体簇，字体大小，字体样式为plain
        axis.title.y=element_text(family="Times",size = 20,face="plain"), #设置y轴标题的字体属性
        panel.border = element_blank(),axis.line = element_line(colour = "black"), #去除默认填充的灰色，并将x=0轴和y=0轴加粗显示(size=1)
        legend.text=element_text(face="plain", family="Times", colour="black", size=18), #设置图例的子标题的字体属性
        legend.title=element_text(face="plain", family="Times", colour="black", size=18), #设置图例的总标题的字体属性
        legend.position = "right",
        # panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank())+  #不显示网格线
  #geom_hline(yintercept=2, linetype="dashed")+
  geom_hline(yintercept=1.3, linetype="dashed")+
  ylab("-log(FDR)")+xlab("")+ 
  theme(strip.text = element_text(face="plain", family="Times", colour="black", size=18),
        strip.background = element_rect(color = "white"))+
  scale_color_manual(name = "Type", values = c("1Circadian rhythm" = "#AD002A",
                                               "2Vision perception"="#EFC000",
                                               "3Energy metabolism"="#00468B",
                                               "4Stimulus response"="#3B3B3B"))
p3

p4<-ggarrange(p1,p2,ncol = 2, nrow = 1, widths = c(1,2), heights = c(1,1),
              common.legend = T,align ="hv", 
              font.label=list(size = 14, color = "black", face = "bold",family="Times"))
p5<-ggarrange(p2,p3,ncol = 2, nrow = 1, widths = c(1,2), heights = c(1,1),
              common.legend = F,align ="hv", 
              font.label=list(size = 14, color = "black", face = "bold",family="Times"))


ggarrange(p4,p5,ncol = 1, nrow = 2, widths = c(1,1), heights = c(1,1),
          common.legend = F,align ="hv", labels="AUTO",
          font.label=list(size = 14, color = "black", face = "bold",family="Times"))

# only plot DEGs number and GO functions
p4<-ggarrange(p2,p2,ncol = 2, nrow = 1, widths = c(1,1), heights = c(1,1),
              common.legend = T,align ="hv", 
              font.label=list(size = 14, color = "black", face = "bold",family="Times"))
ggarrange(p4,p3,ncol = 1, nrow = 2, widths = c(1,1), heights = c(1,1),
              common.legend = F,align ="hv", 
              font.label=list(size = 14, color = "black", face = "bold",family="Times"))
