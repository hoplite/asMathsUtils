package postsandgists.as3.maths.circles.tests {
	import asunit.framework.TestCase;

	import postsandgists.as3.maths.circles.Model;

	import flash.geom.Point;

	/**
	 * @author david.williamson
	 */
	public class ModelTests extends TestCase
	{		
		private var __instance:Model;
		
		public function ModelTests(testMethod:String = null) 
		{
			super(testMethod);
		}
		
		override protected function setUp():void 
		{
            __instance = new Model();
            __instance.targetPoint = new Point(-50, 0);
			__instance.startPoint = new Point(50, 0);
			__instance.sagitta = 100;
			__instance.angleIncrement = 1;	
			__instance.run();
			var startAngle:Number =  __instance.getAngleGivenPoint(__instance.startPoint);
			__instance.currentAngle = startAngle;	
        }
				
		public function TestNormaliseAngle():void
		{
			var normalised:Number = __instance.normaliseAngle(720);
			assertEqualsFloat(360, normalised, 0);
			
			normalised = __instance.normaliseAngle(-90);
			assertEqualsFloat(270, normalised, 0);
			
			normalised = __instance.normaliseAngle(-720);
			assertEqualsFloat(360, normalised, 0);
		}
		
		public function TestAngleGivenPoint():void
		{
			var top:Point = __instance.calculateTopCentre();
			var topAngle:Number = __instance.getAngleGivenPoint(top);
			assertEqualsFloat(0, topAngle, 0);
			
			var bottom:Point = __instance.calculateBottomCentre();
			var bottomAngle:Number = __instance.getAngleGivenPoint(bottom);
			assertEqualsFloat(180, bottomAngle, 0);
			
			var left:Point = __instance.calculateLeftCentre();
			var leftAngle:Number = __instance.getAngleGivenPoint(left);
			assertEqualsFloat(270, leftAngle, 0);
			
			var right:Point = __instance.calculateRightCentre();
			var rightAngle:Number = __instance.getAngleGivenPoint(right);
			assertEqualsFloat(90, rightAngle, 0);
		}
		
		public function TestCurrentPoint():void
		{
			var currentPoint:Point = __instance.currentOrbitPoint;
			assertEqualsFloat(__instance.startPoint.x, currentPoint.x, 9);
			assertEqualsFloat(__instance.startPoint.y, currentPoint.y, 9);			
		}
	}
}