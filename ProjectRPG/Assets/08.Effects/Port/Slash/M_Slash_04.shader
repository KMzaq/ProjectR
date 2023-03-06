// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Slash_01"
{
	Properties
	{
		_T_Trail_04("T_Trail_04", 2D) = "white" {}
		_FX_Slash_Edge("FX_Slash_Edge", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Main_Str("Main_Str", Float) = 1
		_Dissolve_Upanner("Dissolve_Upanner", Float) = 0
		_Dissolve_Vpanner("Dissolve_Vpanner", Float) = 0
		_Dissolve_Str("Dissolve_Str", Float) = 0
		_Dissolve_Step("Dissolve_Step", Float) = 0
		[Toggle(_DISSOLVE_PREVIEW_ON)] _Dissolve_Preview("Dissolve_Preview", Float) = 0
		_T_Center_Gra_05("T_Center_Gra_05", 2D) = "white" {}
		_Edge_Pow("Edge_Pow", Float) = 0
		_TX_Slash_04("TX_Slash_04", 2D) = "white" {}
		_Edge_Str("Edge_Str", Float) = 4.51
		_Side_Edge_Str("Side_Edge_Str", Float) = 0
		_Side_Edge_Pow("Side_Edge_Pow", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Front
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _DISSOLVE_PREVIEW_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
		};

		uniform float4 _Edge_Color;
		uniform sampler2D _TX_Slash_04;
		uniform float4 _TX_Slash_04_ST;
		uniform float _Side_Edge_Pow;
		uniform float _Side_Edge_Str;
		uniform sampler2D _FX_Slash_Edge;
		uniform sampler2D _T_Trail_04;
		uniform float4 _T_Trail_04_ST;
		uniform float _Edge_Pow;
		uniform float _Edge_Str;
		uniform float4 _Main_Color;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform float _Dissolve_Step;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_Upanner;
		uniform float _Dissolve_Vpanner;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve_Str;
		uniform sampler2D _T_Center_Gra_05;
		uniform float4 _T_Center_Gra_05_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TX_Slash_04 = i.uv_texcoord * _TX_Slash_04_ST.xy + _TX_Slash_04_ST.zw;
			float2 uv0_T_Trail_04 = i.uv_texcoord * _T_Trail_04_ST.xy + _T_Trail_04_ST.zw;
			float4 tex2DNode53 = tex2D( _FX_Slash_Edge, uv0_T_Trail_04 );
			float4 tex2DNode1 = tex2D( _T_Trail_04, uv0_T_Trail_04 );
			o.Emission = ( i.vertexColor * ( ( _Edge_Color * ( ( pow( tex2D( _TX_Slash_04, uv_TX_Slash_04 ).r , _Side_Edge_Pow ) * _Side_Edge_Str ) + ( ( tex2DNode53.r - pow( tex2DNode53.r , _Edge_Pow ) ) * _Edge_Str ) ) ) + ( _Main_Color * ( pow( tex2DNode1.r , _Main_Pow ) * _Main_Str ) ) ) ).rgb;
			float2 appendResult35 = (float2(_Dissolve_Upanner , _Dissolve_Vpanner));
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner37 = ( 1.0 * _Time.y * appendResult35 + uv0_Dissolve_Tex);
			#ifdef _DISSOLVE_PREVIEW_ON
				float staticSwitch47 = ( i.uv2_tex4coord2.z + _Dissolve_Str );
			#else
				float staticSwitch47 = i.uv2_tex4coord2.z;
			#endif
			float2 uv_T_Center_Gra_05 = i.uv_texcoord * _T_Center_Gra_05_ST.xy + _T_Center_Gra_05_ST.zw;
			o.Alpha = ( ( ( i.vertexColor.a * tex2DNode1.r ) * saturate( step( _Dissolve_Step , ( tex2D( _Dissolve_Tex, panner37 ).r + staticSwitch47 ) ) ) ) * tex2D( _T_Center_Gra_05, uv_T_Center_Gra_05 ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
8;823;1738;1166;1877.215;186.865;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;34;-1894.916,661.3705;Float;False;Property;_Dissolve_Upanner;Dissolve_Upanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1891.016,744.5715;Float;False;Property;_Dissolve_Vpanner;Dissolve_Vpanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-1856.335,-554.1283;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;38;-1410.504,575.7029;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-1613.265,-275.7364;Float;False;Property;_Edge_Pow;Edge_Pow;14;0;Create;True;0;0;False;0;0;1.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1400.468,841.4695;Float;False;Property;_Dissolve_Str;Dissolve_Str;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-1841.925,369.9825;Float;True;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;35;-1681.716,640.5717;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;53;-1581.634,-534.7785;Float;True;Property;_FX_Slash_Edge;FX_Slash_Edge;1;0;Create;True;0;0;False;0;e3b67ee5dce1e28448c765360fa1b909;5de57986d443e3948b090c71b87b4ef9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;37;-1493.216,398.7709;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;57;-1448.72,-291.9113;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-1566.726,-684.9457;Float;False;Property;_Side_Edge_Pow;Side_Edge_Pow;18;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1659.233,-44.31418;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;70;-1839.026,-846.2461;Float;True;Property;_TX_Slash_04;TX_Slash_04;15;0;Create;True;0;0;False;0;753fdcdfc16d71b40ac4cac398ec71c5;753fdcdfc16d71b40ac4cac398ec71c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1247.559,747.3516;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;47;-1151.959,615.1517;Float;False;Property;_Dissolve_Preview;Dissolve_Preview;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-1241.016,370.1708;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;5;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;54;-1179.22,-513.9856;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1334.288,-12.13608;Float;True;Property;_T_Trail_04;T_Trail_04;0;0;Create;True;0;0;False;0;e3b67ee5dce1e28448c765360fa1b909;5de57986d443e3948b090c71b87b4ef9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;72;-1381.326,-675.546;Float;False;Property;_Side_Edge_Str;Side_Edge_Str;17;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-1084.299,-270.3602;Float;False;Property;_Edge_Str;Edge_Str;16;0;Create;True;0;0;False;0;4.51;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;74;-1462.026,-810.2461;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1006.543,114.8093;Float;False;Property;_Main_Pow;Main_Pow;4;0;Create;True;0;0;False;0;1;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-950.2993,-501.3602;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-797.4667,260.1176;Float;False;Property;_Dissolve_Step;Dissolve_Step;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-835.4833,118.7569;Float;False;Property;_Main_Str;Main_Str;7;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-1216.026,-795.2461;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-871.5171,474.471;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;-977.5471,-9.588506;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-826.2244,-10.90435;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;3;-439.9465,-202.0158;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;63;-747.2993,-770.3602;Float;False;Property;_Edge_Color;Edge_Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,1;42.08536,38.68843,67.7935,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-841.3978,-217.741;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.7960784,0.6941177,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;41;-641.0601,378.9235;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-1014.026,-782.2461;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-627.7143,-39.69065;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;42;-416.7159,372.0709;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-514.248,128.8936;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-656.2993,-498.3602;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;-569.2993,-240.3602;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-180.9071,355.3476;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-465.3336,665.137;Float;True;Property;_T_Center_Gra_05;T_Center_Gra_05;13;0;Create;True;0;0;False;0;a60748d5292fab94bbeb5406047d2a37;a60748d5292fab94bbeb5406047d2a37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-204.1012,59.05244;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-35.97656,505.713;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;173.3021,3.760918;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_Slash_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Front;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;6;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;0;34;0
WireConnection;35;1;33;0
WireConnection;53;1;52;0
WireConnection;37;0;36;0
WireConnection;37;2;35;0
WireConnection;57;0;53;1
WireConnection;57;1;55;0
WireConnection;46;0;38;3
WireConnection;46;1;28;0
WireConnection;47;1;38;3
WireConnection;47;0;46;0
WireConnection;39;1;37;0
WireConnection;54;0;53;1
WireConnection;54;1;57;0
WireConnection;1;1;2;0
WireConnection;74;0;70;1
WireConnection;74;1;75;0
WireConnection;68;0;54;0
WireConnection;68;1;69;0
WireConnection;73;0;74;0
WireConnection;73;1;72;0
WireConnection;40;0;39;1
WireConnection;40;1;47;0
WireConnection;7;0;1;1
WireConnection;7;1;9;0
WireConnection;8;0;7;0
WireConnection;8;1;10;0
WireConnection;41;0;45;0
WireConnection;41;1;40;0
WireConnection;71;0;73;0
WireConnection;71;1;68;0
WireConnection;5;0;6;0
WireConnection;5;1;8;0
WireConnection;42;0;41;0
WireConnection;48;0;3;4
WireConnection;48;1;1;1
WireConnection;66;0;63;0
WireConnection;66;1;71;0
WireConnection;67;0;66;0
WireConnection;67;1;5;0
WireConnection;49;0;48;0
WireConnection;49;1;42;0
WireConnection;4;0;3;0
WireConnection;4;1;67;0
WireConnection;51;0;49;0
WireConnection;51;1;50;1
WireConnection;0;2;4;0
WireConnection;0;9;51;0
ASEEND*/
//CHKSM=C2C1EE0F4EB384AE1A74CA686D2AFD4018EAAC48