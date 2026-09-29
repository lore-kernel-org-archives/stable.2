Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904852CCC4;
	Tue, 29 Sep 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693146; cv=none; b=pZR3b432aphqwVJMNvo6xfKnPhJWAJKrGrOu0I14F0ju3j7v54wMJ9J9sLstuEmoLZbTbkzF6tFangbpXJWZp3VIt6LnFH2DLwO4dVt+SB5MW+q9HJI+KoN1iJ6KbbS4kEkFZQM6/CCJHTxNT4nsBKCL4yQntHMwNAn6MqTkuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693146; c=relaxed/simple;
	bh=Twb6Vi/4J7ssk0EwkgIgu0lEhcp0CvYGappAxYYsl+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD7yVgCQXsoRgEglIFmPMuem6lsYAZ0qdgs/+JBpwYWKH5OELvIjsAoipBLE5e11kxOtOu353ofdIVXynBgDHy/GvvKR18ioVBqFGJxUE2yQ0/LURsUqUmxMtPWNkorX6dXJgJDu1m6bXhQGQsANuDXURB54wPXlZ3K7AUpmV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bWoogI3C; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bWoogI3C"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A49274E410BE;
	Tue, 29 Sep 2026 14:45:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 799E5601BD;
	Tue, 29 Sep 2026 14:45:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A585910329812;
	Tue, 29 Sep 2026 16:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790693134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FI8MM4zLwxVlmw7VDmYSwTBJd8VFU5MfFASzd6xayQ4=;
	b=bWoogI3CaFjR6U8nd0ppQkYmcXE6298N8V+dpnuvYsLhEfl0sx960SD3XS6nMkIZcZFn28
	vuwJzEs89FUiquQ3hu3YWwYn98B7ujYHmNdBraNx1iKDNiymU/xValPG04KoA1/+EIKtyA
	Y8Yy6AaBitGmdlxb0l9zgyh47nPW2TohAzTHgySCXrfo4FPeQTexxwg791ys2e7TAhErI/
	Se7fy67e64db8S0Kkg3u13CUYXga0WJwsURcurFC9QbUXaTYrjdJgyWDL5BEWkrW7ueBwT
	aQykMjvH1LHRqm10fUhjkgfH/fV03+bf7S4TfA74YYrnXRPT6OYe/1PXtdzC4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 29 Sep 2026 16:44:45 +0200
Subject: [PATCH v5 2/9] dt-bindings: clock: ma35d1: Document the missing
 crystal inputs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-perso-ma35d1-upstream-clk-v5-2-68533e935ee4@bootlin.com>
References: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
In-Reply-To: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chi-Fang Li <cfli0@nuvoton.com>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
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

