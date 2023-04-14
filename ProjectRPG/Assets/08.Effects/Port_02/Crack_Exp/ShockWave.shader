// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_02/Crack_Exp/ShockWave_01"
{
	Properties
	{
		_Ramp_Tex("Ramp_Tex", 2D) = "white" {}
		_Flow_Tex("Flow_Tex", 2D) = "white" {}
		_Flow_Tex_02("Flow_Tex_02", 2D) = "white" {}
		_Flow_Str("Flow_Str", Float) = 0.1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Ramp_Pow("Ramp_Pow", Float) = 2
		_m("m", Float) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Tile_US("Tile_US", Float) = 0
		_Flow_US("Flow_US", Float) = 0
		_Float1("Float 1", Float) = 0
		_Tile_VS("Tile_VS", Float) = 0
		_Flow_VS("Flow_VS", Float) = 0
		_Float0("Float 0", Float) = 0
		_T_Center_Gra_02("T_Center_Gra_02", 2D) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One , SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _TextureSample0;
		uniform float _Tile_US;
		uniform float _Tile_VS;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _Ramp_Tex;
		uniform sampler2D _Flow_Tex;
		uniform float _Flow_US;
		uniform float _Flow_VS;
		uniform float4 _Flow_Tex_ST;
		uniform sampler2D _Flow_Tex_02;
		uniform float _Float1;
		uniform float _Float0;
		uniform float4 _Flow_Tex_02_ST;
		uniform float _Flow_Str;
		uniform float4 _Ramp_Tex_ST;
		uniform float _Ramp_Pow;
		uniform float _m;
		uniform sampler2D _T_Center_Gra_02;
		uniform float4 _T_Center_Gra_02_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult25 = (float2(_Tile_US , _Tile_VS));
			float2 uv0_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult25 + uv0_TextureSample0);
			float2 appendResult31 = (float2(_Flow_US , _Flow_VS));
			float2 uv0_Flow_Tex = i.uv_texcoord * _Flow_Tex_ST.xy + _Flow_Tex_ST.zw;
			float2 panner32 = ( 1.0 * _Time.y * appendResult31 + uv0_Flow_Tex);
			float2 temp_output_4_0 = (tex2D( _Flow_Tex, panner32 )).rg;
			float2 appendResult37 = (float2(_Float1 , _Float0));
			float2 uv0_Flow_Tex_02 = i.uv_texcoord * _Flow_Tex_02_ST.xy + _Flow_Tex_02_ST.zw;
			float2 panner38 = ( 1.0 * _Time.y * appendResult37 + uv0_Flow_Tex_02);
			float2 temp_output_33_0 = (tex2D( _Flow_Tex_02, panner38 )).rg;
			float2 uv0_Ramp_Tex = i.uv_texcoord * _Ramp_Tex_ST.xy + _Ramp_Tex_ST.zw;
			float2 appendResult43 = (float2(uv0_Ramp_Tex.x , ( uv0_Ramp_Tex.y + i.uv_tex4coord.z )));
			float4 tex2DNode1 = tex2D( _Ramp_Tex, ( ( ( temp_output_4_0 * temp_output_33_0 ) * _Flow_Str ) + appendResult43 ) );
			float4 temp_cast_0 = (_Ramp_Pow).xxxx;
			float4 temp_output_15_0 = ( pow( ( ( tex2D( _TextureSample0, panner23 ) + tex2DNode1.r ) * tex2DNode1.r ) , temp_cast_0 ) * _m );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_15_0 ) ).rgb;
			float2 uv_T_Center_Gra_02 = i.uv_texcoord * _T_Center_Gra_02_ST.xy + _T_Center_Gra_02_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( temp_output_15_0 * tex2D( _T_Center_Gra_02, uv_T_Center_Gra_02 ).r ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
38;239;1738;1007;963.9688;67.59369;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;29;-2770.963,7.76827;Float;False;Property;_Flow_US;Flow_US;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2836.007,442.3853;Float;False;Property;_Float0;Float 0;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2803.507,350.0852;Float;False;Property;_Float1;Float 1;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2803.463,100.0684;Float;False;Property;_Flow_VS;Flow_VS;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-2824.262,-126.1316;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;31;-2637.063,25.96836;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-2856.806,216.1853;Float;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;37;-2669.606,368.2853;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;32;-2504.461,-50.73164;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;38;-2537.005,291.5853;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;39;-2273.386,279.3957;Float;True;Property;_Flow_Tex_02;Flow_Tex_02;3;0;Create;True;0;0;False;0;b86253915afe45144af3b52c2c8e36a0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2240.842,-62.92124;Float;True;Property;_Flow_Tex;Flow_Tex;2;0;Create;True;0;0;False;0;b86253915afe45144af3b52c2c8e36a0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1315.642,345.8786;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;46;-1288.962,628.6085;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;4;-1936.642,-62.92119;Float;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;33;-1944.485,250.8958;Float;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1463.941,-272.9213;Float;False;Property;_Tile_US;Tile_US;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1496.441,-180.6212;Float;False;Property;_Tile_VS;Tile_VS;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1419.141,231.9788;Float;False;Property;_Flow_Str;Flow_Str;4;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1664.943,171.8883;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-1172.595,512.2407;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1168.841,35.17882;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1517.241,-406.8212;Float;False;0;19;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;43;-1011.956,381.9591;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-1330.041,-254.7212;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-946.5408,215.8788;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-1197.44,-331.4212;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;19;-1001.14,-274.2213;Float;True;Property;_TextureSample0;Texture Sample 0;8;0;Create;True;0;0;False;0;17e1367cc70dc7f4cae9c9703e0f3d01;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-795.7405,196.3787;Float;True;Property;_Ramp_Tex;Ramp_Tex;1;0;Create;True;0;0;False;0;c999e1a476be16b4a842a7c1e4fa3633;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-700.8396,-133.8213;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-603.3395,423.8787;Float;False;Property;_Ramp_Pow;Ramp_Pow;6;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-462.9398,-119.5213;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;14;-464.2394,213.2787;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-410.9395,416.0787;Float;False;Property;_m;m;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-238.0393,-81.82124;Float;False;Property;_Main_Color;Main_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-459.5157,560.8795;Float;True;Property;_T_Center_Gra_02;T_Center_Gra_02;15;0;Create;True;0;0;False;0;accadee74e38a2441800412ab3d8897a;accadee74e38a2441800412ab3d8897a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-292.6395,211.9787;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;9;19.36069,-54.52124;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-124.9394,178.1787;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-72.96875,487.4063;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;45.36065,312.0788;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;88.26057,180.7788;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1640.244,-65.61165;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;286.0001,-45.5;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_02/Crack_Exp/ShockWave_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;29;0
WireConnection;31;1;28;0
WireConnection;37;0;35;0
WireConnection;37;1;34;0
WireConnection;32;0;30;0
WireConnection;32;2;31;0
WireConnection;38;0;36;0
WireConnection;38;2;37;0
WireConnection;39;1;38;0
WireConnection;2;1;32;0
WireConnection;4;0;2;0
WireConnection;33;0;39;0
WireConnection;41;0;4;0
WireConnection;41;1;33;0
WireConnection;42;0;7;2
WireConnection;42;1;46;3
WireConnection;5;0;41;0
WireConnection;5;1;6;0
WireConnection;43;0;7;1
WireConnection;43;1;42;0
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;8;0;5;0
WireConnection;8;1;43;0
WireConnection;23;0;22;0
WireConnection;23;2;25;0
WireConnection;19;1;23;0
WireConnection;1;1;8;0
WireConnection;21;0;19;0
WireConnection;21;1;1;1
WireConnection;20;0;21;0
WireConnection;20;1;1;1
WireConnection;14;0;20;0
WireConnection;14;1;16;0
WireConnection;15;0;14;0
WireConnection;15;1;17;0
WireConnection;11;0;10;0
WireConnection;11;1;15;0
WireConnection;48;0;15;0
WireConnection;48;1;47;1
WireConnection;13;0;9;4
WireConnection;13;1;48;0
WireConnection;12;0;9;0
WireConnection;12;1;11;0
WireConnection;40;0;4;0
WireConnection;40;1;33;0
WireConnection;0;2;12;0
WireConnection;0;9;13;0
ASEEND*/
//CHKSM=F4198A6EDFEC4CA0CC4327924F0ADA5458A2E09C