const tap = require("tap")
const Native = require("./Native")
	
tap.test("shared_ptr",function(suite){
	
	suite.test("constructor",async function(test){
		const shared = new Native.Test_shared_ptr(true,5);
		test.same(true,shared.boolean);
		test.same(5,shared.integer);
		test.end();
	});

	suite.test("set",async function(test){
		const shared = new Native.Test_shared_ptr(true,5);
		shared.boolean = false;
		test.same(false,shared.boolean);
		test.end();
	});

	suite.test("set and get",async function(test){
		const shared = new Native.Test_shared_ptr(true,5);
		for (let i = 0; i<200;++i)
		{
			shared.integer = i;
			test.same(i,shared.integer);
		}
		test.end();
	});

	suite.test("readonly",async function(test){
		const shared = new Native.Test_shared_ptr(true,5);
		test.same(7,shared.readonly);
		try {
			shared.readonly = 1;
			test.fail("writed read only attribute")
		} catch (e)	{
			test.ok(e)
		}
		test.end();
	});

	suite.end();
});
