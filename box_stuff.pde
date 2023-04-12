
void setup(){
  size(1000,1000);
  String[] save = loadStrings("save.txt");
  String[] spwn = save[1].split(" ");
  SpawnPoint = new PVector(int(spwn[1]),int(spwn[2]));
  String[] posn = save[0].split(" ");
  LoadPoint = new PVector(int(posn[1]),int(posn[2]));
  LoadRooms();
  DoubleJumps = int(save[2].split(" ")[1]);
  java.util.Collection<Room> rs = Rooms.values();
  for(int i=0;i<rs.size();i++){
    Room r = ((Room)(rs.toArray()[i]));
    for(int j=0;j<r.Boxes.length;j++){
    }
  }
  
  pos.set(LoadPoint);
  ppos.set(LoadPoint);
}
void draw(){
  background(0);
  Update();
  UpdateParticles();
  rectMode(CORNER);
  
}
