// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Noise_Tex("Noise_Tex", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 1)) = 0.1
		_Noise_US("Noise_US", Float) = 0
		_Dissolve_US("Dissolve_US", Float) = 0
		_Noise_VS("Noise_VS", Float) = 0
		_Dissolve_VS("Dissolve_VS", Float) = 0
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
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
		uniform sampler2D _Main_Tex;
		uniform sampler2D _Noise_Tex;
		uniform float _Noise_US;
		uniform float _Noise_VS;
		uniform float4 _Noise_Tex_ST;
		uniform float _Noise_Str;
		uniform float4 _Main_Tex_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_US;
		uniform float _Dissolve_VS;
		uniform float4 _Dissolve_Tex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult11 = (float2(_Noise_US , _Noise_VS));
			float2 uv0_Noise_Tex = i.uv_texcoord * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
			float2 panner10 = ( 1.0 * _Time.y * appendResult11 + uv0_Noise_Tex);
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float4 tex2DNode1 = tex2D( _Main_Tex, ( ( (UnpackNormal( tex2D( _Noise_Tex, panner10 ) )).xy * _Noise_Str ) + uv0_Main_Tex ) );
			o.Emission = ( i.vertexColor * ( _Main_Color * ( pow( tex2DNode1.g , _Main_Pow ) * _Main_Str ) ) ).rgb;
			float2 appendResult34 = (float2(_Dissolve_US , _Dissolve_VS));
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner30 = ( 1.0 * _Time.y * appendResult34 + uv0_Dissolve_Tex);
			o.Alpha = saturate( step( 0.1 , ( tex2DNode1.g * ( tex2D( _Dissolve_Tex, panner30 ).g + i.uv_tex4coord.z ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
60;26;1738;1073;2131.174;52.88143;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;13;-1900.717,115.8309;Float;False;Property;_Noise_VS;Noise_VS;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1900.716,35.23099;Float;False;Property;_Noise_US;Noise_US;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1863.017,-175.3691;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;11;-1761.617,40.43093;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;10;-1625.116,-155.8692;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;4;-1430,-181.8;Float;True;Property;_Noise_Tex;Noise_Tex;1;0;Create;True;0;0;False;0;3534cbafcd029534db66ec659a66831c;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1193,6.2;Float;False;Property;_Noise_Str;Noise_Str;2;0;Create;True;0;0;False;0;0.1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;6;-1132,-190.8;Float;True;True;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1431.34,634.8187;Float;False;Property;_Dissolve_US;Dissolve_US;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1431.341,715.4186;Float;False;Property;_Dissolve_VS;Dissolve_VS;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-1249.341,642.6185;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1055,178.5464;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-871.4,-42.90003;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1408.374,417.7187;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-744,117.5;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;30;-1193.875,435.9188;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-585,116.5;Float;True;Property;_Main_Tex;Main_Tex;0;0;Create;True;0;0;False;0;3c4141e37f7063542a9fb0a857252fbf;3c4141e37f7063542a9fb0a857252fbf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1010.574,386.5188;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;7;0;Create;True;0;0;False;0;0706cc3db44903a45a66254715783dfc;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-282.5742,304.6186;Float;False;Property;_Main_Pow;Main_Pow;10;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;35;-1000.174,784.3186;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-597.1736,396.918;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;23;-278.6742,175.9186;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-138.2742,313.7186;Float;False;Property;_Main_Str;Main_Str;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-365.7744,451.5185;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-125.2742,196.7186;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;-233.1742,-50.2814;Float;False;Property;_Main_Color;Main_Color;9;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-459.3744,333.2187;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;14;-43.37412,-147.7815;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;34.62581,185.0184;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;20;-350.1745,537.3184;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;21;-218.8745,530.8185;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;74.92599,48.51852;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-825.9742,620.5187;Float;False;Property;_Dissolve_Str;Dissolve_Str;8;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;300.3,-35.09999;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;12;0
WireConnection;11;1;13;0
WireConnection;10;0;9;0
WireConnection;10;2;11;0
WireConnection;4;1;10;0
WireConnection;6;0;4;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;2;0;7;0
WireConnection;2;1;3;0
WireConnection;30;0;29;0
WireConnection;30;2;34;0
WireConnection;1;1;2;0
WireConnection;18;1;30;0
WireConnection;16;0;18;2
WireConnection;16;1;35;3
WireConnection;23;0;1;2
WireConnection;23;1;27;0
WireConnection;24;0;23;0
WireConnection;24;1;28;0
WireConnection;19;0;1;2
WireConnection;19;1;16;0
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;20;0;22;0
WireConnection;20;1;19;0
WireConnection;21;0;20;0
WireConnection;15;0;14;0
WireConnection;15;1;26;0
WireConnection;0;2;15;0
WireConnection;0;9;21;0
ASEEND*/
//CHKSM=C356E978BE94EE72AD64057FDFC0D0BF35D1EBE0