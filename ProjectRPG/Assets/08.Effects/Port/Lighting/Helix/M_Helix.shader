// Upgrade NOTE: upgraded instancing buffer 'NewAmplifyShader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		_UO("UO", Float) = 0
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Tex;
		uniform float _UO;
		uniform float _Main_Str;
		uniform sampler2D _Mask_Tex;

		UNITY_INSTANCING_BUFFER_START(NewAmplifyShader)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Mask_Tex_ST)
#define _Mask_Tex_ST_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Main_Pow)
#define _Main_Pow_arr NewAmplifyShader
		UNITY_INSTANCING_BUFFER_END(NewAmplifyShader)

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult18 = (float2(( i.uv_texcoord.x + _UO ) , ( i.uv_texcoord.y + i.uv_tex4coord.z )));
			float _Main_Pow_Instance = UNITY_ACCESS_INSTANCED_PROP(_Main_Pow_arr, _Main_Pow);
			float temp_output_4_0 = ( pow( tex2D( _Main_Tex, appendResult18 ).r , _Main_Pow_Instance ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_4_0 ) ).rgb;
			float4 _Mask_Tex_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Mask_Tex_ST_arr, _Mask_Tex_ST);
			float2 uv_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST_Instance.xy + _Mask_Tex_ST_Instance.zw;
			o.Alpha = ( ( i.vertexColor.a * temp_output_4_0 ) * tex2D( _Mask_Tex, uv_Mask_Tex ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
113;43;1738;1019;2551.733;715.1712;1.984087;True;True
Node;AmplifyShaderEditor.RangedFloatNode;15;-1816.497,128.0056;Float;False;Property;_UO;UO;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1933.497,251.0056;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;21;-1872.772,612.428;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1611.497,398.0056;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1665.497,132.0056;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-1505.497,294.0056;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1135.849,129.3096;Float;True;Property;_Main_Tex;Main_Tex;0;0;Create;True;0;0;False;0;d9036bb668177eb45a98e3168338c4a5;97b938aa6ace91f4da304957fd1b274b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-880.1614,364.7142;Float;False;InstancedProperty;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-623.2869,367.6167;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-788.7491,173.5097;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-571.6491,181.3097;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;7;-367.5493,-3.290356;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-635.3492,-56.59035;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.5088002,0.2971698,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-387.0493,180.0097;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-281.7493,350.3096;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-392.1295,581.572;Float;True;Property;_Mask_Tex;Mask_Tex;6;0;Create;True;0;0;False;0;a60748d5292fab94bbeb5406047d2a37;a60748d5292fab94bbeb5406047d2a37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-84.7949,466.1106;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1456.449,110.7097;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-143.4908,78.24119;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1818.497,519.0056;Float;False;Property;_VO;VO;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;127.9065,-8.707611;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;14;2
WireConnection;19;1;21;3
WireConnection;16;0;14;1
WireConnection;16;1;15;0
WireConnection;18;0;16;0
WireConnection;18;1;19;0
WireConnection;1;1;18;0
WireConnection;3;0;1;1
WireConnection;3;1;10;0
WireConnection;4;0;3;0
WireConnection;4;1;11;0
WireConnection;5;0;8;0
WireConnection;5;1;4;0
WireConnection;9;0;7;4
WireConnection;9;1;4;0
WireConnection;13;0;9;0
WireConnection;13;1;12;1
WireConnection;6;0;7;0
WireConnection;6;1;5;0
WireConnection;0;2;6;0
WireConnection;0;9;13;0
ASEEND*/
//CHKSM=8B14C1C8B516B99DB871F1B98ECF7707B09388FE