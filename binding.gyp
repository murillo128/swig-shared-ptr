{
	"targets": 
	[
		{
			"target_name": "swig-shared-ptr",
			"cflags": 
			[
				"-march=native",
				"-fexceptions",
				"-O3",
				"-g",
				"-Wno-unused-function -Wno-comment",
				"-DSPX_RESAMPLE_EXPORT= -DRANDOM_PREFIX=mcu -DOUTSIDE_SPEEX -DFLOATING_POINT",
				#"-O0",
				#"-fsanitize=address"
			],
			"cflags_cc": 
			[
				"-fexceptions",
				"-std=c++17",
				"-O3",
				"-g",
				"-Wno-unused-function",
				"-DSPX_RESAMPLE_EXPORT= -DRANDOM_PREFIX=mcu -DOUTSIDE_SPEEX -DFLOATING_POINT",
				"-faligned-new",
				#"-O0",
				#"-fsanitize=address,leak"
			],
			"include_dirs" : 
			[
				'/usr/include/nodejs/',
				"<!(node -e \"require('nan')\")"
			],
			"sources": 
			[ 
				"swig-shared-ptr_wrap.cxx",
			]
		}
	]
}

