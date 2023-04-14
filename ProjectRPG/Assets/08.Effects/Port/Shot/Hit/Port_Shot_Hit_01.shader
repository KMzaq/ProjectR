// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_t_flare_d002("t_flare_d002", 2D) = "white" {}
		_Main_Pow("Main_Pow", Float) = 1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Str("Main_Str", Float) = 1
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		_Flow_Tex("Flow_Tex", 2D) = "white" {}
		_Flow_US("Flow_US", Float) = 0
		_Main_UO("Main_UO", Float) = 0
		_Flow_Vs("Flow_Vs", Float) = 0
		_Flow_Str("Flow_Str", Float) = 0
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_step("step", Float) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _t_flare_d002;
		uniform float _Flow_US;
		uniform float _Flow_Vs;
		uniform sampler2D _Flow_Tex;
		uniform float4 _Flow_Tex_ST;
		uniform float _Flow_Str;
		uniform float4 _t_flare_d002_ST;
		uniform float _Main_UO;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _step;
		uniform sampler2D _Mask_Tex;
		uniform float4 _Mask_Tex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult17 = (float2(_Flow_US , _Flow_Vs));
			float2 uv0_Flow_Tex = i.uv_texcoord * _Flow_Tex_ST.xy + _Flow_Tex_ST.zw;
			float2 panner15 = ( 1.0 * _Time.y * appendResult17 + (tex2D( _Flow_Tex, uv0_Flow_Tex )).rg);
			float2 uv0_t_flare_d002 = i.uv_texcoord * _t_flare_d002_ST.xy + _t_flare_d002_ST.zw;
			float2 appendResult26 = (float2(_Main_UO , i.uv_tex4coord.w));
			float temp_output_3_0 = ( pow( tex2D( _t_flare_d002, ( ( panner15 * _Flow_Str ) + ( uv0_t_flare_d002 + appendResult26 ) ) ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_3_0 ) ).rgb;
			float2 uv_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 uv_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			o.Alpha = ( ( ( i.vertexColor.a * temp_output_3_0 ) * saturate( step( ( tex2D( _Dissolve_Tex, uv_Dissolve_Tex ).r + i.uv_tex4coord.z ) , _step ) ) ) * tex2D( _Mask_Tex, uv_Mask_Tex ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
422;1019;1586;780;2123.486;16.55159;1.3;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1905,-291.5;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-1679.1,-325.4999;Float;True;Property;_Flow_Tex;Flow_Tex;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-1502,-21.5;Float;False;Property;_Flow_Vs;Flow_Vs;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1497,-99.5;Float;False;Property;_Flow_US;Flow_US;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1675.807,354.3568;Float;False;Property;_Main_UO;Main_UO;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;20;-1345,-299.5;Float;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-1320,-163.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;36;-1209.844,807.7568;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-1277.058,-66.16816;Float;False;Property;_Flow_Str;Flow_Str;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1453.307,302.0568;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1680.8,87.3;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1088,-272;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-1447.486,173.2484;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1093.758,-107.7682;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1196.3,49.2;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1048,75.5;Float;True;Property;_t_flare_d002;t_flare_d002;0;0;Create;True;0;0;False;0;2bd21bce7e4f78c478b11e393b682d3c;2bd21bce7e4f78c478b11e393b682d3c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;29;-1371.249,544.2333;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-836,296.5;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-903.8445,691.7568;Float;False;Property;_step;step;12;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-980.6692,557.4731;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-764,78.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-669,306.5;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;37;-782.8445,521.7568;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;7;-266,-117.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-619,77.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-585,-133.5;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-519.1,255.4;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-668.8445,495.7568;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-499.56,528.3;Float;True;Property;_Mask_Tex;Mask_Tex;4;0;Create;True;0;0;False;0;1109c9e56d0361645bf97b74fd820382;1109c9e56d0361645bf97b74fd820382;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-458.0445,390.5569;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-404,133.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-227,375.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-244,122.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1680.807,434.9568;Float;False;Property;_Main_VO;Main_VO;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;1;22;0
WireConnection;20;0;14;0
WireConnection;17;0;18;0
WireConnection;17;1;19;0
WireConnection;26;0;27;0
WireConnection;26;1;36;4
WireConnection;15;0;20;0
WireConnection;15;2;17;0
WireConnection;41;0;11;0
WireConnection;41;1;26;0
WireConnection;23;0;15;0
WireConnection;23;1;24;0
WireConnection;21;0;23;0
WireConnection;21;1;41;0
WireConnection;1;1;21;0
WireConnection;30;0;29;1
WireConnection;30;1;36;3
WireConnection;2;0;1;1
WireConnection;2;1;8;0
WireConnection;37;0;30;0
WireConnection;37;1;38;0
WireConnection;3;0;2;0
WireConnection;3;1;9;0
WireConnection;10;0;7;4
WireConnection;10;1;3;0
WireConnection;39;0;37;0
WireConnection;40;0;10;0
WireConnection;40;1;39;0
WireConnection;4;0;6;0
WireConnection;4;1;3;0
WireConnection;13;0;40;0
WireConnection;13;1;12;1
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;0;2;5;0
WireConnection;0;9;13;0
ASEEND*/
//CHKSM=C092C6683BED536B4A92537144774A4EB50A6023