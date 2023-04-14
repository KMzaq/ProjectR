// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_02/Crack_Exp/Rock"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask On
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Cutoff = 1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color16 = IsGammaSpace() ? float4(0,0,0,1) : float4(0,0,0,1);
			o.Albedo = color16.rgb;
			float2 uv0_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			o.Emission = ( _Main_Color * ( pow( tex2D( _TextureSample0, uv0_TextureSample0 ).r , 15.84 ) * 27.31 ) ).rgb;
			o.Alpha = 1;
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float temp_output_8_0 = ( tex2D( _Dissolve_Tex, uv0_Dissolve_Tex ).r + i.uv_tex4coord.z );
			clip( saturate( step( 0.2 , temp_output_8_0 ) ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
120;666;1738;1131;2151.062;-288.6151;1.334303;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1618.248,489.5743;Float;False;0;6;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1922.398,128.1125;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1482.788,335.9625;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;15.84;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;9;-1382.543,758.5143;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1269.869,509.5903;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;2;0;Create;True;0;0;False;0;None;3c19741a8ea5d4849bec9fd97d9519c2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1621.41,88.93331;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;3fe1213c565022a49b6a6d3a9a66d60e;3fe1213c565022a49b6a6d3a9a66d60e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-943.9322,551.9286;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;17;-1261.606,154.6439;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1133.011,380.9707;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;27.31;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-951.3748,402.0295;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-1004.921,-90.23053;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,0.1794164,0.07075471,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;11;-750.4306,455.6942;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-947.8345,164.9315;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-206.6191,889.4912;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1270.676,1280.055;Float;False;Property;_Dissolve;Dissolve;5;0;Create;True;0;0;False;0;0;0.02;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-933.6765,1060.055;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;33;-446.6191,777.4912;Float;False;Property;_Edge_Color;Edge_Color;7;1;[HDR];Create;True;0;0;False;0;1,1,1,1;4,0.6999909,0.3584905,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;10;-430.8635,451.9562;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-830.6192,937.4912;Float;False;Property;_Edge_Thiness;Edge_Thiness;6;0;Create;True;0;0;False;0;0.1684038;1.01;0.1;1.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;-382.6191,1001.491;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;30;-542.6192,1017.491;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1541.368,1083.1;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;3;-495.014,198.6696;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-390.0551,-208.7509;Float;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;False;0;0,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-121.0878,48.0542;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;26;-1294.343,1066.312;Float;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;False;0;925d68cc41b84a040a94ef783801c784;925d68cc41b84a040a94ef783801c784;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-748.2145,1169.393;Float;False;Constant;_Float4;Float 4;9;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-667.3204,-45.52173;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;31;-542.6192,1145.492;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;117.4025,121.5785;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Port_02/Crack_Exp/Rock;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;1;True;False;0;True;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;1;7;0
WireConnection;1;1;23;0
WireConnection;8;0;6;1
WireConnection;8;1;9;3
WireConnection;17;0;1;1
WireConnection;17;1;18;0
WireConnection;11;0;12;0
WireConnection;11;1;8;0
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;34;0;33;0
WireConnection;34;1;32;0
WireConnection;29;0;26;1
WireConnection;29;1;25;0
WireConnection;10;0;11;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;30;0;28;0
WireConnection;30;1;8;0
WireConnection;22;0;16;0
WireConnection;22;1;3;0
WireConnection;26;1;24;0
WireConnection;4;0;2;0
WireConnection;4;1;19;0
WireConnection;31;0;27;0
WireConnection;31;1;8;0
WireConnection;0;0;16;0
WireConnection;0;2;4;0
WireConnection;0;10;10;0
ASEEND*/
//CHKSM=1DDDFCF6A8BB6F059BB1C098188184472BD093F5