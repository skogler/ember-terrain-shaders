uniform mat4 worldViewProj;
uniform vec4 texelOffsets;

#if LINEAR_RANGE
uniform vec4 depthRange;
#endif
#if ALPHA
varying vec2 uv;
#endif

varying vec2 depth;

void main()
{
	// Pass-through default components
	gl_Position    = gl_ModelViewProjectionMatrix * gl_Vertex;
#if ALPHA
	uv = gl_MultiTexCoord0.st;
#endif

	// fix pixel / texel alignment
	gl_Position.xy += texelOffsets.zw * gl_Position.w;
	// linear depth storage
	// offset / scale range output
#if LINEAR_RANGE
	depth.x = (gl_Position.z - depthRange.x) * depthRange.w;
#else
	depth.x = gl_Position.z;
#endif
	depth.y = gl_Position.w;
}

