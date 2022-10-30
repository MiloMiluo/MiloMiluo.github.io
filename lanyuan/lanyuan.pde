// 全局变量
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;

// 初始化Processing画布
void setup(){
  size( 500, 500 );//画布尺寸
  strokeWeight( 10 );
  frameRate( 15 );
  X = width / 2;//初始位置
  Y = width / 2;
  nX = X;
  nY = Y;  
}

// 画图
void draw(){

  radius = radius + sin( frameCount / 4 );

  // 追踪新的坐标位置
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;

  // 背景色
  background( 100 );

  // 圆圈色
  fill( 0, 121, 184 );

  // 圆圈边框色
  stroke(255); 

  // 圆圈
  ellipse( X, Y, radius, radius );                  
}


// 设置圆圈的下一位置
void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}
