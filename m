Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874545;
	b=5Nc9BLrPCkojppnxQiOWTxrH6MpqrzPWYgHIrJ5FlEPFCURgtTFaATJb/x372SLu2akd
	 mRe/+4liQX/YrzD13UIqpk/eoolMktXEf+o9/HsW9U9Ovn3dNIdmSlj9SeDqjI/gjzpJV
	 TUdLWWmr7vVie+ZRXI4tnM24yuHZq6JCA15qbau3OpQAHta1uy/vy+w2B3V4laMekXHp9
	 xHWnPfoqGWsVOoi6C2mBrp8AR+wKXtl7nQ/3nybJ//kYNnVJa527w7HjKnDqMDjJuAXSm
	 P4QxYiXVxYxY8AmkMm+uBKPH4l/7ESE7+6YWJR0X7VLILVCemYStFwfd3SHPqRX4ROQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6hANZJB2Azv54bDyM4oKWaAqx1DIkGLLUuu1pUJ8+bU=;
	b=htJbJGAeJqK+Jgs46sLePbzU3sSswegGOmm+u7MN6BbYnmcaCObuJlrdeUUrwYltsV47
	 bcFyXvt/c7LvG/b0xCmlWzB7aGMX5Yi+XQSekFFoxb6CIpJr1ue4AaIpJkRV0Oh654DoP
	 8JWhh4GToEmYnNQmEMu8JYV26LyXNya13tDpz2QuSdl3iKeIuMoE3OvZygdIuKsrvcLX1
	 8ljOM/mNq/vpXUoq3bFmRbUTziW5yaVhs4LYTpdwi2jBC8QJ+P7E/bSMmy9rr4lk9pvHW
	 FGpbEi0wTB0gtUUubH35YdAAc2ZcpWMNi8jYJEZwNdioehxOt1wCuW6baxR9mEFrrwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=0wRnwcbH;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E829606D80A
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E829606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=0wRnwcbH
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b561b60b78so696062a12.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 02:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1793874543; x=1794479343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hANZJB2Azv54bDyM4oKWaAqx1DIkGLLUuu1pUJ8+bU=;
        b=0wRnwcbHBDXCOMw+mNKHeFRL4AwbI6yrcXn5GRDkodHv8/+T94lI5/17TOlFhmSDNk
         xKdJlNMTUQEP+9bsWQithmvKn5GAg6J2hW4dEpTERqTd2d4vD/ps+7CqmyI+fvcpU3wv
         ygLREqTdfUz4kmd0BW+6gng80Zoq/GUYIMFoVRyT+FDapWpE9YTci5IDO8xZ2iFuRTlj
         4jmWFzdPacgYetRKp9+qXF61ySUlmH7FRssfo+uPN9j3ACpSJcRdrOhBTsGNXSB5noh8
         LeD47MJqtlKUgfnm7vN11dtazS+2Nl1KLymo/4+nxFcDe4SEjFU6EkxOE5W6Y4z7m3FT
         L5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874543; x=1794479343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6hANZJB2Azv54bDyM4oKWaAqx1DIkGLLUuu1pUJ8+bU=;
        b=GN1jBKXaliGWrvoMZF9QsLC1eYhKY2bxhlxwqI5StrUK/30zD84A7+ZvumrMzvDvr8
         BjEm8d5fsA8OuYStXEGUhzQbAA4FVjySYEGnu/HVHeTFmLIiqL/Q8b291FjpPI/N6XD5
         5/O6U7SH7G4DUaqzaj5PUKHLb9ZXljjSQtB+lpRIgg+NHa8PoxbaAURky2rKLwKQtuQJ
         vdxLgTG9c/AfYhFgKvlyy+8jJDg2KLYBBXchEd9NSbTsES101wB1BJ4qfzi9c9PX+KJA
         4cXN54Pu7XnqQ8QNbHlxfRbJl4+yr4AYPrWgwxiRnE0qpHCWRHeM0yABTsOz1xYouYTK
         GEpA==
X-Forwarded-Encrypted: i=1; AKwUvBzdSBK6qRygUaG8L/S+8jo8a8YU7Va1PwRcMncanE5kHbcNJEO6sed/EGc6UlE4c4lKmxYakJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q38SXIu2hMgIJ5QBqXyhOQ2JLfU5peB28ucOYjSpE99DyN2Zp
	qzn9xoPWohS5k65diS/8iSXj1GmWu+ROOegduaGTfjnv0KleDnIFXRqjfi3R6IcRX/4=
X-Gm-Gg: AYBFou0qF5BZRbXZ0SaJYbxsj7nfRsTQKkf/PweDkMIirSFfo40ieKALiqiFIF7B2/J
	lajYHJPaXPfMlm7A6he9XLwSeA28XE+sbbzEFXkiUaZPbVH7QlHMeo4plt+63fDHdUBvYm4mdk2
	6sfMotnY/Gs/iaIkJwRW059hAnyz7746e6qw2kddKouAdInnqcIvAfGFqei3O6kg/xIypJpWe/h
	79qgAuUSd+/YD1XHg9+5oM2E4JT70bx0wMY71iLUPqdjy16+Sjuihp/UgwpTHsfRsOVc1mxo6RB
	o0QaAFjwQPH1ALQPOPdg/A3p3+yMc2diCBh5z5lWcd2gr8voTgCZ0pp000ZtLCdM7pxp3gcRm2O
	n/JaQbH9NZYT1NoWFDBI/Oebso/TXgKAQZZpY7VpFk8pgjqDIM6zG/8XbFkVAt86XD4KTNatZO5
	MQIxVfSMbMg5CchjRMata7kYEynhHY7LnEn8XNy/JO+BFnU4zJ5lSDBbI59DefMIDym4zjuXpmF
	4GQ02ksTKU37u6Gm8lKudkYbPyWnIlKKZT+1olPNLSC98rE3HY/gsDYJ3xpNdA81ua4APElkQsV
	/BbZBKqPNgDNBDYY6koSMmdcqZOjpGsC0WyLVj2tLilRM7HoSLvLEDt1CLYB9/dtPeWuFvqVWqZ
	qJf6i/yfJPp8=
X-Received: by 2002:a17:907:3e0c:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c4d206f22dcmr174044466b.18.1793874542649;
        Thu, 05 Nov 2026 02:29:02 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5864a87c1sm278665a12.2.2026.11.05.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:29:02 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 05 Nov 2026 11:29:00 +0100
Subject: [PATCH v3 1/3] dt-bindings: media: i2c: dw9800: Redocument DW9800K
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-dw9800k_cleanup-v3-1-6850ee6a5a5a@fairphone.com>
References: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
In-Reply-To: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793874541; l=4474;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=JHsk8t4k0NZ/ewosQGK5JWUdcdnvV4ysNURYZvCFlcY=;
 b=oyPS1ksp83aCOZM8rLYrzBHtsAgqXH6Us4lrCSRrPMwn0DUWjkYjpeq2R5GcVNG7nwM0hTMYT
 ugXFK4bJBILC9xpBCKZdJEHcb2yo6gtC3Z/utzScuCksPc0Pbe7MV3d
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

The DW9800K's properties are too different to justify sharing the same
bindings file as the dw9719, Create a separate bindings documentation
for the Dongwoon Anatech DW9800K with its updated properties.

More specifically:

The DW9800K did not share the SAC1 and SAC6 modes
that the DW9719 used.

Description of vcm-prescale does not match the calculations labeled in
the DW9800K datasheet for how clock diving rate is computed.

New property timing-control introduced to offer more fine-tuned dividing
options available to the DW9800K.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 .../bindings/media/i2c/dongwoon,dw9719.yaml        |  1 -
 .../bindings/media/i2c/dongwoon,dw9800k.yaml       | 91 ++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
index 8e8d62436e0d0c4f9af9e52262b23881abd37cec..38db0764c0f70ad49295dcddc182b7e100a68b29 100644
--- a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
@@ -21,7 +21,6 @@ properties:
       - dongwoon,dw9718s
       - dongwoon,dw9719
       - dongwoon,dw9761
-      - dongwoon,dw9800k
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f5bae7b287f1bbfba0c974431bc8faf232c06c45
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9800k.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/dongwoon,dw9800k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dongwoon Anatech DW9800K Bi-Direction Voice Coil Motor (Bi-VCM) Controller
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+  - Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+
+description:
+  The Dongwoon DW9800K is a single 10-bit digital-to-analog converter with
+  +-130 mA output current sink capability, designed for linear control of
+  bi-directional voice coil motors (Bi-VCM) in camera lenses. This chip
+  provides a Smart Actuator Control (SAC) mode intended for minimizing
+  mechanical vibration.
+
+properties:
+  compatible:
+    enum:
+      - dongwoon,dw9800k
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: VDD power supply, can range from 2.3V to 4.8V
+
+  dongwoon,sac-mode:
+    description: >
+      Slew Rate Control mode to use: direct, LSC (Linear Slope Control) or
+      SAC2-SAC5 (Smart Actuator Control).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # Direct mode
+      - 1 # LSC mode
+      - 2 # SAC2 mode (operation time# 0.48 x Tvib)
+      - 3 # SAC3 mode (operation time# 0.72 x Tvib)
+      - 4 # SAC4 mode (operation time# 1.20 x Tvib)
+      - 5 # SAC5 mode (operation time# 1.64 x Tvib)
+    default: 3
+
+  dongwoon,vcm-prescale:
+    description:
+      Indication of VCM internal clock dividing rate select, as one multiple
+      factor to calculate VCM ring periodic time Tvib.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 #  Dividing Rate -  2
+      - 1 #  Dividing Rate -  1
+      - 2 #  Dividing Rate -  1/2
+      - 3 #  Dividing Rate -  1/4
+      - 4 #  Dividing Rate -  8
+      - 5 #  Dividing Rate -  4
+    default: 1
+
+  dongwoon,timing-control:
+    description:
+      In LSC mode (252 + value * 4) * divider value in microseconds
+      In SAC mode (6.3 + value * 0.1) * divider value in milliseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x00
+    maximum: 0x3f
+    default: 0x20
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        actuator@c {
+            compatible = "dongwoon,dw9800k";
+            reg = <0x0c>;
+
+            vdd-supply = <&pm8937_l17>;
+
+            dongwoon,sac-mode = <4>;
+            dongwoon,vcm-presc = <0>;
+            dongwoon,timing-control = <16>;
+        };
+    };

-- 
2.43.0

