function proxy(ret,cache)
{
	if (typeof ret === "object" && ret.constructor.name.match(/_exports_(.*)_shared_ptr/))
		return SharedPointer(ret,cache);
	return ret;
}
function wrap(func,cache)
{
	return function(...args)
	{
		return proxy(func(...args),cache)
	}
}

class Handler
{
	constructor(cache)
	{
		//Cache for alreay created proxies
		this.cache = cache ? cache : new WeakMap();
	}
	get(shared, prop)
	{
		if (typeof shared[prop] == "function")
			return wrap(shared[prop].bind(shared),this.cache);
		const ptr = shared.get();
		if (typeof ptr[prop] == "function")
			return wrap(ptr[prop].bind(ptr),this.cache);
		if (prop===SharedPointer.Target)
			return shared;
		if (prop===SharedPointer.Pointer)
			return ptr;
		return proxy(ptr[prop],this.cache);
	}
	set(shared, prop, value) {
		shared.get()[prop] = value;
	}
};



function SharedPointer(obj, cache)
{
	//If we already have a proxy for that object
	if (cache && cache.has(obj))
		//Return 
		return cache.get(obj)
	//Create new proxy
	const proxy  = new Proxy(obj, new Handler());
	//Set it on cache
	if (cache) cache.set(obj,proxy);
	//Return proxy
	return proxy;

};

SharedPointer.Target = Symbol("target");
SharedPointer.Pointer = Symbol("pointer");

module.exports = SharedPointer;



