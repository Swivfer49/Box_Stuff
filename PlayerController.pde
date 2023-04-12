
interface IController{
  void Update();
  void Jump();
  void ReleaseKey(char Key);
  void PressKey(char Key);
}


class StandardPlayerController implements IController{
  boolean WallJump, WallSlide;
  boolean W,A,S,D;
  int hor = 0;
  PVector pos, ppos, acc;
  ControllerSettings settings;
  StandardPlayerController(ControllerSettings s, PVector p, PVector pp, PVector a){
    pos = p;
    ppos = pp;
    acc = a;
    settings = s;
  }
  
  void Update(){
  
  }
  
  void Jump(){
  
  }
  void ReleaseKey(char Key){
  
  }
  void PressKey(char Key){
  
  }
}
class ControllerSettings{
  int DoubleJumps, KTime;
  float Speed;
  float FloorFriction = 0.4;
  float WallFriction = 0.9;
}
