package postsandgists.as3.maths.circles.tests {
	import asunit.textui.TestRunner;

	import flash.display.Sprite;

	/**
	 * @author david.williamson
	 */
	public class RunTests extends Sprite
	{
		public function RunTests()
		{
			var unittests:TestRunner = new TestRunner();
     		stage.addChild(unittests);
      		unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
		}
	}
}
