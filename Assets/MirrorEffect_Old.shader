Shader "Fx/MirrorEffect_Old"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MirrorDirection ("Mirror Direction", int) = 0 // 0: Horizontal, 1: Vertical
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            int _MirrorDirection;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                if (_MirrorDirection == 0) // Horizontal
                {
                    uv.x = 1 - uv.x;
                }
                else // Vertical
                {
                    uv.y = 1 - uv.y;
                }
                fixed4 col = tex2D(_MainTex, uv);
                return col;
            }
            ENDCG
        }
    }
}
