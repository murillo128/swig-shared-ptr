const tap = require("tap")
const Native = require("./Native")
const SharedPointer = require("./SharedPointer")


console.log(Native.Test_shared_ptr)	
tap.test("shared_ptr",function(suite){
	
	suite.test("constructor",async function(test){
		const shared = SharedPointer(Native.Test_shared_ptr)(true,5);

		console.log("boolean" in shared)
		console.log(typeof shared.inc == "function")
		test.same(true,shared.boolean);
		test.same(5,shared.integer);
		test.end();
	});

	suite.test("set",async function(test){
		const shared = SharedPointer(Native.Test_shared_ptr)(true,5);
		shared.boolean = false;
		test.same(false,shared.boolean);
		test.end();
	});

	suite.test("set and get",async function(test){
		const shared = SharedPointer(Native.Test_shared_ptr)(true,5);
		for (let i = 0; i<200;++i)
		{
			shared.integer = i;
			test.same(i,shared.integer);
		}
		test.end();
	});

	suite.test("base",async function(test){
		const shared = SharedPointer(Native.Test_shared_ptr)(true,5);
		test.same(3, shared.base);
		const base = shared.toBase();
		test.ok(shared.CheckShared(base[SharedPointer.Target]));
		test.same(3, base.base);
		test.ok(base.CheckShared(base[SharedPointer.Target]));
		
	});

	suite.test("readonly",async function(test){
		const shared = SharedPointer(Native.Test_shared_ptr)(true,5);
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
