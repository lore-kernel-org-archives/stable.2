Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135A51AEDC;
	Wed, 30 Sep 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789138; cv=none; b=CDUkTp4aS7B8F06Mryfjm+Hoelsush+toGiimN94wiweJAwaEQE2reB9QaDqUck9lCtbOnhjoTyjccUQtSAwmm/0h0iXj+4rJqQrA9dhDlsj5WgHdFbS1U5scQMxU6Jt2dlRrWaw8+AtOShAyjs1ZmcX+lmGOF01AQRu330ecNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789138; c=relaxed/simple;
	bh=gFelgWEJNky+O1pg+cxnRSafEvWBGEUOgEVMGQvT7jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6xX5A6LMS4LX5bmlOaQZsgi6AquE2MmVN97XYzBEvJD6AUGVN88/U0B4r66aaO+Hv2AI6MnJu9P67pHT7qP4JAk06CfZwkjVC4WwXWQlqW0qCmR30PHLX/73zWFQkLCNKmPF4whIG7cyZ6gaAvl4yX5w5O+8vA+JG3YinfytoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYWB+uYn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XYWB+uYn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5583C4E410D4;
	Wed, 30 Sep 2026 17:25:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 294D160749;
	Wed, 30 Sep 2026 17:25:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F5F2103291EA;
	Wed, 30 Sep 2026 19:25:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790789132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bo30wP78bh+sDEn1sCbZk+nfv9Cu1zBtQsbKdC+QipU=;
	b=XYWB+uYnke/3v/cjD6s9SPMSzlzFjX2k1qh2GqNOwJVBMf+mx2P3eCNAdQvIZeVKt+e+Jh
	NjVpx/N6xAn7QnxLj5uNH8etN13N2WFvWoP628WvUKJCwTssLnvIYgKxtANdZKsoxKJAWo
	RsfeyoZutwb/KAKvFedyO78iOGxOgNeTL/jMFCboaaLBh0dHKmgoSi2xCrFMMyma+2TLua
	xoLVF3JKRNiG+jgafknuBddSTgg8U29kEV+bdYjCF7NKGsnHVK4q5eJv/ad8KNqOIacsbl
	VrKnsBjalaEb/JHjRDornSsia6LBZqRKfS56FG5WPYlt1izVKoeWN23jqK3GXA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 30 Sep 2026 19:24:48 +0200
Subject: [PATCH v6 02/12] dt-bindings: clock: ma35d1: Document the missing
 crystal inputs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perso-ma35d1-upstream-clk-v6-2-48937ee6c9bb@bootlin.com>
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
In-Reply-To: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The MA35D1 clock controller takes two crystal oscillator inputs from
the board:
- HXT, a high-speed 24 MHz crystal for most of the system
- LXT, a low-speed 32.768 kHz crytal for the RTC and low power modes

So far the binding was expecting a single crystal. The example named it
HXT, but no real definition for it was given. LXT was not even
described. In order to remain backward compatible, we will continue to
allow either one (HXT) or two (HXT then LXT) input clocks. I propose to
give those phandles a name to clarify what these entries expect, but I'm
not listing the clock-names property in the required block, for backward
compatibility. The rates are fixed by the TRM, so even if the second
oscillator is not described, the OS can make an educated guess.

Fixes: 2f8b5eb589cb ("dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
index 8f0c43683729..9649feda8d7a 100644
--- a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
@@ -29,7 +29,18 @@ properties:
     const: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description:
+      The controller takes 2 crystal oscillator inputs from the board.
+      HXT is a 24 MHz crystal feeding the internal PLLs. LXT is a 32.768
+      kHz crystal, for RTC and low power operations.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: hxt
+      - const: lxt
 
   nuvoton,pll-mode:
     description:
@@ -58,6 +69,7 @@ examples:
         compatible = "nuvoton,ma35d1-clk";
         reg = <0x40460200 0x100>;
         #clock-cells = <1>;
-        clocks = <&clk_hxt>;
+        clocks = <&clk_hxt>, <&clk_lxt>;
+        clock-names = "hxt", "lxt";
     };
 ...

-- 
2.55.0

