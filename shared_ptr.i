
%define SHARED_PTR_BEGIN(T)
%inline %{
using T ## _shared_ptr = std::shared_ptr<T>;
%}
%nodefaultctor T ## _shared_ptr;
struct T ## _shared_ptr
{
%extend 
%enddef

%define SHARED_PTR_END(T)
T* get();
};
%enddef

%define SHARED_PTR_TO(B)
B ## _shared_ptr to##B()
{
	return std::static_pointer_cast<B>(*self);
}
%enddef


%define SHARED_PTR(T)
SHARED_PTR_BEGIN(T)
{
}
SHARED_PTR_END(T)
%enddef


////////////////Unused
/*

%define SHARED_PTR_ATTR_GETTER(T, name, type)
%ignore T ## _shared_ptr_ ## name ## _get;
%inline %{
type T ## _shared_ptr_ ## name ## _get(std::shared_ptr<T>* ptr) {
  return (*ptr)-> ## name;
}
%}
%enddef

%define SHARED_PTR_ATTR_SETTER(T, name, type)
%ignore T ## _shared_ptr_ ## name ## _set;
%inline %{
void  T ## _shared_ptr_ ## name ## _set(std::shared_ptr<T>* ptr, type val ) {
  (*ptr)-> ## name = val  ;
}
%}
%enddef


%define SHARED_PTR_ATTR(T, name, type)
%extend  T ## _shared_ptr
{
	type name;
}
SHARED_PTR_ATTR_GETTER(T, name, type)
SHARED_PTR_ATTR_SETTER(T, name, type)
%enddef


%define SHARED_PTR_ATTR_RO(T, name, type)
%extend  T ## _shared_ptr
{
	const type name;
}
SHARED_PTR_ATTR_GETTER(T, name, type)
%enddef

SHARED_PTR_BEGIN(Test)
{
	Test_shared_ptr(bool boolean,int integer) 
	{
		return new std::shared_ptr<Test>(new Test(boolean,integer));
	}
	int one()		{ return (*self)->one();}
	int inc(int a)		{ return (*self)->inc(a);}
	int sum(int a,int b)	{ return (*self)->sum(a,b);}

}
SHARED_PTR_END(Test)

SHARED_PTR_ATTR_RO(Test,readonly,int)
SHARED_PTR_ATTR(Test,boolean,bool)
SHARED_PTR_ATTR(Test,integer,int)
*/
