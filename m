Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134365;
	b=XsFHNgs/eZbxfgtFhowd5de1pKpma9VUWVNvFWV2vgo7gEHBXHDu8dHVrZa/RngAlx5V
	 9Sdmw+ghDfxpDqBPGP28rKZWis73gCBb4HUeMvIlT/lXeWLXveFqtIOcYOH1RXv35fVdJ
	 FShce9xwSlD7dlpqGaM8F1PEG02Zv6OETjtP3GE/8LTE15d7rgbkIyC0uQ6gjRRE4AkxX
	 e5MXQDo6Z3KtCH8Pt+pyhChtAfL6SqOpcNgUQglrIWvOSw0/Kwf3H7vdfCx+qJsJjRVXB
	 LwLDbNb3bbKlViyRooWgNtEF8Hq5x5YQ3ILt6/6TQlFKpDUcwocFgcvteGIsxlVSqTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QFweymMEv8DhRKIaNy7RtmB8ERYH0EjVLWq8evra0p8=;
	b=iQnVLrW6p9oEhdr8dfi8ODP3X4McRNeoWhsUMnZveexkQPUCnevQTcmLP/7ES/yuNND6
	 AbBCSZR9BZjlcMwmGqghlvHK4Trn25LEyPfJ99H08yJbCRkE2+69X1rqirz4Cz+aNDPw8
	 twKXxsVjhs7Iv0Gfa5SD7CxwTxh566tdNgvmnHSpwbSfQwa1AURNGT1yp5zRGUUzeuLNX
	 RcH1LTmQcrwP/JldAIkFrncvG2/1Ml91dZldvi1VQDZAifa20UrCjBsQ0IYE029FOHmnZ
	 qayGGZ9VNCDk6E/C/PwSWCiLmG1MtiPmEdmfU9OVOMVr8ZBIsJGddShhztOk33iOu6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsAePrb9;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9F60A2616
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC9F60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsAePrb9
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490d59c3edaso174738f8f.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134363; x=1795739163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QFweymMEv8DhRKIaNy7RtmB8ERYH0EjVLWq8evra0p8=;
        b=AsAePrb9EkRIpPCiAm33DMP9zvl2+uxn7OVNkOjp4Iq4VaZwO6/f/7msTwkTJSWEFP
         jeB7J3sDfEwjHTM65gRoKJfvpeeAhcYEo/cuHL9VISBt0l3x2iihGo2LUvZc+sx95DKz
         rgUwBCNMjgG2RdjozNyFtJM/lFmFdRcRB3iSztcmPc6TlU5Zh/UifZKwylp1GurBcKxH
         EP5GELp6s5ndln7VkX+QjY+6P0X8fdpBVnb3cwg31u1ssc3lzsCuCArEoUCrVHfEl30z
         aD1uYqoj6Lt7qqEyaH/OB55xh410uGlwDpbly1PSQV7P/fMtJ7ucu05u6/k83ltenaNp
         a83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134363; x=1795739163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QFweymMEv8DhRKIaNy7RtmB8ERYH0EjVLWq8evra0p8=;
        b=qO717yVwOpbbQ/rrYLq7u4M/CEzMwhwrkR+9k9V4wMTL2Szn33ij+ThaGJ5/DvjGXD
         5ZRXwBTpxCVsGofIuNSOzManVFmsX/nw7ArgWPMmVLYgzKd5h5Cv0i34CCRxy/wK9SXi
         u8WTTZMQRdG01YEYOsN4qok4shDZNmxF+K9pGtr/ojVbWc2b1H7p8axzzfDWS30rLauK
         JzlbTdeCbYJJErS0oupGkCpKzmSc8722paLPZLWZaS/HlfKnGSedIL4XZ5NOamIC/aNp
         lvUAKQP0Tx/Q1vJnK/ZRgcnJxRZNx2IWvy26oNG+lEMb+EBpT9aNtnva/iNSZEbEhuLc
         5bAg==
X-Forwarded-Encrypted: i=1; AL+hErHloxRTSx89yWFiJ8cSv7OajdRBUdSwS+WsnAM5sqhboUi/4jMjzL00DE5EsibbDZVxPFy0TnA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WdqmOew9Cxcecs521LPkIVwJlFjk/c/TeT8vs06b7cRK95WJ/
	VVkNyuWWqfgWdfyWsRfHpq3RZROY0jhS9s9mM1esj270/voDr144NBa1
X-Gm-Gg: AZFdTZe39x+TIrtGFZA4C5gxPVgHugKcuqPp/dzRgCgRtEn2xouqPWewb/2fbXVVSIL
	Cz5i1pKh6YBpakwM57U5NJMl/28yOsaGI7M4Uor0gqJ+zn5oyqt0Mrfv5qXsyT27DWgCF5HuaYZ
	8qFXIK2Ns7Pi/tAYvl/Bj3dxlBdsRRJyUFTVEIX9mZfISmdJmfG0B1MjENrlF1fsQFmFm5qPIfD
	QmckDP0ZQw1+WT1/8SsbKtUGIPiXuhdYkToYYv7W6aRQ3U5N6nxZ5S6IFmQ8kas/SXejEY/gS6K
	OHV2bJhJVNT/0RMCrKuU/WkqPgg22KkQQPMnQwx2UdzZXZSYcZ8FRgnG+3u0LgwcMLY9YAqnfA+
	KdkZocBi6ZN+jIKEO9Ey+cN/P4jlej6vPuIeSD4RssmzTuUlkUlH3Ldv/4fp4cNQqVWxI6iuaJa
	KLOlrz/1KQGPu9wb6strcwzpS0U2xfDbtXngF35qBc+ZhbYs2wD63RgfhmOyAY45VO6RzRREt+4
	301gxmLhqLCsSNVkv32Gk3reh7FWfHTNmo+kZcBmquyTR2zEfZt2DjDU2lJq+KxYJWHJxJ9RqOH
	PCQSDdfhSmCC6HvMbcH7j3BGMhbw2k1Xv5J0fH21b1SKohdY7Sttwlww4cU049E6stPK2NFitJc
	oTbWtmEeeptxPI7j62AAf6aHvVpnf7YR9s8xrHPhl/Y7jAL+/oy5vGxYsHGfqmBaYTOp+ciSb
X-Received: by 2002:a05:6000:184b:b0:4a7:9630:7b36 with SMTP id ffacd0b85a97d-4abb3f15ddbmr2216640f8f.21.1795134362863;
        Thu, 19 Nov 2026 16:26:02 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:c5c5:590b:f4b8:3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm2629998f8f.55.2026.11.19.16.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:26:02 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v5 09/24] net: dsa: rzn1-a5psw: Fix VLANTransmitted counter offset
Date: Fri, 20 Nov 2026 00:25:19 +0000
Message-ID: <20261120002549.1908299-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/N1 hardware manual places the VLANTransmittedOK counter at
offset 0x8f4, not 0x8ec. Correct the register offset so the driver
reads the counter from the right location.

Fixes: c7243fd4a62f ("net: dsa: rzn1-a5psw: add statistics support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/net/dsa/rzn1_a5psw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index d54acedac194..9693f8503b0b 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -185,7 +185,7 @@
 #define A5PSW_etherStatsFragments		0x8E0
 
 #define A5PSW_VLANReceived			0x8E8
-#define A5PSW_VLANTransmitted			0x8EC
+#define A5PSW_VLANTransmitted			0x8F4
 
 #define A5PSW_aDeferred				0x910
 #define A5PSW_aMultipleCollisions		0x914
-- 
2.56.1

