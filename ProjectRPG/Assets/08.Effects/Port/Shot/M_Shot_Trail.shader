// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Shot_Trail_01"
{
	Properties
	{
		_T_Aura01("T_Aura01", 2D) = "white" {}
		_Main_Pow("Main_Pow", Float) = 1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Str("Main_Str", Float) = 1
		_Main_US("Main_US", Float) = 0
		_Dissolve_US("Dissolve_US", Float) = 0
		_Main_VS("Main_VS", Float) = 0
		_Dissolve_VS("Dissolve_VS", Float) = 0
		_Flow_US("Flow_US", Float) = 0
		_Flow_VS("Flow_VS", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Flow_Str("Flow_Str", Float) = 0
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Dissolve_Str("Dissolve_Str", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
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
		uniform sampler2D _T_Aura01;
		uniform float _Main_US;
		uniform float _Main_VS;
		uniform sampler2D _TextureSample0;
		uniform float _Flow_US;
		uniform float _Flow_VS;
		uniform float4 _T_Aura01_ST;
		uniform float _Flow_Str;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_US;
		uniform float _Dissolve_VS;
		uniform float4 _Dissolve_Tex_ST;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float _Dissolve_Str;
		uniform sampler2D _Mask_Tex;
		uniform float4 _Mask_Tex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult14 = (float2(_Main_US , _Main_VS));
			float2 appendResult24 = (float2(_Flow_US , _Flow_VS));
			float2 uv0_T_Aura01 = i.uv_texcoord * _T_Aura01_ST.xy + _T_Aura01_ST.zw;
			float2 panner28 = ( 1.0 * _Time.y * appendResult24 + uv0_T_Aura01);
			float2 panner15 = ( 1.0 * _Time.y * appendResult14 + ( ( (tex2D( _TextureSample0, panner28 )).rg * _Flow_Str ) + uv0_T_Aura01 ));
			float temp_output_3_0 = ( pow( tex2D( _T_Aura01, panner15 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_3_0 ) ).rgb;
			float2 appendResult47 = (float2(_Dissolve_US , _Dissolve_VS));
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner49 = ( 1.0 * _Time.y * appendResult47 + uv0_Dissolve_Tex);
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 uv_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( ( temp_output_3_0 * saturate( step( ( ( tex2D( _Dissolve_Tex, panner49 ).r * tex2D( _TextureSample1, uv_TextureSample1 ).r ) + _Dissolve_Str ) , 0.1 ) ) ) * tex2D( _Mask_Tex, uv_Mask_Tex ).r ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-103;250;1586;768;2661.275;-144.6411;1.632449;True;True
Node;AmplifyShaderEditor.RangedFloatNode;26;-2357.35,72.3566;Float;False;Property;_Flow_VS;Flow_VS;9;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2365.915,-10.43552;Float;False;Property;_Flow_US;Flow_US;8;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-2477.256,-174.5921;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;24;-2188.911,8.121399;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;28;-2167.499,-191.7215;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;18;-1965.657,-292.4993;Float;True;Property;_TextureSample0;Texture Sample 0;10;0;Create;True;0;0;False;0;be16ed68839bead46a05797c841163f4;be16ed68839bead46a05797c841163f4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-1835.908,765.0251;Float;False;Property;_Dissolve_US;Dissolve_US;5;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1853.463,859.2443;Float;False;Property;_Dissolve_VS;Dissolve_VS;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1698.726,-64.10754;Float;False;Property;_Flow_Str;Flow_Str;11;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;21;-1675.885,-288.217;Float;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;47;-1658.904,783.582;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-1947.249,600.8685;Float;False;0;34;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;49;-1550.418,626.5626;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1441.785,-212.5622;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1604.513,264.2057;Float;False;Property;_Main_US;Main_US;4;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1595.948,346.9978;Float;False;Property;_Main_VS;Main_VS;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1715.854,100.0491;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-1411.808,24.39435;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1427.509,282.7626;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;34;-1355.316,604.9916;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;13;0;Create;True;0;0;False;0;None;8e84dbcdc4fb83e4583958f01ce815d7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1410.819,965.7629;Float;True;Property;_TextureSample1;Texture Sample 1;15;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1319.023,125.7432;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-1123.508,828.6371;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-983.117,822.1074;Float;False;Property;_Dissolve_Str;Dissolve_Str;14;0;Create;True;0;0;False;0;0;-0.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-900.7799,319.8763;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1145.496,97.29805;Float;True;Property;_T_Aura01;T_Aura01;0;0;Create;True;0;0;False;0;d9036bb668177eb45a98e3168338c4a5;207586e4c62c85048a6a315f429b8e8f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-893.3323,608.2565;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-800.2827,714.3657;Float;False;Constant;_Float1;Float 1;13;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-722.3488,321.3037;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;37;-774.1636,559.2831;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-846.5369,97.19421;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-615.2902,150.0098;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;-615.8159,525.0016;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-457.4686,407.4653;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;-499.9129,627.8458;Float;True;Property;_Mask_Tex;Mask_Tex;12;0;Create;True;0;0;False;0;None;1109c9e56d0361645bf97b74fd820382;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-669.5332,-91.22907;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.398772,0.7830188,2,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-317.078,443.3792;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-473.9727,152.8647;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;7;-295.5415,-61.25264;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-291.2593,154.2922;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-218.4592,328.4409;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_Shot_Trail_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;25;0
WireConnection;24;1;26;0
WireConnection;28;0;27;0
WireConnection;28;2;24;0
WireConnection;18;1;28;0
WireConnection;21;0;18;0
WireConnection;47;0;44;0
WireConnection;47;1;45;0
WireConnection;49;0;46;0
WireConnection;49;2;47;0
WireConnection;22;0;21;0
WireConnection;22;1;29;0
WireConnection;32;0;22;0
WireConnection;32;1;12;0
WireConnection;14;0;16;0
WireConnection;14;1;17;0
WireConnection;34;1;49;0
WireConnection;15;0;32;0
WireConnection;15;2;14;0
WireConnection;51;0;34;1
WireConnection;51;1;50;1
WireConnection;1;1;15;0
WireConnection;36;0;51;0
WireConnection;36;1;42;0
WireConnection;37;0;36;0
WireConnection;37;1;43;0
WireConnection;2;0;1;1
WireConnection;2;1;8;0
WireConnection;3;0;2;0
WireConnection;3;1;9;0
WireConnection;38;0;37;0
WireConnection;39;0;3;0
WireConnection;39;1;38;0
WireConnection;40;0;39;0
WireConnection;40;1;33;1
WireConnection;4;0;6;0
WireConnection;4;1;3;0
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;11;0;7;4
WireConnection;11;1;40;0
WireConnection;0;2;5;0
WireConnection;0;9;11;0
ASEEND*/
//CHKSM=087D437AA8AEBB6CADE1959BB663994E030AFFD9