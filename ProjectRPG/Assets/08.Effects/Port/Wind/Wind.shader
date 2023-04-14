// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Wind"
{
	Properties
	{
		_T_Ramp_01("T_Ramp_01", 2D) = "white" {}
		_Flow_Tex("Flow_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Flow_US("Flow_US", Float) = 0.2
		_Main_Pow("Main_Pow", Float) = 1
		_Flow_VS("Flow_VS", Float) = 0.2
		_Main_Str("Main_Str", Float) = 1
		_Flow_Str("Flow_Str", Float) = 0.1
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Dissolve_Step("Dissolve_Step", Float) = 0
		_Dissolve_US("Dissolve_US", Float) = 0
		_Dissolve_VS("Dissolve_VS", Float) = 0
		_T_Gra_04("T_Gra_04", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
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
		uniform sampler2D _T_Ramp_01;
		uniform sampler2D _Flow_Tex;
		uniform float _Flow_US;
		uniform float _Flow_VS;
		uniform float4 _Flow_Tex_ST;
		uniform float _Flow_Str;
		uniform float4 _T_Ramp_01_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_US;
		uniform float _Dissolve_VS;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve_Step;
		uniform sampler2D _T_Gra_04;
		uniform float4 _T_Gra_04_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult38 = (float2(_Flow_US , _Flow_VS));
			float2 uv0_Flow_Tex = i.uv_texcoord * _Flow_Tex_ST.xy + _Flow_Tex_ST.zw;
			float2 panner40 = ( 1.0 * _Time.y * appendResult38 + uv0_Flow_Tex);
			float2 uv0_T_Ramp_01 = i.uv_texcoord * _T_Ramp_01_ST.xy + _T_Ramp_01_ST.zw;
			float2 appendResult33 = (float2(uv0_T_Ramp_01.x , ( uv0_T_Ramp_01.y + i.uv_tex4coord.w )));
			float2 panner46 = ( 1.0 * _Time.y * float2( 0,0 ) + appendResult33);
			float temp_output_6_0 = ( pow( tex2D( _T_Ramp_01, ( ( (tex2D( _Flow_Tex, panner40 )).rg * _Flow_Str ) + panner46 ) ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_6_0 ) ).rgb;
			float2 appendResult26 = (float2(_Dissolve_US , _Dissolve_VS));
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * appendResult26 + uv0_Dissolve_Tex);
			float2 uv_T_Gra_04 = i.uv_texcoord * _T_Gra_04_ST.xy + _T_Gra_04_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( ( temp_output_6_0 * saturate( step( ( tex2D( _Dissolve_Tex, panner25 ).r - i.uv_tex4coord.z ) , _Dissolve_Step ) ) ) * tex2D( _T_Gra_04, uv_T_Gra_04 ).r ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
245;482;1553;728;2910.523;338.8031;1.529153;True;True
Node;AmplifyShaderEditor.RangedFloatNode;37;-2170.481,130.7188;Float;False;Property;_Flow_VS;Flow_VS;6;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2175.683,37.11917;Float;False;Property;_Flow_US;Flow_US;4;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-2357.685,-179.9812;Float;False;0;41;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;38;-2022.281,-88.98108;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1747.722,190.3571;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;34;-1803.342,320.9912;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;40;-1868.882,-151.3811;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1587.127,666.3994;Float;False;Property;_Dissolve_US;Dissolve_US;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-1587.492,356.4504;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;-1681.681,-164.3813;Float;True;Property;_Flow_Tex;Flow_Tex;2;0;Create;True;0;0;False;0;45e2f27a139a6df4296246a771284cab;abcf0070d0e42804aae399bdec42ce41;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-1502.626,788.5992;Float;False;Property;_Dissolve_VS;Dissolve_VS;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-1487.392,252.4505;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1692.189,502.9489;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;-1233.115,59.10718;Float;False;Property;_Flow_Str;Flow_Str;8;0;Create;True;0;0;False;0;0.1;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;42;-1348.881,-148.7811;Float;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1384.469,609.8663;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1068.328,-128.9483;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;46;-1306.108,162.2861;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;25;-1225.851,549.7173;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;17;-859.5154,779.1802;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-973.7059,-5.295109;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-963.7588,542.8835;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;9;0;Create;True;0;0;False;0;bfb3234fe1c0b0844918b83e24a1f28d;bfb3234fe1c0b0844918b83e24a1f28d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-698.5,357;Float;False;Property;_Main_Pow;Main_Pow;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-635.634,564.136;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-876.5,128;Float;True;Property;_T_Ramp_01;T_Ramp_01;1;0;Create;True;0;0;False;0;c999e1a476be16b4a842a7c1e4fa3633;c999e1a476be16b4a842a7c1e4fa3633;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-539.8954,771.8156;Float;False;Property;_Dissolve_Step;Dissolve_Step;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-473.5,354;Float;False;Property;_Main_Str;Main_Str;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;5;-580.5,170;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;20;-476.5604,599.4857;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-313.068,623.6877;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-435.5,171;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;47;-361.9111,827.641;Float;True;Property;_T_Gra_04;T_Gra_04;13;0;Create;True;0;0;False;0;1109c9e56d0361645bf97b74fd820382;1109c9e56d0361645bf97b74fd820382;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-421.5,-33;Float;False;Property;_Main_Color;Main_Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-293.9208,368.8751;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-293.5,172;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-53.65356,579.6948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;11;-182.5,-46;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-137.7928,367.4022;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-140.5,172;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;88,-27;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_Wind;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;36;0
WireConnection;38;1;37;0
WireConnection;40;0;39;0
WireConnection;40;2;38;0
WireConnection;35;0;4;2
WireConnection;35;1;34;4
WireConnection;41;1;40;0
WireConnection;33;0;4;1
WireConnection;33;1;35;0
WireConnection;42;0;41;0
WireConnection;26;0;29;0
WireConnection;26;1;30;0
WireConnection;44;0;42;0
WireConnection;44;1;43;0
WireConnection;46;0;33;0
WireConnection;25;0;16;0
WireConnection;25;2;26;0
WireConnection;45;0;44;0
WireConnection;45;1;46;0
WireConnection;14;1;25;0
WireConnection;18;0;14;1
WireConnection;18;1;17;3
WireConnection;3;1;45;0
WireConnection;5;0;3;1
WireConnection;5;1;12;0
WireConnection;20;0;18;0
WireConnection;20;1;21;0
WireConnection;22;0;20;0
WireConnection;6;0;5;0
WireConnection;6;1;13;0
WireConnection;24;0;6;0
WireConnection;24;1;22;0
WireConnection;7;0;10;0
WireConnection;7;1;6;0
WireConnection;48;0;24;0
WireConnection;48;1;47;1
WireConnection;23;0;11;4
WireConnection;23;1;48;0
WireConnection;8;0;11;0
WireConnection;8;1;7;0
WireConnection;2;2;8;0
WireConnection;2;9;23;0
ASEEND*/
//CHKSM=F89CC020C8078A98EA69AE1FA5D199CE7DF53982