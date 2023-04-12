
class Box{
  String type;
  int x,y,w,h;
  boolean isAThingRightNow;
  boolean Bad;
  Box(int x,int y,int w,int h){
    this.x=x;this.y=y;
    this.w=w;this.h=h;
    Bad = false;
    isAThingRightNow = true;
    type = "Box";
  }
  boolean Intersects(int px,int py){
    if(px<this.x)return false;
    if(py<this.y)return false;
    if(px>this.x+this.w)return false;
    if(py>this.y+this.h)return false;
    return true;
  }
  boolean Intersects(int px,int py,int pw,int ph){
    if(px+pw<this.x)return false;
    if(py+ph<this.y)return false;
    if(px>this.x+this.w)return false;
    if(py>this.y+this.h)return false;
    return true;
  }
  void display(){
    if(!isAThingRightNow)return;
    if(Bad)fill(255,0,0);
    else fill(255);
    rect(x,y,w,h);
  }
}

class SpawnPointTrigger extends Box{
  SpawnPointTrigger(int x,int y){
    super(x-20,y-20,40,40);
    type = "SP";
  }
  void display(){
    if(!isAThingRightNow)return;
    fill(0,0,255);
    rect(x,y,w,h);
  }
}

class BetterBox extends Box{
  int time, nextTime;
  BetterBox(int x,int y,int w,int h, int startTime, int TimeBetween){
    super(x,y,w,h);
    time = startTime;
    nextTime = TimeBetween;
  }
  void display(){
    time++;
    if(time >= nextTime){
      isAThingRightNow = !isAThingRightNow;
      time=0;
    }
    super.display();
  }
}
