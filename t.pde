
void exit(){
  String[] stringsave = new String[]{
    "Position "+int(pos.x)+" "+int(pos.y),
    "Spawn "+SpawnPoint.x+" "+SpawnPoint.y,
    "DoubleJumps "+DoubleJumps
  };
  saveStrings("save.txt", stringsave);
  super.exit();
}




void LoadRooms(){
  String[] roomStrings = loadStrings("map.txt");
  RoomBuilder c = null;
  for(int i=0;i<roomStrings.length;i++){
    String[] words = roomStrings[i].split(" ");
    switch(words[0]){
      case "Room":
        if(c==null){
          String[] w = words[2].split(",");
          c = new RoomBuilder(int(words[1]), int(w[0]), int(w[1]));
        }
      break;
      case "End":
      if(c!=null){
        Rooms.put(RoomPos(c.x,c.y),c.ToRoom());
        c = null;
      }
      break;
      case "Box":
      if(c!=null){
        String[] nums = words[1].split(",");
        if(nums.length == 4){
          c.AddBox(new Box(int(nums[0]),int(nums[1]),int(nums[2]),int(nums[3])));
        }else if(nums.length == 6){
          c.AddBox(new BetterBox(int(nums[0]),int(nums[1]),int(nums[2]),int(nums[3]),int(nums[4]),int(nums[5])));
        }
      }
      break;
      case "!Box":
      if(c!=null){
        String[] nums = words[1].split(",");
        if(nums.length == 4){
          Box b = new Box(int(nums[0]),int(nums[1]),int(nums[2]),int(nums[3]));
          b.Bad = true;
          c.AddBox(b);
        }else if(nums.length == 6){
          Box b = new BetterBox(int(nums[0]),int(nums[1]),int(nums[2]),int(nums[3]),int(nums[4]),int(nums[5]));
          b.Bad = true;
          c.AddBox(b);
        }
        
      }
      break;
      case "SpawnPoint":
        String[] nums = words[1].split(",");
        c.AddBox(new SpawnPointTrigger(int(nums[0]),int(nums[1])));
      break;
    }
  }
}

class RoomBuilder{
  int x,y;
  int id;
  ArrayList<Box> Boxes;
  RoomBuilder(int id, int x, int y){
    Boxes = new ArrayList<Box>();
    this.x=x;this.id=id;this.y=y;
  }
  void AddBox(Box box){
    box.x+=x*1000;
    box.y+=y*1000;
    Boxes.add(box);
  }
  Room ToRoom(){
    Box[] boxes = new Box[Boxes.size()];
    for(int i=0;i<Boxes.size();i++){
      boxes[i] = Boxes.get(i);
    }
    return new Room(x,y,boxes);
  }
}
