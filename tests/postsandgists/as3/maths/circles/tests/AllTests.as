package postsandgists.as3.maths.circles.tests {
	import asunit.framework.TestSuite;

	/**
	 * @author david.williamson
	 */
	public class AllTests extends TestSuite 
	{		  
	    public function AllTests()
	    {
	    	super();
	    	addTest(new ModelTests("TestNormaliseAngle"));
	    	addTest(new ModelTests("TestAngleGivenPoint"));
	    	addTest(new ModelTests("TestCurrentPoint"));
	    }		  
	}
}
