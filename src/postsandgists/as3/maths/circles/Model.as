package postsandgists.as3.maths.circles {
	import flash.geom.Point;

	/**
	 * @author david.williamson
	 * 
	 * Some maths to help calculate points along a circle. 
	 * I just wrote it for fun so use at your own risk :)
	 * 
	 * See the README for a short example.
	 */
	public class Model 
	{
		public var chordMidPoint:Point;
		public var sagittaPoint:Point;
		public var circleCentrePoint:Point;
		public var tdcPoint:Point;
		public var targetPoint:Point;
		public var startPoint:Point;
		
		public var chordLength:Number = 0;
		public var sagitta:Number = 0;
		public var radius:Number = 0;
		
		public var startAngle:Number = 0;
		public var targetAngle:Number = 0;
		public var angleIncrement : Number;
		
		private var __currentAngle:Number = 0;			
		private var __rotationDirection:String;
		
		public function Model()
		{
			circleCentrePoint = new Point();
			__rotationDirection = Rotation.CLOCKWISE;
		}

		/*
		 * Degrees
		 */
		public function get currentAngle():Number
		{
			return __currentAngle;
		}
		
		public function set currentAngle(angle:Number):void
		{
			__currentAngle = normaliseAngle(angle);	
		}
		
		public function set rotationDirection(direction : String) : void 
		{
			__rotationDirection = direction;
		}
		
		public function calculateChordMidPoint():Point
		{
			var point:Point = new Point();
			point.x = (targetPoint.x + startPoint.x) / 2;
			point.y = (targetPoint.y + startPoint.y) / 2;
			return point;	
		}		
		
		public function nextAngle():void
		{
			var newAngle:Number;
			switch(__rotationDirection) 
			{
				case Rotation.CLOCKWISE:
					newAngle = normaliseAngle(__currentAngle + angleIncrement); 
					break;
				case Rotation.ANTI_CLOCKWISE:
					newAngle = normaliseAngle(__currentAngle - angleIncrement);
					break;
			}
			__currentAngle = newAngle;
		}
		
		public function run():void
		{
			chordMidPoint = calculateChordMidPoint();				
			chordLength = calculateChordLength();
			radius = calculateRadius();
			circleCentrePoint = calculateCircleCentrePoint(startPoint, targetPoint, chordMidPoint, radius, chordLength);
			tdcPoint = calculateTopCentre();
		}
				
		public function get currentOrbitPoint():Point
		{
			var position:Point = new Point();
			position.x = circleCentrePoint.x + Math.sin(angleToRadian(__currentAngle)) * radius;
			position.y = circleCentrePoint.y - Math.cos(angleToRadian(__currentAngle)) * radius;
			return position;
		}
		
		public function getAngleGivenPoint(point:Point):Number
		{				
			var tdc:Point = calculateTopCentre();
			var angle:Number = 2 * Math.atan2(point.y - tdc.y, point.x - tdc.x);
			angle = radianToAngle(angle);
			return angle;
		}
		
		public function radianToAngle(radian:Number):Number
		{
			var angle:Number = radian * 180 / Math.PI;			
			return angle;
		}

		public function angleToRadian(angle:Number):Number
		{
			var radian:Number = angle * Math.PI / 180;
			return radian;
		}

		public function normaliseAngle(angle:Number):Number
		{
			if (angle < 0)
			{
				angle += 360;
			}
			if (angle > 360)
			{
				angle -= 360;
			}
			return Math.abs(angle);
		}
		
		public function calculateChordLength():Number
		{
			return lineSegmentLength(startPoint, targetPoint);
		}
		
		public function lineSegmentLength(startPoint:Point, targetPoint:Point):Number
		{
			var result:Number = 0;
			var dX:Number = Math.abs(startPoint.x - targetPoint.x);
			var dY:Number = Math.abs(startPoint.y - targetPoint.y);
			result = Math.sqrt(Math.pow(dX,2) + Math.pow(dY,2));
			return result;
		}
		
		public function calculateRadius():Number
		{
			return (Math.pow((chordLength/2),2) + Math.pow(sagitta,2)) / (2 * sagitta);		
		}
		
		public function calculateCircleCentrePoint(startPoint:Point, targetPoint:Point, chordMidPoint:Point, radius:Number, chordLength:Number):Point
		{
			var point:Point = new Point();
			var xPosition:Number = Math.sqrt(Math.pow(radius, 2) - Math.pow((chordLength / 2), 2)) * (startPoint.y - targetPoint.y) / chordLength;
			var yPosition:Number =  Math.sqrt(Math.pow(radius, 2) - Math.pow((chordLength / 2), 2)) * (targetPoint.x - startPoint.x) / chordLength;
			switch (__rotationDirection)
			{
				case Rotation.ANTI_CLOCKWISE:
					point.x = chordMidPoint.x - xPosition;
					point.y = chordMidPoint.y - yPosition;	
				break;
				case Rotation.CLOCKWISE:
					point.x = chordMidPoint.x + xPosition;
					point.y = chordMidPoint.y + yPosition;
				break;
			}			
			return point;
		}
		
		public function calculateTopCentre():Point //12 o'clock, top dead centre ...
		{
			var point:Point = new Point();
			point.x = circleCentrePoint.x;
			point.y = circleCentrePoint.y - radius;
			return point;
		}
		
		public function calculateRightCentre():Point
		{
			var point:Point = new Point();
			point.x = circleCentrePoint.x + radius;
			point.y = circleCentrePoint.y;
			return point;	
		}
		
		public function calculateBottomCentre():Point
		{
			var point:Point = new Point();
			point.x = circleCentrePoint.x;
			point.y = circleCentrePoint.y + radius;
			return point;
		}
		
		public function calculateLeftCentre():Point
		{
			var point:Point = new Point();
			point.x = circleCentrePoint.x - radius;
			point.y = circleCentrePoint.y;
			return point;
		}		
	}
}
