// PhotoPro.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "math.h"
#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "memory.h"
#include "cv.h"
#include "highgui.h"
#include <vector>

#define	a54 6378245.e0   //椭球长半轴
#define	b54 6356863.01877e0  //椭球短半轴
#define e2 (a54*a54-b54*b54)/(a54*a54)   //地球椭球偏心率
#define e1 sqrt((a54*a54-b54*b54)/(b54*b54))
#define M_PI 3.14159265359
#define pi atan(1.e0)*4.e0


void project(double blh[3],double xyH[3]);
struct CCD_CameraPara
{
	double f;//焦距
	double x0;//像主点
	double y0;//
	double pix;//ccD 尺寸

};
struct PosPar
{
	double X,Y,Z;//三维位置
	double al,om,ka;//三个姿态
};
int ImgxyToGcpXYByColline(CCD_CameraPara par,PosPar pos,double xy[2],double GrdHeight,double ResXYZ[2]);
void CalculatePerspectiveCoef(CvPoint2D64f xy[4],CvPoint2D64f xyz[4],CvMat  *Coef);
BYTE BiLinearInterpolation(IplImage* Raw,double lines,double cols);
IplImage* MosaicTwoImages(IplImage* rawImage1,IplImage* rawImage2,int offsetH,int offsetW);
int _tmain(int argc, _TCHAR* argv[])
{
	
	double xyH[3],blh[3];
	CCD_CameraPara par0;
	PosPar pos;
	blh[0]=45.402195*(pi)/180.0;
	blh[1]=124.794983*(pi)/180.0;
	blh[2]=383.0;
	pos.al=0.6;//0.7;侧滚角 右手抬起为正，左手抬起为负
	pos.om=-7.50;////俯仰角 仰正俯负
	pos.ka=270;//270.4;//航向角，航向角正北为正方向0度，顺时针+360度，属于左手系,计算中采用了右手系




	IplImage* CCDImg= cvLoadImage("E:\\拼航片\\10.11.25\\IMG_1045.jpg",1);


	project(blh,xyH);


	pos.X=xyH[1];//高斯东向
	pos.Y=xyH[0];//高斯北向
	pos.Z=blh[2];

	par0.f=24.0/1000.0;
	par0.x0=17.7607/1000.0;
	par0.y0=11.9095/1000.0;
	par0.pix=6.4e-6;


	
	




	CvPoint2D64f imgxy[4];
	CvPoint2D64f gcpxy[4];


	double rxy[2];
	double xy[2];
	xy[0]=0;//x:列向像坐标 	
	xy[1]=0;//y:航向像坐标 	

	ImgxyToGcpXYByColline(par0,pos,xy,50,rxy);
	imgxy[0].x=xy[0];
	imgxy[0].y=xy[1];
	gcpxy[0].x=rxy[0];//东向
	gcpxy[0].y=rxy[1];//北向


	xy[0]=CCDImg->width;
	xy[1]=0;
	ImgxyToGcpXYByColline(par0,pos,xy,50,rxy);
	imgxy[1].x=xy[0];
	imgxy[1].y=xy[1];
	gcpxy[1].x=rxy[0];
	gcpxy[1].y=rxy[1];


	xy[0]=0;
	xy[1]=CCDImg->height;
	ImgxyToGcpXYByColline(par0,pos,xy,50,rxy);
	imgxy[2].x=xy[0];
	imgxy[2].y=xy[1];
	gcpxy[2].x=rxy[0];
	gcpxy[2].y=rxy[1];


	xy[0]=CCDImg->width;
	xy[1]=CCDImg->height;
	ImgxyToGcpXYByColline(par0,pos,xy,50,rxy);
	imgxy[3].x=xy[0];
	imgxy[3].y=xy[1];
	gcpxy[3].x=rxy[0];
	gcpxy[3].y=rxy[1];



	double grdNorthMin,grdNorthMax;//地面北向坐标
	double grdEastMin,grdEastMax;//地面动向坐标
	grdNorthMin=2.0e10;
	grdEastMin=2.0e10;
	grdNorthMax=-2.0e10;
	grdEastMax=-2.0e10;
	int i;
	
	for(i=0;i<4;i++) 	
	{
		if (grdNorthMin>gcpxy[i].y)	grdNorthMin=gcpxy[i].y;
		if (grdEastMin>gcpxy[i].x)   grdEastMin=gcpxy[i].x;
		if (grdNorthMax<gcpxy[i].y)	grdNorthMax=gcpxy[i].y;
		if (grdEastMax<gcpxy[i].x)	grdEastMax=gcpxy[i].x;
	}
	


	int newline,newcolumn;
	float imgResolution=0.1;
	newline=(int)((grdNorthMax-grdNorthMin)/imgResolution)+1;
	newcolumn=(int)((grdEastMax-grdEastMin)/imgResolution)+1;

	IplImage* RectImage=cvCreateImage(cvSize(newcolumn,newline),IPL_DEPTH_8U,3);

	char *NewPic;
	NewPic=RectImage->imageData;
	int rectstep=RectImage->widthStep;

	CvMat *Coef;
	Coef=cvCreateMat(3,3,CV_32FC1);
	//int StartI,StartJ,EndI,EndJ;
	//double tt1,tt2,tt3;
	CvPoint2D64f Norm_gcpxy[4];

	for(int k=0;k<4;k++)
	{
		Norm_gcpxy[k].y=(grdNorthMax-gcpxy[k].y)/imgResolution;//行
		Norm_gcpxy[k].x=(gcpxy[k].x-grdEastMin)/imgResolution;//列

	}

	CalculatePerspectiveCoef(Norm_gcpxy,imgxy,Coef);
	cvWarpPerspective(CCDImg,RectImage,Coef,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,cvScalarAll(0));
//	printf("%lf %lf\n",grdNorthMax,grdEastMin);
	

	cvSaveImage("e:\\r1045.jpg",RectImage);
	cvReleaseImage(&CCDImg);
	cvReleaseImage(&RectImage);
//	cvReleaseImage(&CCdn);
	cvReleaseMat(&Coef);

//*/
	return 0;
}


BYTE BiLinearInterpolation(IplImage* Raw,double lines,double cols)
{
	long i0,j0;
	int gray;
	double xx;
	double x=lines;
	double y=cols;

	i0=(int)(x);//行
	j0=(int)(y);//列
	long int lWidth,lHeight;
	lWidth=Raw->widthStep;
	lHeight=Raw->height;
	char *RawImg=Raw->imageData;

	if ((((i0+1)*lWidth+j0+1)<=lWidth*lHeight)&&(i0*j0>=0))
	{
		int f00,f01,f10,f11;
		f00=RawImg[i0*lWidth+j0];
		f01=RawImg[i0*lWidth+j0+1];
		f10=RawImg[(i0+1)*lWidth+j0];
		f11=RawImg[(i0+1)*lWidth+j0+1];
		x=x-int(x);
		y=y-int(y);
		xx=(f10-f00)*x+(f01-f00)*y+(f11+f00-f01-f10)*x*y+f00;
		gray=f00;//(int)xx;
	}
	else gray=0;
	return(gray);
}
void project(double blh[3],double xyH[3])
{
	int zoneNum = (int)floor(blh[1]*30.0/(M_PI))+1.0;//先化度,再分6度带.
	double centralL = zoneNum*6-3.0;
	double FalseEast = zoneNum*1.0e6+500000;
	double B,L,sx,N,ita2,m,t,d;
	double A0,B0,C0,D0,E0;
	double e4,e6,e8,t2,t4,ita4;
	double gama;
	d=a54*(1-e2);
	B=blh[0];
	L=blh[1]*180/(pi);
	ita2=e1*e1*cos(B)*cos(B);
	t=tan(B);
	t2=t*t;
	t4=t2*t2;
	ita4=ita2*ita2;
	N=a54/(sqrt(1-e2))/sqrt(1+ita2);
	m=cos(B)*(pi)/180.0*(L-centralL);

	e4=e2*e2;
	e6=e4*e2;
	e8=e6*e2;
	A0=d*(1+0.75e0*e2+45.e0/64.e0*e4+175.e0/256.e0*e6+11025.e0/16384.e0*e8);
	B0=A0-d;
	C0=d*(15.e0/32.e0*e4+175.e0/368.e0*e6+3675.e0/8192.e0*e8);
	D0=d*(35.e0/96.e0*e6+735.e0/2048.e0*e8);
	E0=d*(315.e0/1024.e0*e8);
	sx=A0*B-(B0+C0*sin(B)*sin(B)+D0*sin(B)*sin(B)*sin(B)*sin(B)+E0*sin(B)*sin(B)*sin(B)*sin(B)*sin(B)*sin(B))*sin(B)*cos(B);
	xyH[0]=sx+N*t*(0.5e0*pow(m,2.e0)+1.e0/24.e0*(5.e0-t2+9.e0*ita2+4.e0*ita4)*pow(m,4.0)+(61.e0-58.e0*t2+t4)*pow(m,6.0)/720.e0);
	xyH[1]=N*(m+(1.0-t2+ita2)*pow(m,3.0)/6.e0+(5.0-18.0*t2+t4+14.0*ita2-58.0*ita2*t2)*pow(m,5.0)/120.0);
	xyH[1]=xyH[1]+FalseEast;
	double namada;
	namada=((L-centralL)*3600.0)/206265.0;
	gama=namada*sin(B)+namada*namada*namada*sin(B)*cos(B)*cos(B)*(1.0+3.0*ita2)/3.0;
	gama=gama*180.0/(pi);
	xyH[2]=blh[2];
}


int ImgxyToGcpXYByColline(CCD_CameraPara par,PosPar pos,double xy[2],double GrdHeight,double ResXYZ[2])
{
	double f,x,y;
	double a1,a2,a3,b1,b2,b3,c1,c2,c3,om,al,ka;
	double Xs,Ys,Zs;
	double Xt,Yt,Zt,Dx,Dy,Dz;
	double dtemp1,dtemp2;





	/** 地面坐标- 右手系

	        Y 北向
            /\
            |
            |
			|
            |
------------O------------------->X东向
            |
            |
            |
            |
			*/
	

	Xs=pos.X;//东向   2013-10-31 采用了右手系的地面坐标和图像坐标
	Ys=pos.Y;//北向
	Zs=pos.Z;

	al=pos.al;//姿态 传进来为度  侧滚
	om=pos.om;//俯仰
	ka=pos.ka;//航向 0-360的左手系


	double Llithita;//参考的航向角度

	if(ka>=0.0&&ka<45.0) Llithita=0.0e0;
	if(ka>=45.0&&ka<135.0) Llithita=M_PI/2.0e0;
	if(ka>=135.0&&ka<225.0) Llithita=M_PI;
	if(ka>=225.0&&ka<=315.0) Llithita=1.5e0*M_PI;
	if(ka>=315.0&&ka<360.0) Llithita=2.0e0*M_PI;

	ka=Llithita-(ka*(M_PI)/180.e0);//根据参考航向计算偏航 改成了右手系

	om=om*(M_PI)/180.e0;
	al=al*(M_PI)/180.e0;
	x=xy[0]*par.pix-par.x0;//x:计算中心化的列向像坐标 	右手系
	y=par.y0-xy[1]*par.pix;//y:计算中心化的航向像坐标 	



	f=par.f;//焦距
	Zt=GrdHeight;//地面平均高度

	  
	a1=cos(al)*cos(ka)-sin(al)*sin(om)*sin(ka);
	a2=-cos(al)*sin(ka)-sin(al)*sin(om)*cos(ka);

	a3=-sin(al)*cos(om);

	b1=cos(om)*sin(ka);
	b2=cos(om)*cos(ka);

	b3=-sin(om);

	c1=sin(al)*cos(ka)+cos(al)*sin(om)*sin(ka);
	c2=-sin(al)*sin(ka)+cos(al)*sin(om)*cos(ka);


	c3=cos(al)*cos(om);

	Dz=Zt-Zs;
	dtemp1=(a1*x+a2*y-a3*f);
	dtemp2=c1*x+c2*y-c3*f;
	Dx=Dz*dtemp1/dtemp2;//东向/旁向 增量 
	dtemp1=(b1*x+b2*y-b3*f);
	Dy=Dz*dtemp1/dtemp2;//北行/航向 增量
//	printf("%lf %lf %lf %lf\n",x,y,Dx,Dy);

	Xt=Xs+cos(Llithita)*Dx+sin(Llithita)*Dy;//东向/旁向 
	Yt=Ys-sin(Llithita)*Dx+cos(Llithita)*Dy;//北行/航向2013-11-31 确认这种方法较为科学

	
	ResXYZ[0]=Xt;//东向
	ResXYZ[1]=Yt;//北向
	return(0);

}



void CalculatePerspectiveCoef(CvPoint2D64f xy[4],CvPoint2D64f xyz[4],CvMat  *Coef)
{
	int i;
	CvPoint2D32f srr[4];
	CvPoint2D32f dst[4];

	for(i=0;i<4;i++)
	{
		srr[i].x=xyz[i].x;
		srr[i].y=xyz[i].y;
		dst[i].x=xy[i].x;
		dst[i].y=xy[i].y;

	}
	cvGetPerspectiveTransform(srr,dst,Coef);

}

