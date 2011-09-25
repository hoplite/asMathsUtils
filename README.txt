A demo of calculating Chord, Sagitta and other equations.

shorthand example, there are also a couple of tests which give
an idea how it works.
  //configure the model so it's ready to use
  var model = new Model();			
  model.targetPoint = Config.TARGET_POINT;
  model.startPoint = Config.START_POINT;
  model.sagitta = Config.SAGITTA_DEFAULT;
  model.angleIncrement = Config.ANGLE_INCREMENT;
  model.run();	
 
  //calculate the models initial angle.  
  var startAngle:Number =  model.getAngleGivenPoint(model.startPoint);
  model.currentAngle = startAngle;	  
    
  //some display object container that has a sprite you want to animate 
  var view = new View();
  addChild(view);		 			 
  view.orbiterSprite.addEventListener(Event.ENTER_FRAME, onOrbit);
	
  ... 
	 
  //update the position of the sprite on each frame  		 
  private function onOrbit(e:Event):void
  {				
    var currentOrbitPoint:Point = __model.currentOrbitPoint;
    view.orbiterSprite.x = currentOrbitPoint.x;
    view.orbiterSprite.y = currentOrbitPoint.y;
    model.nextAngle();		  	
  }		 	 	  
 
