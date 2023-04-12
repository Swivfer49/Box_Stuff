Room CurrentRoom;


//get room id
String RoomPos(int x, int y){
  println(x,y);
  return x+"|"+y;
}

//the rooms
HashMap<String, Room> Rooms = new HashMap<String, Room>();

Room GetRoom(int x,int y){
  String rp = RoomPos(x,y);
  //println(rp);
  return Rooms.get(rp);
}

Room GetRoom(){
  if(CurrentRoom == null){
    Room nr = GetRoom(nint((pos.x+hw)/1000),nint((pos.y)/1000));
    if(nr == null){
       Die();
       nr = GetRoom(nint((pos.x+hw)/1000),nint((pos.y)/1000));
       CurrentRoom = nr;
       return nr;
    }
    CurrentRoom = nr;
    return nr;
  }else if(CurrentRoom.IsPlayerHere(pos.x+hw,pos.y)){
    return CurrentRoom;
  }
  else{
    Room nr = GetRoom(nint((pos.x+hw)/1000),nint((pos.y)/1000));
    if(nr == null){
       return CurrentRoom;
    }
    CurrentRoom = nr;
    return CurrentRoom;
  }
}

int nint(float value){
  if(value<0){
    value = -value+1;
    return -int(value);
  }
  return int(value);
}



class Room{
  int x, y;
  Box[] Boxes;
  Room(int x, int y, Box[] boxes){
    this.x=x;this.y=y;
    this.Boxes=boxes;
  }
  boolean IsPlayerHere(float X,float Y){
    if(X+hw<(x*1000))return false;
    if(X>(x+1)*1000)return false;
    if(Y+hh<(y*1000))return false;
    if(Y>(y+1)*1000)return false;
    return true;
  }
}
