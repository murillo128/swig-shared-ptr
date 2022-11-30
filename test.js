const tap = require("tap")
const os = require("os");
const path = require("path");

const Native = process.dlopen(module,path.resolve(path.dirname(module.filename), "build/Release/swig-shared-ptr.node"), os.constants.dlopen.RTLD_NOW | os.constants.dlopen.RTLD_DEEPBIND);

tap.test("shared_ptr",function(suite){
	
	suite.test("attr",async function(test){
		test.end();
	});


	suite.end();
});
	