// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_FX_Crack_Normal("FX_Crack_Normal", 2D) = "white" {}
		_FX_Crack_Bump("FX_Crack_Bump", 2D) = "white" {}
		_FX_Crack_Alpha("FX_Crack_Alpha", 2D) = "white" {}
		_FX_Crack_Base("FX_Crack_Base", 2D) = "white" {}
		_Base_Brightness("Base_Brightness", Range( 1 , 10)) = 1
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Base_Color("Base_Color", Color) = (1,1,1,1)
		_Dissolve_Upanner("Dissolve_Upanner", Float) = 0
		_Dissolve_Vpanner("Dissolve_Vpanner", Float) = 0
		_Smoothness("Smoothness", Float) = 0
		_Dissolve_Str("Dissolve_Str", Float) = 0
		[Toggle(_DISSOLVE_PREVIEW_ON)] _Dissolve_Preview("Dissolve_Preview", Float) = 0
		_Bump_Offset("Bump_Offset", Range( 0 , 1)) = 0
		_Dissolve_Step("Dissolve_Step", Float) = 0
		_Mask_Range("Mask_Range", Range( 0 , 10)) = 3.963373
		_T_Center_Gra_05("T_Center_Gra_05", 2D) = "white" {}
		_Opacity("Opacity", Float) = 1
		_Mask_Str("Mask_Str", Float) = 0
		_Emi_Pow("Emi_Pow", Range( 1 , 100)) = 1
		[HDR]_Emi_Color("Emi_Color", Color) = (1,1,1,1)
		_Noise_Tex("Noise_Tex", 2D) = "white" {}
		_Noise_US("Noise_US", Float) = 0
		_Noise_VS("Noise_VS", Float) = 0
		_Noise_Pow("Noise_Pow", Range( 1 , 10)) = 1
		_Noise_Str("Noise_Str", Float) = 1
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
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
		#pragma shader_feature _DISSOLVE_PREVIEW_ON
		#pragma surface surf Standard alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
			float4 uv2_tex4coord2;
		};

		uniform sampler2D _FX_Crack_Normal;
		uniform float4 _FX_Crack_Normal_ST;
		uniform float4 _Base_Color;
		uniform sampler2D _FX_Crack_Base;
		uniform float4 _FX_Crack_Base_ST;
		uniform sampler2D _FX_Crack_Bump;
		uniform float4 _FX_Crack_Bump_ST;
		uniform float _Bump_Offset;
		uniform float _Base_Brightness;
		uniform float _Emi_Pow;
		uniform sampler2D _Noise_Tex;
		uniform float _Noise_US;
		uniform float _Noise_VS;
		uniform float4 _Noise_Tex_ST;
		uniform float _Noise_Pow;
		uniform float _Noise_Str;
		uniform sampler2D _FX_Crack_Alpha;
		uniform float4 _FX_Crack_Alpha_ST;
		uniform float _Opacity;
		uniform float _Mask_Range;
		uniform float4 _Emi_Color;
		uniform float _Smoothness;
		uniform float _Dissolve_Step;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_Upanner;
		uniform float _Dissolve_Vpanner;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve_Str;
		uniform sampler2D _T_Center_Gra_05;
		uniform float4 _T_Center_Gra_05_ST;
		uniform float _Mask_Str;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FX_Crack_Normal = i.uv_texcoord * _FX_Crack_Normal_ST.xy + _FX_Crack_Normal_ST.zw;
			o.Normal = tex2D( _FX_Crack_Normal, uv_FX_Crack_Normal ).rgb;
			float2 uv0_FX_Crack_Base = i.uv_texcoord * _FX_Crack_Base_ST.xy + _FX_Crack_Base_ST.zw;
			float2 uv_FX_Crack_Bump = i.uv_texcoord * _FX_Crack_Bump_ST.xy + _FX_Crack_Bump_ST.zw;
			float4 tex2DNode3 = tex2D( _FX_Crack_Bump, uv_FX_Crack_Bump );
			float2 Offset13 = ( ( tex2DNode3.r - 1 ) * i.viewDir.xy * _Bump_Offset ) + uv0_FX_Crack_Base;
			float4 tex2DNode5 = tex2D( _FX_Crack_Base, Offset13 );
			o.Albedo = ( _Base_Color * ( tex2DNode5 * _Base_Brightness ) ).rgb;
			float temp_output_22_0 = ( 1.0 - tex2DNode5.r );
			float temp_output_29_0 = saturate( pow( temp_output_22_0 , _Emi_Pow ) );
			float2 appendResult38 = (float2(_Noise_US , _Noise_VS));
			float2 uv0_Noise_Tex = i.uv_texcoord * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
			float2 panner37 = ( 1.0 * _Time.y * appendResult38 + uv0_Noise_Tex);
			float2 uv_FX_Crack_Alpha = i.uv_texcoord * _FX_Crack_Alpha_ST.xy + _FX_Crack_Alpha_ST.zw;
			float4 tex2DNode4 = tex2D( _FX_Crack_Alpha, uv_FX_Crack_Alpha );
			float4 temp_output_31_0 = ( ( temp_output_29_0 + ( temp_output_29_0 * ( ( pow( tex2D( _Noise_Tex, panner37 ).r , _Noise_Pow ) * _Noise_Str ) * saturate( pow( ( ( temp_output_22_0 + ( tex2DNode4.r * _Opacity ) ) * tex2DNode4.r ) , _Mask_Range ) ) ) ) ) * _Emi_Color );
			o.Emission = ( temp_output_31_0 * i.vertexColor ).rgb;
			o.Smoothness = _Smoothness;
			float2 appendResult52 = (float2(_Dissolve_Upanner , _Dissolve_Vpanner));
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner56 = ( 1.0 * _Time.y * appendResult52 + uv0_Dissolve_Tex);
			#ifdef _DISSOLVE_PREVIEW_ON
				float staticSwitch59 = ( i.uv2_tex4coord2.z + _Dissolve_Str );
			#else
				float staticSwitch59 = i.uv2_tex4coord2.z;
			#endif
			float2 uv_T_Center_Gra_05 = i.uv_texcoord * _T_Center_Gra_05_ST.xy + _T_Center_Gra_05_ST.zw;
			float4 tex2DNode62 = tex2D( _T_Center_Gra_05, uv_T_Center_Gra_05 );
			o.Alpha = ( i.vertexColor.a * ( temp_output_31_0 * ( saturate( step( _Dissolve_Step , ( tex2D( _Dissolve_Tex, panner56 ).r + staticSwitch59 ) ) ) * pow( tex2DNode62.r , _Mask_Str ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
314;383;1553;680;2572.864;-780.6982;1.680449;True;True
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;15;-1440.343,350.6604;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;3;-1575.93,34.78067;Float;True;Property;_FX_Crack_Bump;FX_Crack_Bump;1;0;Create;True;0;0;False;0;e661874df71a3e642b78ebe8ffa060be;e661874df71a3e642b78ebe8ffa060be;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1556.343,257.6604;Float;False;Property;_Bump_Offset;Bump_Offset;13;0;Create;True;0;0;False;0;0;0.047;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-1184.343,-108.3396;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;13;-1103.343,192.6604;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1309.838,743.8944;Float;False;Property;_Noise_US;Noise_US;22;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1309.838,832.8944;Float;False;Property;_Noise_VS;Noise_VS;23;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1178.212,962.8947;Float;True;Property;_FX_Crack_Alpha;FX_Crack_Alpha;2;0;Create;True;0;0;False;0;faabe6be8f43de74588e91d5203976bf;faabe6be8f43de74588e91d5203976bf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-743,157;Float;True;Property;_FX_Crack_Base;FX_Crack_Base;3;0;Create;True;0;0;False;0;bc856bafa5babcf439fb6031c3028131;fa5992be171775d4e92b6b2e0236423b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-926.1242,1207.623;Float;False;Property;_Opacity;Opacity;17;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-804.2185,991.7737;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-1381.838,609.8944;Float;False;0;36;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;38;-1134.839,763.8944;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;22;-979.8992,444.5924;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1689.549,1717.264;Float;False;Property;_Dissolve_Upanner;Dissolve_Upanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1685.649,1800.465;Float;False;Property;_Dissolve_Vpanner;Dissolve_Vpanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;37;-982.4427,678.7624;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-637.007,988.8738;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-301.6325,1198.627;Float;False;Property;_Mask_Range;Mask_Range;15;0;Create;True;0;0;False;0;3.963373;1.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-585.6143,862.8853;Float;False;Property;_Noise_Pow;Noise_Pow;24;0;Create;True;0;0;False;0;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-386.2655,955.0684;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-1636.558,1425.876;Float;True;0;58;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;52;-1476.349,1696.465;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1113.2,1884.363;Float;False;Property;_Dissolve_Str;Dissolve_Str;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;55;-1151.836,1687.496;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;36;-732.7384,672.4801;Float;True;Property;_Noise_Tex;Noise_Tex;21;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;42;-434.6143,693.8853;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-321.6143,852.8853;Float;False;Property;_Noise_Str;Noise_Str;25;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;24;-170.6171,964.5909;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-971.1466,554.0198;Float;False;Property;_Emi_Pow;Emi_Pow;19;0;Create;True;0;0;False;0;1;12.7;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-948.5909,1798.045;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;56;-1287.848,1454.665;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;26;-10.48708,962.3514;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;27;-647.1979,460.292;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-1035.648,1426.065;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;5;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;3c73dfa19da0d594ebc6f3a130921b63;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-267.6143,693.8853;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;59;-946.5909,1671.045;Float;False;Property;_Dissolve_Preview;Dissolve_Preview;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;29;-491.819,461.8039;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-80.79614,814.1733;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-666.1489,1530.365;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-698.8059,1323.705;Float;False;Property;_Dissolve_Step;Dissolve_Step;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-331.3635,409.1475;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;101.9378,1865.841;Float;False;Property;_Mask_Str;Mask_Str;18;0;Create;True;0;0;False;0;0;0.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;61;-435.6919,1434.817;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;62;-256.055,1722.11;Float;True;Property;_T_Center_Gra_05;T_Center_Gra_05;16;0;Create;True;0;0;False;0;a60748d5292fab94bbeb5406047d2a37;a60748d5292fab94bbeb5406047d2a37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;63;-190.482,1453.467;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;66;250.2849,1680.407;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;32;-79.8158,599.4714;Float;False;Property;_Emi_Color;Emi_Color;20;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.7247341,0.6001848,3.184314,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-226.3303,499.5136;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-110.6222,491.3799;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;59.83744,1564.493;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-620.431,373.8736;Float;False;Property;_Base_Brightness;Base_Brightness;4;0;Create;True;0;0;False;0;1;2.28;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-327,256;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;34;58.61865,262.208;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-311,46;Float;False;Property;_Base_Color;Base_Color;6;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;162.0032,824.435;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-860.2896,-81.52481;Float;False;Property;_Normal_Scale;Normal_Scale;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-104,192;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;182.6187,533.208;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-652,-134;Float;True;Property;_FX_Crack_Normal;FX_Crack_Normal;0;0;Create;True;0;0;False;0;7cf302784ae0b524eba97a825abd3b82;7cf302784ae0b524eba97a825abd3b82;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;84.55326,1708.222;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-108.2896,351.4752;Float;False;Property;_Smoothness;Smoothness;9;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;29.80176,476.5259;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;16;-1168.343,39.66042;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;390.4863,-4.073537;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;17;0
WireConnection;13;1;3;0
WireConnection;13;2;14;0
WireConnection;13;3;15;0
WireConnection;5;1;13;0
WireConnection;19;0;4;1
WireConnection;19;1;20;0
WireConnection;38;0;40;0
WireConnection;38;1;41;0
WireConnection;22;0;5;1
WireConnection;37;0;39;0
WireConnection;37;2;38;0
WireConnection;21;0;22;0
WireConnection;21;1;19;0
WireConnection;23;0;21;0
WireConnection;23;1;4;1
WireConnection;52;0;51;0
WireConnection;52;1;50;0
WireConnection;36;1;37;0
WireConnection;42;0;36;1
WireConnection;42;1;44;0
WireConnection;24;0;23;0
WireConnection;24;1;25;0
WireConnection;57;0;55;3
WireConnection;57;1;54;0
WireConnection;56;0;53;0
WireConnection;56;2;52;0
WireConnection;26;0;24;0
WireConnection;27;0;22;0
WireConnection;27;1;28;0
WireConnection;58;1;56;0
WireConnection;43;0;42;0
WireConnection;43;1;45;0
WireConnection;59;1;55;3
WireConnection;59;0;57;0
WireConnection;29;0;27;0
WireConnection;46;0;43;0
WireConnection;46;1;26;0
WireConnection;60;0;58;1
WireConnection;60;1;59;0
WireConnection;48;0;29;0
WireConnection;48;1;46;0
WireConnection;61;0;49;0
WireConnection;61;1;60;0
WireConnection;63;0;61;0
WireConnection;66;0;62;1
WireConnection;66;1;64;0
WireConnection;30;0;29;0
WireConnection;30;1;48;0
WireConnection;31;0;30;0
WireConnection;31;1;32;0
WireConnection;67;0;63;0
WireConnection;67;1;66;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;69;0;31;0
WireConnection;69;1;67;0
WireConnection;8;0;9;0
WireConnection;8;1;6;0
WireConnection;35;0;34;4
WireConnection;35;1;69;0
WireConnection;65;0;62;1
WireConnection;65;1;64;0
WireConnection;33;0;31;0
WireConnection;33;1;34;0
WireConnection;16;0;3;1
WireConnection;16;1;14;0
WireConnection;16;2;15;0
WireConnection;0;0;8;0
WireConnection;0;1;1;0
WireConnection;0;2;33;0
WireConnection;0;4;11;0
WireConnection;0;9;35;0
ASEEND*/
//CHKSM=327D84C5B45EA950C6B1AFD3A54E973B4F6F69C0