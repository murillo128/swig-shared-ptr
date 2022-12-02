function proxy(ret)
{
	if (typeof ret === "object" && ret.constructor.name.match(/_exports_(.*)_shared_ptr/))
		return SharedPointer(ret);
	return ret;
}
function wrap(func)
{
	return function(...args)
	{
		return proxy(func(...args))
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
		return proxy(ptr[prop]);
	},
	set(shared, prop, value) {
		shared.get()[prop] = value;
	}
};

//Cache for alreay created proxies
const cache = new WeakMap();

function SharedPointer(obj)
{
	//If we already have a proxy for that object
	if (cache.has(obj))
		//Return 
		return cache.get(obj)
	//Create new proxy
	const proxy  = new Proxy(obj, handler);
	//Set it on cache
	cache.set(obj,proxy);
	//Return proxy
	return proxy;

};

SharedPointer.Target = Symbol("target");

module.exports = SharedPointer;



