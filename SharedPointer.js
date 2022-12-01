function wrap(func)
{
	return function(...args)
	{
		const ret = func(...args);
		if (typeof ret === "object" && ret.constructor.name.match(/_exports_(.*)_shared_ptr/))
			return new Proxy(ret, handler);
		return ret;
	}
}

const handler = {
	get(shared, prop)
	{
		if (typeof shared[prop] == "function")
			return wrap(shared[prop].bind(shared));
		const ptr = shared.get();
		if (typeof ptr[prop] == "function")
			return wrap(ptr[prop].bind(ptr));
		if (prop===SharedPointer.Target)
			return shared;
		return ptr[prop];
	},
	set(shared, prop, value) {
		shared.get()[prop] = value;
	}
};

function SharedPointer(constructor){
	return function(...args) {
		return new Proxy(new constructor(...args), handler);
	}
};

SharedPointer.Target = Symbol("target");

module.exports = SharedPointer;



