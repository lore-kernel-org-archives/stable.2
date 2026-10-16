Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63623B7B98
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193297; cv=none; b=hjANsQvIvw9lLcEsC+Xk1edr7yFqdgGHwpiFmUtsw/KbKjEKUMf1H7jLWcoErpwvMMLy0MU8k0jpZV0N4WbEZgWGbZR2LLEQA86nP6x9gAxrnqxBubl3pjjKC9/E8bMbvaC+fJd4S9yTqMZvVNwBkYHol33tbtpz3/QZ79Cm1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193297; c=relaxed/simple;
	bh=CwWDDjpNnsPleVo1jcGzFZvinjzTeCjJVRg9u/FiAbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUvX6U5FeDmivVHGCrQEwyGyJ/VtrR8iRVJUpvCYprhuV8BQLpAItjarOaj++1vKr+y8yKednnbhThGD6d2H8HzvkYGrYoi+U9B4f6lCTfC5WQxDaCa2IjE2+ITBI9dSUzPeAJOncSmpGGKJmoNJEAQp40hoaU5YqpKgSHhE00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCHhBeay; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCHhBeay"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso117639241.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792193294; x=1792798094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L+nHfvIYCrgROUwGVGZYqdh67rBw+LFFXBTqFw6Ps2c=;
        b=eCHhBeayH2c+BBa4x/nHClCZ8lniv6DPRcmKmPxMoY+9jb7n3kcb+KyoBQDFF+kdWI
         fsdD04HpWgHZTrfVUhcmPvHlZZJn/KVenJFMDHRh1NKnEekEdXDkyCSNzuKv6dPDfqM7
         wAn7YyyQMJzJRCpiVrIUdicCR6+UxsEquBVg7/2X8Z6JTswcq2W3u4kBsgPm3CxVBj1+
         WxCw3qU7xOlGAgd4EU2ggbuMNmAmKtHwXS2qFXrjUBeuvC2+dzJwtbiIbsCOguu0FCdP
         PBwfNVC8TIx3UnFAq5T2j3Tzdfwq0i1GNY5QZr9nO/h7INeXYzYRy/2poijfn0aVDw0b
         DjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792193294; x=1792798094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+nHfvIYCrgROUwGVGZYqdh67rBw+LFFXBTqFw6Ps2c=;
        b=ICbLcvBvh+3AtsmrY6G9++lXexXNDqDGlgZdL5d+lMZ+2arf1E7JfIjQ6wLiKAxiC1
         8pe/pGiE5tikYSttZXDlrTdnL8GJbix7CgdRAU76j7MYWunnMzPdjJuFocXBkmdmhfIC
         uwIpEtHGqs4z7xeZ0H59t4lJFhRk0yU9unyCUN4VfvfiJMGdj6eOQxynyHURIsP9t5tO
         0YcddvIYg7PAt6V8sEa6f/qBngqOLMemXg6nIIzaKzdC4RSHUOKHLn7Hp0IsL+Rr3wq+
         n4IsnMdkaCEkqsARTjpiLbmTAu8V1fzsV2T8NmqhBMsgpfF9Ldf/hEe6xxgiivfGtIQA
         S8QA==
X-Forwarded-Encrypted: i=1; AKwUvBzYarxb+tWUAsoL0G9DYNRa0m9gAOcpv7Nh9WcpOAbXdSVxW0qDv4PbrAqPUVAIooFvqEBTuyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuxPgeLIJUOaMJNmggT0d0O3rU3DiPPmP0SNC9sq1LRW947BeJ
	mm18MbdGYRVjzqqtb+qGFRX4bEBcuxXSTz4fhnl7kUVsnq8q4USI7pp+
X-Gm-Gg: AYBFou0L5/EqcFUW72AsRIuITfp/qHTqfo1bHGtaJ8QHTlQ8DZPKi+JhcVB25uGs7fg
	Uu/E9MeEWgL8cqWFMZ5pQ7faFDUrmiJ/cAP362oTsLI2pXIVi9PPTcNAEBlACUq7zlbX907hS4Z
	5W4W/ClxehWURJ1T5HH6VfkCsl6lxIqe6I2akLUyFAmOUc1/eWNZQr4dPPTodZiIMOKyECEK+p/
	/53lk3CJkq/uwt31iAhn87+HVv994K+tUDukopOVi4X+7ITO+2LDEvVzOMcKHKFgFhjSRq3Jw+0
	sFPZJSMfNAmAkTcUhaxYrCmA3x2ABe6jfqMaXPGC4npTbVinvVIn1YvVFlLZLG2on8z4meVXsxR
	AdJiKXW0P5D7zA6ovW+VMibYp+WD2ADv/GX1AAimdim2WO0AR82U0JMq3P8qtOQNQgfBGjrEEoL
	sJtjopO5khh8+D54aI7lgC8PiG8l/z0KmE5bRwsf1OYA6X5rObfRDgesNqqF4dF+CHuBUtt8wcy
	fsBZIUsZTOs4IqWODNGqhylgOyzLlk6cvGv/N2DUtxGnDU=
X-Received: by 2002:a05:6102:4247:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7cc3691f50bmr274471137.6.1792193293549;
        Fri, 16 Oct 2026 16:28:13 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:42fc:16d8:d66b:d6c1:caeb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4f58bbsm2804299e0c.10.2026.10.16.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 16:28:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Frank.Li@nxp.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: imx-iim: Allow syscon fallback on i.MX5
Date: Fri, 16 Oct 2026 20:27:59 -0300
Message-ID: <20261016232800.536654-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX51 and i.MX53 SoC device code reads the unique ID through
syscon_regmap_lookup_by_compatible(). Their IIM nodes therefore need the
syscon fallback so the syscon core can instantiate a regmap.

Allow the two-item compatible sequence for these SoCs. This prepares for
restoring the fallback removed while making the IIM nodes conform to the
binding.

Cc: stable@vger.kernel.org
Fixes: d5b55c35e033 ("ARM: dts: imx: Fix the iim compatible string")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/nvmem/imx-iim.yaml    | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
index bb37d72c9eaa..ebfd947e6800 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
@@ -20,13 +20,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx25-iim
-      - fsl,imx27-iim
-      - fsl,imx31-iim
-      - fsl,imx35-iim
-      - fsl,imx51-iim
-      - fsl,imx53-iim
+    oneOf:
+      - enum:
+          - fsl,imx25-iim
+          - fsl,imx27-iim
+          - fsl,imx31-iim
+          - fsl,imx35-iim
+      - items:
+          - enum:
+              - fsl,imx51-iim
+              - fsl,imx53-iim
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -50,7 +54,7 @@ examples:
     #include <dt-bindings/clock/imx5-clock.h>
 
     iim: efuse@63f98000 {
-        compatible = "fsl,imx53-iim";
+        compatible = "fsl,imx53-iim", "syscon";
         reg = <0x63f98000 0x4000>;
         interrupts = <69>;
         clocks = <&clks IMX5_CLK_IIM_GATE>;
-- 
2.43.0

