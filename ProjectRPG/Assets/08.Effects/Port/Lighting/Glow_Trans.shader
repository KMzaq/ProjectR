// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		[HDR]_Color0("Color 0", Color) = (1,1,1,0.3921569)
		_TX_Glow("TX_Glow", 2D) = "white" {}
		_Main_Pow("Main_Pow", Float) = 1
		_Main_STr("Main_STr", Float) = 1
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Dissolve_Upanner("Dissolve_Upanner", Float) = 0
		_Dissolve_Vpanner("Dissolve_Vpanner", Float) = 0
		_Dissolve_Str("Dissolve_Str", Float) = 0
		[Toggle(_DISSOLVE_PREVIEW_ON)] _Dissolve_Preview("Dissolve_Preview", Float) = 0
		_Dissolve_Step("Dissolve_Step", Float) = 0
		_T_Center_Gra_05("T_Center_Gra_05", 2D) = "white" {}
		_Mask_Str("Mask_Str", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _DISSOLVE_PREVIEW_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv2_tex4coord2;
		};

		uniform float4 _Color0;
		uniform sampler2D _TX_Glow;
		uniform float _Main_Pow;
		uniform float _Main_STr;
		uniform float _Dissolve_Step;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_Upanner;
		uniform float _Dissolve_Vpanner;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve_Str;
		uniform sampler2D _T_Center_Gra_05;
		uniform float4 _T_Center_Gra_05_ST;
		uniform float _Mask_Str;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			float4 temp_output_6_0 = ( pow( tex2D( _TX_Glow, i.uv_texcoord ) , temp_cast_0 ) * _Main_STr );
			o.Emission = ( ( _Color0 * temp_output_6_0 ) * i.vertexColor ).rgb;
			float2 appendResult15 = (float2(_Dissolve_Upanner , _Dissolve_Vpanner));
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner20 = ( 1.0 * _Time.y * appendResult15 + uv0_Dissolve_Tex);
			#ifdef _DISSOLVE_PREVIEW_ON
				float staticSwitch22 = ( i.uv2_tex4coord2.z + _Dissolve_Str );
			#else
				float staticSwitch22 = i.uv2_tex4coord2.z;
			#endif
			float2 uv_T_Center_Gra_05 = i.uv_texcoord * _T_Center_Gra_05_ST.xy + _T_Center_Gra_05_ST.zw;
			float4 tex2DNode33 = tex2D( _T_Center_Gra_05, uv_T_Center_Gra_05 );
			o.Alpha = ( temp_output_6_0 * ( i.vertexColor.a * ( saturate( step( _Dissolve_Step , ( tex2D( _Dissolve_Tex, panner20 ).r + staticSwitch22 ) ) ) * pow( tex2DNode33.r , _Mask_Str ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
255;227;1738;1019;2364.736;118.3301;1.957538;True;True
Node;AmplifyShaderEditor.RangedFloatNode;14;-2404.938,807.489;Float;False;Property;_Dissolve_Vpanner;Dissolve_Vpanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2408.838,724.288;Float;False;Property;_Dissolve_Upanner;Dissolve_Upanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-2195.638,703.4892;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-2355.847,432.9002;Float;True;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1832.489,891.3871;Float;False;Property;_Dissolve_Str;Dissolve_Str;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;16;-1871.125,694.5201;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;20;-2007.137,461.6886;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1667.88,805.0692;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-1754.937,433.0885;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;4;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;22;-1665.88,678.0692;Float;False;Property;_Dissolve_Preview;Dissolve_Preview;8;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1385.786,0.3895035;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-1385.438,537.3887;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1418.095,330.7291;Float;False;Property;_Dissolve_Step;Dissolve_Step;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-638.2171,847.3625;Float;False;Property;_Mask_Str;Mask_Str;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-903.7858,167.3895;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;24;-1154.981,441.8412;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1168.786,-1.610497;Float;True;Property;_TX_Glow;TX_Glow;1;0;Create;True;0;0;False;0;4378023a8911e5d4f930500efb2a2c42;b31b4667eb5d3374a8faf15c90170ef1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;33;-996.2104,703.6312;Float;True;Property;_T_Center_Gra_05;T_Center_Gra_05;10;0;Create;True;0;0;False;0;a60748d5292fab94bbeb5406047d2a37;a60748d5292fab94bbeb5406047d2a37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;4;-800.7853,-0.6104965;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-699.7853,163.3895;Float;False;Property;_Main_STr;Main_STr;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;-930.6371,434.9886;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;37;-489.8699,661.9285;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-641.7853,-178.6104;Float;False;Property;_Color0;Color 0;0;1;[HDR];Create;True;0;0;False;0;1,1,1,0.3921569;0.01530669,0.01103596,0.0754717,0.3921569;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-572.7853,37.38949;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;9;-659.7216,237.9708;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-680.3173,546.0148;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-411.7854,17.3895;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-578.0524,404.8339;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-655.6016,689.7438;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-290.9775,317.7364;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-310.7854,157.3895;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;20;0;18;0
WireConnection;20;2;15;0
WireConnection;19;0;16;3
WireConnection;19;1;17;0
WireConnection;21;1;20;0
WireConnection;22;1;16;3
WireConnection;22;0;19;0
WireConnection;23;0;21;1
WireConnection;23;1;22;0
WireConnection;24;0;29;0
WireConnection;24;1;23;0
WireConnection;2;1;1;0
WireConnection;4;0;2;0
WireConnection;4;1;3;0
WireConnection;25;0;24;0
WireConnection;37;0;33;1
WireConnection;37;1;36;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;34;0;25;0
WireConnection;34;1;37;0
WireConnection;8;0;7;0
WireConnection;8;1;6;0
WireConnection;32;0;9;4
WireConnection;32;1;34;0
WireConnection;35;0;33;1
WireConnection;35;1;36;0
WireConnection;11;0;6;0
WireConnection;11;1;32;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;0;2;10;0
WireConnection;0;9;11;0
ASEEND*/
//CHKSM=04B9C2FB0EE2C1CB55F0379D89AF946125608432