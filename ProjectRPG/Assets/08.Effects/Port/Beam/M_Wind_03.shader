// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_FloorWind_01"
{
	Properties
	{
		_T_Wind_01("T_Wind_01", 2D) = "white" {}
		_Flow_Tex("Flow_Tex", 2D) = "bump" {}
		_Flow_US("Flow_US", Float) = -0.91
		_Main_US("Main_US", Float) = -0.91
		_Flow_VS("Flow_VS", Float) = 0
		_Main_VS("Main_VS", Float) = 0
		_Flow_Str("Flow_Str", Range( 0 , 1)) = 0.0245109
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Dissolve_Step("Dissolve_Step", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform sampler2D _T_Wind_01;
		uniform sampler2D _Flow_Tex;
		uniform float _Flow_US;
		uniform float _Flow_VS;
		uniform float4 _Flow_Tex_ST;
		uniform float _Flow_Str;
		uniform float _Main_US;
		uniform float _Main_VS;
		uniform float4 _T_Wind_01_ST;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve_Step;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color6 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult16 = (float2(_Flow_US , _Flow_VS));
			float2 uv0_Flow_Tex = i.uv_texcoord * _Flow_Tex_ST.xy + _Flow_Tex_ST.zw;
			float2 panner12 = ( 1.0 * _Time.y * appendResult16 + uv0_Flow_Tex);
			float2 appendResult29 = (float2(_Main_US , _Main_VS));
			float2 uv0_T_Wind_01 = i.uv_texcoord * _T_Wind_01_ST.xy + _T_Wind_01_ST.zw;
			float2 appendResult39 = (float2(( uv0_T_Wind_01.x + i.uv_tex4coord.w ) , uv0_T_Wind_01.y));
			float2 panner26 = ( 1.0 * _Time.y * appendResult29 + appendResult39);
			float temp_output_7_0 = ( color6.r * tex2D( _T_Wind_01, ( ( (UnpackNormal( tex2D( _Flow_Tex, panner12 ) )).xy * _Flow_Str ) + panner26 ) ).r );
			o.Emission = ( i.vertexColor * temp_output_7_0 ).rgb;
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( temp_output_7_0 * saturate( step( ( tex2D( _Dissolve_Tex, uv0_Dissolve_Tex ).r + i.uv_tex4coord.z ) , _Dissolve_Step ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
132;1009;1738;857;2300.675;93.23302;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;14;-1917.68,231.8296;Float;False;Property;_Flow_VS;Flow_VS;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1921.68,157.8296;Float;False;Property;_Flow_US;Flow_US;2;0;Create;True;0;0;False;0;-0.91;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2068.679,-86.17042;Float;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;16;-1783.68,139.8296;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-1613.031,229.0199;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;42;-1610.375,525.567;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;12;-1730.68,-51.17042;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1385.276,635.1764;Float;False;Property;_Main_VS;Main_VS;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1540.688,-112.9496;Float;True;Property;_Flow_Tex;Flow_Tex;1;0;Create;True;0;0;False;0;3534cbafcd029534db66ec659a66831c;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1407.574,392.9669;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1389.276,561.1765;Float;False;Property;_Main_US;Main_US;3;0;Create;True;0;0;False;0;-0.91;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1225.258,532.7694;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-1290.574,300.667;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1172.553,110.5809;Float;False;Property;_Flow_Str;Flow_Str;6;0;Create;True;0;0;False;0;0.0245109;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;21;-1247.68,-111.1704;Float;True;True;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-1005.062,531.4187;Float;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-777.0619,525.4187;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;7;0;Create;True;0;0;False;0;3c19741a8ea5d4849bec9fd97d9519c2;3c19741a8ea5d4849bec9fd97d9519c2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;26;-1098.66,280.2318;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;34;-637.0619,768.4187;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-910.2925,-50.72986;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-484.2619,503.7187;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-740.51,50.1571;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-365.2619,744.7186;Float;False;Property;_Dissolve_Step;Dissolve_Step;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-628.4615,-57.9397;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;35;-189.6619,516.6187;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-785.8063,240.4886;Float;True;Property;_T_Wind_01;T_Wind_01;0;0;Create;True;0;0;False;0;278aafb4c57e7c34398c466a126f6375;278aafb4c57e7c34398c466a126f6375;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;37;1.638092,510.8187;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-386,178;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-282.0619,368.4187;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;8;-380.4614,-59.9397;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-137.9075,272.276;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-175.6298,149.4992;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;71.10805,-9.116416;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_FloorWind_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;13;0
WireConnection;16;1;14;0
WireConnection;12;0;11;0
WireConnection;12;2;16;0
WireConnection;10;1;12;0
WireConnection;40;0;17;1
WireConnection;40;1;42;4
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;39;0;40;0
WireConnection;39;1;17;2
WireConnection;21;0;10;0
WireConnection;31;1;32;0
WireConnection;26;0;39;0
WireConnection;26;2;29;0
WireConnection;23;0;21;0
WireConnection;23;1;24;0
WireConnection;33;0;31;1
WireConnection;33;1;34;3
WireConnection;22;0;23;0
WireConnection;22;1;26;0
WireConnection;35;0;33;0
WireConnection;35;1;36;0
WireConnection;1;1;22;0
WireConnection;37;0;35;0
WireConnection;7;0;6;1
WireConnection;7;1;1;1
WireConnection;38;0;7;0
WireConnection;38;1;37;0
WireConnection;25;0;8;4
WireConnection;25;1;38;0
WireConnection;9;0;8;0
WireConnection;9;1;7;0
WireConnection;0;2;9;0
WireConnection;0;9;25;0
ASEEND*/
//CHKSM=4BE6CF6551722FCA7CC725FFB4B3F742AD7DDB09