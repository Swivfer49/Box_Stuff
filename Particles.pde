ArrayList<Particle> Particles = new ArrayList<Particle>();



void UpdateParticles(){
  int s = Particles.size();
  for(int i = s - 1; i >= 0; i--){
    Particle p = Particles.get(i);
    p.Update();
    if(p.time<1){
      Particles.remove(i);
    }
  }
}

void Effect(int x, int y, int count, color c, float force){
  for(int i=0;i<count; i++){
    float fforce = force * random(0,2);
    PVector vel = PVector.fromAngle(radians(random(0,360)));
    Particle p = new Particle(x,y,(int)random(10,50), (int)random(20,70), c, 
    vel.x*fforce, vel.y*fforce);
    Particles.add(p);
  }
}

class Particle{
  int x, y, w, time;
  PVector vel;
  int r, g, b;
  float timeWidthRatio;
  float timeAlphaRatio;
  
  Particle(int x, int y, int w, int time, color c, float vx, float vy){
    this.x = x;
    this.y = y;
    this.w = w;
    this.time = time;
    r = (int)red(c);
    g = (int)green(c);
    b = (int)blue(c);
    timeWidthRatio = (float)w / (float)time;
    timeAlphaRatio = 255 / (float)time;
    
    vel = new PVector(vx,vy);
  }
  
  void Update(){
    x += (int)vel.x;
    y += (int)vel.y;
    vel.mult(0.8);
    fill(r, g, b, time * timeAlphaRatio);
    w = int(time * timeWidthRatio);
    rectMode(CENTER);
    noStroke();
    rect(x,y,w,w);
    time--;
  }

}
