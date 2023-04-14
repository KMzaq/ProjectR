// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Ice"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Ice_Normal("Ice_Normal", 2D) = "white" {}
		_Fresnel_Color("Fresnel_Color", Color) = (1,1,1,1)
		_Height("Height", Float) = 0
		_Noise_Tex("Noise_Tex", 2D) = "white" {}
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 2.659654
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 0
		_Normal_Str("Normal_Str", Range( 0 , 1)) = 0.3783424
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		_Edge_Thinless("Edge_Thinless", Range( 0.1 , 1)) = 0.17
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,1)
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
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
			float4 uv_tex4coord;
		};

		uniform sampler2D _Main_Tex;
		uniform sampler2D _Ice_Normal;
		uniform float4 _Ice_Normal_ST;
		uniform sampler2D _Noise_Tex;
		uniform float4 _Noise_Tex_ST;
		uniform float _Height;
		uniform float4 _Fresnel_Color;
		uniform float _Normal_Str;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float4 _Edge_Color;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform sampler2D _Mask_Tex;
		uniform float4 _Mask_Tex_ST;
		uniform float _Edge_Thinless;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 _Vector0 = float2(0,0.05);
			float2 uv0_Ice_Normal = i.uv_texcoord * _Ice_Normal_ST.xy + _Ice_Normal_ST.zw;
			float2 panner9 = ( 1.0 * _Time.y * _Vector0 + uv0_Ice_Normal);
			float2 uv0_Noise_Tex = i.uv_texcoord * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
			float2 paralaxOffset12 = ParallaxOffset( tex2D( _Noise_Tex, uv0_Noise_Tex ).r , _Height , i.viewDir );
			float4 tex2DNode1 = tex2D( _Main_Tex, ( panner9 + paralaxOffset12 ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV18 = dot( UnpackScaleNormal( tex2D( _Ice_Normal, uv0_Ice_Normal ), _Normal_Str ), ase_worldViewDir );
			float fresnelNode18 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV18, _Fresnel_Pow ) );
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner28 = ( 1.0 * _Time.y * _Vector0 + uv0_Dissolve_Tex);
			float2 uv_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			float4 tex2DNode38 = tex2D( _Mask_Tex, uv_Mask_Tex );
			float temp_output_29_0 = ( ( tex2D( _Dissolve_Tex, panner28 ).r * tex2DNode38.r ) + i.uv_tex4coord.z );
			float temp_output_44_0 = step( 0.1 , temp_output_29_0 );
			o.Emission = ( ( i.vertexColor * tex2DNode1 ) + ( ( ( _Fresnel_Color * saturate( fresnelNode18 ) ) + tex2DNode1 ) * ( _Edge_Color * ( temp_output_44_0 * ( 1.0 - step( _Edge_Thinless , temp_output_29_0 ) ) ) ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( temp_output_44_0 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
121;993;1738;866;2205.761;-445.1321;1.3;True;True
Node;AmplifyShaderEditor.Vector2Node;11;-1498.21,153.0195;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0,0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1748.425,748.3947;Float;False;0;26;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;28;-1512.799,745.2075;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;38;-1280.161,1158.832;Float;True;Property;_Mask_Tex;Mask_Tex;10;0;Create;True;0;0;False;0;0066cab539610d543970ac09a340fd73;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;26;-1325.432,718.5754;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;8;0;Create;True;0;0;False;0;a8cdb4639adce744d9e63580e11edf14;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-2093.134,301.7302;Float;False;0;16;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2488.895,-268.0771;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-2391.524,1.456342;Float;False;Property;_Normal_Str;Normal_Str;7;0;Create;True;0;0;False;0;0.3783424;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;37;-1564.7,1026.849;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1107.26,1002.832;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-986.5912,721.6632;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1820.134,273.7302;Float;True;Property;_Noise_Tex;Noise_Tex;4;0;Create;True;0;0;False;0;a8cdb4639adce744d9e63580e11edf14;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2117.645,-240.9491;Float;True;Property;_Ice_Normal;Ice_Normal;1;0;Create;True;0;0;False;0;4d0de14058fc6e04394c421dbbf27a62;4d0de14058fc6e04394c421dbbf27a62;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1584.697,5.331112;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1534.134,476.7302;Float;False;Property;_Height;Height;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2002.041,-22.53354;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1944.183,67.78133;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;5;0;Create;True;0;0;False;0;2.659654;3;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;13;-1560.134,568.7302;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;45;-1131.961,588.132;Float;False;Property;_Edge_Thinless;Edge_Thinless;11;0;Create;True;0;0;False;0;0.17;0.1;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-1276.726,19.7403;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1041.114,296.8335;Float;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;18;-1696.469,-189.0514;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;31;-773.7839,690.1433;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;12;-1350.817,359.8998;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-1084.134,23.73016;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;7;-1269.57,-405.228;Float;False;Property;_Fresnel_Color;Fresnel_Color;2;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;44;-853.7599,403.5323;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;-514.4599,755.8323;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;-1283.755,-172.1177;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-617.1598,408.7322;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-934,-21.5;Float;True;Property;_Main_Tex;Main_Tex;0;0;Create;True;0;0;False;0;108c849f405c0dd469e22b6d77046e18;108c849f405c0dd469e22b6d77046e18;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;49;-678.2599,194.2321;Float;False;Property;_Edge_Color;Edge_Color;12;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-1036.801,-207.3969;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-415.6599,272.2321;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-825.1265,-255.3766;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;34;-461.0172,-288.6754;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-558.661,-77.4678;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-379.26,79.83209;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;33;-316.1411,612.3355;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-218.7984,218.4437;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-212.8607,-52.76785;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-741.9601,1065.232;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-635.3601,933.932;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1599.169,910.013;Float;False;Property;_Dissolve_Str;Dissolve_Str;9;0;Create;True;0;0;False;0;-0.01639022;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-19.22623,-51.42489;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_Ice;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;27;0
WireConnection;28;2;11;0
WireConnection;26;1;28;0
WireConnection;42;0;26;1
WireConnection;42;1;38;1
WireConnection;29;0;42;0
WireConnection;29;1;37;3
WireConnection;16;1;17;0
WireConnection;2;1;22;0
WireConnection;2;5;21;0
WireConnection;9;0;8;0
WireConnection;9;2;11;0
WireConnection;18;0;2;0
WireConnection;18;2;19;0
WireConnection;18;3;20;0
WireConnection;31;0;45;0
WireConnection;31;1;29;0
WireConnection;12;0;16;1
WireConnection;12;1;14;0
WireConnection;12;2;13;0
WireConnection;10;0;9;0
WireConnection;10;1;12;0
WireConnection;44;0;32;0
WireConnection;44;1;29;0
WireConnection;47;0;31;0
WireConnection;23;0;18;0
WireConnection;46;0;44;0
WireConnection;46;1;47;0
WireConnection;1;1;10;0
WireConnection;24;0;7;0
WireConnection;24;1;23;0
WireConnection;48;0;49;0
WireConnection;48;1;46;0
WireConnection;25;0;24;0
WireConnection;25;1;1;0
WireConnection;52;0;34;0
WireConnection;52;1;1;0
WireConnection;50;0;25;0
WireConnection;50;1;48;0
WireConnection;33;0;44;0
WireConnection;36;0;34;4
WireConnection;36;1;33;0
WireConnection;51;0;52;0
WireConnection;51;1;50;0
WireConnection;40;0;29;0
WireConnection;40;1;38;1
WireConnection;41;0;40;0
WireConnection;41;1;38;1
WireConnection;0;2;51;0
WireConnection;0;9;36;0
ASEEND*/
//CHKSM=D7ECC11A0FA3BFEAF81D14FA58FF4F62B75FE2E6