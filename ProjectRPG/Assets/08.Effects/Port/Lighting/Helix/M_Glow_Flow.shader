// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Glow_Flow"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Flow_Tex("Flow_Tex", 2D) = "white" {}
		_Flow_US("Flow_US", Float) = 0.2
		_Flow_VS("Flow_VS", Float) = 0.2
		_Flow_Str("Flow_Str", Float) = 0.1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		_T_Center_Gra_05("T_Center_Gra_05", 2D) = "white" {}
		_T_Ramp_2("T_Ramp_2", 2D) = "white" {}
		_Edge_Pow("Edge_Pow", Float) = 0
		_Float0("Float 0", Float) = 0
		_Main_US("Main_US", Float) = 0
		_Main_VS("Main_VS", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Tex;
		uniform sampler2D _Flow_Tex;
		uniform float _Flow_US;
		uniform float _Flow_VS;
		uniform float4 _Flow_Tex_ST;
		uniform float _Flow_Str;
		uniform float _Main_US;
		uniform float _Main_VS;
		uniform float4 _Main_Tex_ST;
		uniform sampler2D _T_Ramp_2;
		uniform float4 _T_Ramp_2_ST;
		uniform float _Edge_Pow;
		uniform float _Float0;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _T_Center_Gra_05;
		uniform float4 _T_Center_Gra_05_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult8 = (float2(_Flow_US , _Flow_VS));
			float2 uv0_Flow_Tex = i.uv_texcoord * _Flow_Tex_ST.xy + _Flow_Tex_ST.zw;
			float2 panner5 = ( 1.0 * _Time.y * appendResult8 + uv0_Flow_Tex);
			float2 appendResult42 = (float2(_Main_US , _Main_VS));
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float2 panner44 = ( 1.0 * _Time.y * appendResult42 + uv0_Main_Tex);
			float4 tex2DNode1 = tex2D( _Main_Tex, ( ( (tex2D( _Flow_Tex, panner5 )).rg * _Flow_Str ) + panner44 ) );
			float2 uv_T_Ramp_2 = i.uv_texcoord * _T_Ramp_2_ST.xy + _T_Ramp_2_ST.zw;
			o.Emission = ( i.vertexColor * ( _Main_Color * ( pow( ( tex2DNode1.r * ( tex2DNode1.r + ( pow( tex2D( _T_Ramp_2, uv_T_Ramp_2 ).r , _Edge_Pow ) * _Float0 ) ) ) , _Main_Pow ) * _Main_Str ) ) ).rgb;
			float2 uv_T_Center_Gra_05 = i.uv_texcoord * _T_Center_Gra_05_ST.xy + _T_Center_Gra_05_ST.zw;
			o.Alpha = ( ( tex2DNode1.r * i.vertexColor.a ) * tex2D( _T_Center_Gra_05, uv_T_Center_Gra_05 ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
534;923;1738;1013;646.363;-148.7787;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;6;-1883.028,42.7774;Float;False;Property;_Flow_US;Flow_US;2;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1877.826,136.3771;Float;False;Property;_Flow_VS;Flow_VS;3;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1729.626,-83.32286;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2065.03,-174.3229;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;5;-1576.227,-145.7229;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;3;-1389.026,-158.723;Float;True;Property;_Flow_Tex;Flow_Tex;1;0;Create;True;0;0;False;0;45e2f27a139a6df4296246a771284cab;abcf0070d0e42804aae399bdec42ce41;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-1535.172,407.1955;Float;False;Property;_Main_VS;Main_VS;13;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1546.172,314.1955;Float;False;Property;_Main_US;Main_US;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;14;-1056.226,-143.1228;Float;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-940.4594,64.7654;Float;False;Property;_Flow_Str;Flow_Str;4;0;Create;True;0;0;False;0;0.1;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-1386.382,351.0989;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1028.391,163.0973;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-775.6725,-123.2901;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1063.132,677.7545;Float;False;Property;_Edge_Pow;Edge_Pow;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;44;-1356.348,178.9485;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;32;-1194.756,405.4796;Float;True;Property;_T_Ramp_2;T_Ramp_2;9;0;Create;True;0;0;False;0;118af2890916c06469dd7ce72a5b4244;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-654.6418,662.3092;Float;False;Property;_Float0;Float 0;11;0;Create;True;0;0;False;0;0;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;-883.1316,435.7545;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-681.0509,0.3631248;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-539.9434,43.45102;Float;True;Property;_Main_Tex;Main_Tex;0;0;Create;True;0;0;False;0;6b1f2bbdeee94be4ab6ccc893baca05a;21fc304ce48ade34581a3b14f2170845;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-632.6418,450.3092;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-480.8616,435.2847;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-253.8976,444.1278;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-272.0666,255.0985;Float;False;Property;_Main_Pow;Main_Pow;6;0;Create;True;0;0;False;0;1;2.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;20;-214.6418,69.16339;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-76.78547,253.7424;Float;False;Property;_Main_Str;Main_Str;7;0;Create;True;0;0;False;0;1;4.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-114.6418,-178.8366;Float;False;Property;_Main_Color;Main_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.584314,0.9411765,4,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;25;156.3582,-173.8366;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-74.64185,91.16339;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-9.419143,503.7268;Float;True;Property;_T_Center_Gra_05;T_Center_Gra_05;8;0;Create;True;0;0;False;0;a60748d5292fab94bbeb5406047d2a37;da819415ba7abcc44ac07778333f7d70;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;100.2269,277.8;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;75.35815,101.1634;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;216.3582,95.16339;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;267.4121,329.5311;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;45;29.07858,745.1076;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;430.7285,-134.9354;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Glow_Flow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;5;0;4;0
WireConnection;5;2;8;0
WireConnection;3;1;5;0
WireConnection;14;0;3;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;18;0;14;0
WireConnection;18;1;19;0
WireConnection;44;0;2;0
WireConnection;44;2;42;0
WireConnection;33;0;32;1
WireConnection;33;1;35;0
WireConnection;17;0;18;0
WireConnection;17;1;44;0
WireConnection;1;1;17;0
WireConnection;38;0;33;0
WireConnection;38;1;39;0
WireConnection;36;0;1;1
WireConnection;36;1;38;0
WireConnection;37;0;1;1
WireConnection;37;1;36;0
WireConnection;20;0;37;0
WireConnection;20;1;27;0
WireConnection;21;0;20;0
WireConnection;21;1;28;0
WireConnection;26;0;1;1
WireConnection;26;1;25;4
WireConnection;22;0;24;0
WireConnection;22;1;21;0
WireConnection;23;0;25;0
WireConnection;23;1;22;0
WireConnection;31;0;26;0
WireConnection;31;1;29;1
WireConnection;0;2;23;0
WireConnection;0;9;31;0
ASEEND*/
//CHKSM=B45EEF47A8F812F99AFDB065DBF91FB02053E179