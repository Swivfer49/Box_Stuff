PVector SpawnPoint, LoadPoint;

float PlayerSpeed = 0.8;
float FloorFriction = 0.4;
float WallFriction = 0.9;
int DoubleJumps;
int KFrames = 5;



void mousePressed(){
  pos.set(mouseX+CurrentRoom.x*1000,mouseY+CurrentRoom.y*1000);
  ppos.set(mouseX+CurrentRoom.x*1000,mouseY+CurrentRoom.y*1000);
  DJ=10;
}
int hor = 0;
boolean A=false,D=false,W=false,S=false;
int DJ = 0;
int kf = 0;

void keyPressed(){
  if(key == 'a'){
    if(!A){
      A=true;hor-=1;
    }
  }
  else if(key == 'd'){
    if(!D){
      D=true;hor+=1;
    }
  }
  if(key == 'w'){
    if(!W){
      if(down){
        W=true;DJ=DoubleJumps;
        acc.add(0,-10);
        kf=0;
        Effect((int)(pos.x+hw),(int)(pos.y+hh),40,color(255),5);
      }else if(left){
        W=true;DJ=DoubleJumps;
        acc.add(10,-15);
        kf=0;
        Effect((int)(pos.x+hw),(int)(pos.y+hh),40,color(255),5);
      }else if(right){
        W=true;DJ=DoubleJumps;
        acc.add(-10,-15);
        kf=0;
        Effect((int)(pos.x+hw),(int)(pos.y+hh),40,color(255),5);
      }else if(kf>0){
        W=true;DJ=DoubleJumps;
        acc.add(0,-12);
        kf=0;
        Effect((int)(pos.x+hw),(int)(pos.y+hh),40,color(255),5);
      }
      else if(DJ>0){
        W=true;DJ--;
        acc.add(0,-10);
        Effect((int)(pos.x+hw),(int)(pos.y+hh),40,color(255),5);
        ppos.y = pos.y;
      }
      
    }
    
  }
}
void keyReleased(){
  if(key == 'a'){
    A=false;hor+=1;
  }
  else if(key == 'd'){
    D=false;hor-=1;
  }else if(key == 'w'){
    W = false;
  }
}


PVector pos = new PVector(500,500)
,ppos = new PVector(500,500)
, acc = new PVector();
int w = 25,h = 25;
float hw = w/2, hh = h/2;
void Update(){
  if(down||left||right){
    kf = KFrames;
  }else{
    kf--;
    if(kf<0)kf = 0;
  }
  UpdatePlayer();
  if(!((int)pos.x == (int)ppos.x&&(int)pos.y == (int)ppos.y)){
    Particles.add(new Particle((int)(pos.x+hw),(int)(pos.y+hh), 20, 30, color(255), ppos.x-pos.x, ppos.y-pos.y));
  }
  down=false;
  up=false;
  left=false;
  right=false;
  fill(255);
  Room r = GetRoom();
  if(r!=null){
    translate(r.x*-1000,r.y*-1000);
    for(int i=0;i<r.Boxes.length;i++){
      Box b = r.Boxes[i];
      CollidePLayer(b);
      b.display();
    }
  }
  fill(255);
  rect(pos.x,pos.y,w,h);
  if(up)pos.y++;
  if(left && hor>0)pos.x+=0.5;
}

boolean up = false,down=false,left=false,right=false;

void UpdatePlayer(){
  float vx = (pos.x - ppos.x) + acc.x;
  float vy = (pos.y - ppos.y) + acc.y;
  if((down)&&hor==0)vx*=FloorFriction;
  if(left||right)vy*=WallFriction;
  if(hor!=0)vx = constrain(vx+hor*PlayerSpeed,-10,10);
  ppos.set(pos.x,pos.y);
  pos.add(vx,vy);
  acc.set(0,0.5);
}

void Die(){
    Effect((int)(pos.x+hw),(int)(pos.y+hh),40,color(255,0,0),10);
    pos.set(SpawnPoint);
    ppos.set(SpawnPoint);
}

void CollidePLayer(Box box){
  if(!box.isAThingRightNow)return;
  if(!box.Intersects(int(pos.x),int(pos.y),w,h))return;
  if(box.Bad){
    Die();
    return;
  }
  else if(box.type == "SP"){
    SpawnPoint.set(box.x+20,box.y+20);
    Effect((int)(box.x+20),(int)(box.y+20),40,color(0,0,255),10);
    box.isAThingRightNow = false;
    return;
  }
  
  float x1 = (box.x + box.w) - pos.x;
  float x2 = (pos.x + w) - box.x;
  float y1 = (box.y + box.h) - pos.y;
  float y2 = (pos.y + h) - box.y;
  
  float mx, my, wi, he;
  
  if(x1<x2){
    mx = x1;
    wi = x1;
  }else{
    mx = -x2;
    wi = x2;
  }
  if(y1<=y2){
    my = y1;
    he = y1;
  }else{
    my = -y2;
    he = y2;
  }
  if(wi<=he){
    pos.x+=mx;
    if(pos.x==box.x+box.w)
    left=true;
    else right=true;
    DJ = DoubleJumps;
  }
  if(he<=wi){
    pos.y+=my;
    if(pos.y==box.y+box.h)
    up=true;
    else {
      down=true;
      DJ = DoubleJumps;
    }
  }
}
