%define SHARED_PTR_BEGIN(T)
%inline %{
using T ## _shared_ptr = std::shared_ptr< ## T >;
%}
%nodefaultctor T ## _shared_ptr;
struct T ## _shared_ptr
{
%extend 
%enddef

%define SHARED_PTR_END()
};
%enddef



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