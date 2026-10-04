Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4B4A5C2C;
	Sun,  4 Oct 2026 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146793; cv=none; b=NUFon0mr1KrVW4/Sf5ESBH4tFk+MkeiTeXA9fRlAlNvGJHRgHvfhZrii67SbEubWGCUkPGpGNB26PYMxB2tZA6LxfB1zFgEdsbCfO9D4sxFhvK/gME3IWy4HIEb7HzTAotcex1pn8ZwBcY/tWwTt1u35FQxRFlGUreKsy6Ys5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146793; c=relaxed/simple;
	bh=UhU8EbEOtqCrfjuijH8O/mBa9qjwd+8AvJxLCfIoVXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ws6M1lNBnRoXIUh3Qph2/qGo++sAYCmCI45KqJXR0TsNgiKykn8QQqblFMb5ySOswqmx8zIOKuCg0Ly37EDhdGptHKUWzOM9YipByHLWKlwHymHhHKboKpZGCRmWUOh748vhLFJY7EJon1yl0sWqgQDIIF3aiPPmk6kuZWjbPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wxaKFQoD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wxaKFQoD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A90404E41169;
	Sun,  4 Oct 2026 20:46:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B491604FE;
	Sun,  4 Oct 2026 20:46:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1288E10328444;
	Sun,  4 Oct 2026 22:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791146788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xRUOLn+0uupo7iNkW5FhrG2D7k4fCJvpBZyXP4n6GKA=;
	b=wxaKFQoDXYAawzMIM+1ERQsl6x9PluWticO3Dmz6xajgRqijUEAv2hkYShuZ09moPkRpKw
	f2Cr/O9trchcERcxAAfeUOp63YhmUputIv/gRBaUzGpKYGw9tEXsI1tZ5sD0lg1rqTsoCA
	p2Nc68Gigp1y6koVnDJK4D1jBfjc4u+wOpGkeub6kuJkh5TjzqoHLyJBjIFAFTT+W+xvyf
	RaD4jsUGYxY564bt9M6sDteUOjAV1M+aBFmn7kS3zzUYY88n4WTz5at3NkPaOJJkAXJKxy
	dyTl+XHAnI1jp51li3tqLkkEB0EVUDWNQ15p37ktXp+zzIWgCwj/vaJj9ixA2Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Sun, 04 Oct 2026 22:45:28 +0200
Subject: [PATCH v8 4/7] clk: nuvoton: ma35d1: Reparent the gates correctly
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-perso-ma35d1-upstream-clk-v8-4-e1a106a128c0@bootlin.com>
References: <20261004-perso-ma35d1-upstream-clk-v8-0-e1a106a128c0@bootlin.com>
In-Reply-To: <20261004-perso-ma35d1-upstream-clk-v8-0-e1a106a128c0@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
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

The clock tree is still incorrect. There are four main clocks in this
system:
- HXT: external high-speed crystal oscillator
- LXT: external low-speed crystal oscillator
- HIRC: internal high-speed RC oscillator
- LIRC: internal low-speed RC oscillator
Each clock has a 'gate' control to disable it. While in the TRM the
'gate' appears aside, in the CCF topology, the gates should be
below. This is because if we gate one of those clocks, none of the
children clocks continue ticking.

Reparent hxt_gate under hxt, and all hxt children under hxt_gate.
Do the same for the three other clock sources listed above.

After this change, the frequencies are identical, but the clock tree
looks much closer to the reality.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 78 +++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index ed61a990870e..2e6e1c65d01e 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -74,34 +74,46 @@ static const struct clk_parent_data lxtg_parent_data[] = {
 };
 
 /* Mux parent selection, by index into the controller's clock table */
-static const int ca35clk_parent_idx[] = { HXT, CAPLL, DDRPLL };
+static const int ca35clk_parent_idx[] = { HXT_GATE, CAPLL, DDRPLL };
 static const int sysclk0_parent_idx[] = { EPLL_DIV2, SYSPLL };
-static const int sysclk1_parent_idx[] = { HXT, SYSPLL };
+static const int sysclk1_parent_idx[] = { HXT_GATE, SYSPLL };
 static const int axiclk_parent_idx[] = { AXICLK_DIV2, AXICLK_DIV4 };
-static const int ccap_parent_idx[] = { HXT, VPLL, APLL, SYSPLL };
+static const int ccap_parent_idx[] = { HXT_GATE, VPLL, APLL, SYSPLL };
 static const int sdh_parent_idx[] = { SYSPLL, APLL };
 static const int dcu_parent_idx[] = { EPLL_DIV2, SYSPLL };
 static const int gfx_parent_idx[] = { EPLL, SYSPLL };
-static const int dbg_parent_idx[] = { HIRC, SYSPLL };
-static const int timer0_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
-static const int timer1_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
-static const int timer2_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
-static const int timer3_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
-static const int timer4_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
-static const int timer5_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
-static const int timer6_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
-static const int timer7_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
-static const int timer8_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
-static const int timer9_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
-static const int timer10_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
-static const int timer11_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
-static const int uart_parent_idx[] = { HXT, SYSCLK1_DIV2 };
-static const int wdt0_parent_idx[] = { -1, LXT, PCLK3_DIV4096, LIRC };
-static const int wdt1_parent_idx[] = { -1, LXT, PCLK3_DIV4096, LIRC };
-static const int wdt2_parent_idx[] = { -1, LXT, PCLK4_DIV4096, LIRC };
-static const int wwdt0_parent_idx[] = { -1, -1, PCLK3_DIV4096, LIRC };
-static const int wwdt1_parent_idx[] = { -1, -1, PCLK3_DIV4096, LIRC };
-static const int wwdt2_parent_idx[] = { -1, -1, PCLK4_DIV4096, LIRC };
+static const int dbg_parent_idx[] = { HIRC_GATE, SYSPLL };
+static const int timer0_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK0, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer1_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK0, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer2_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK1, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer3_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK1, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer4_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK2, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer5_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK2, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer6_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK0, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer7_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK0, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer8_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK1, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer9_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK1, -1, -1,
+					 LIRC_GATE, -1, HIRC_GATE };
+static const int timer10_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK2, -1, -1,
+					  LIRC_GATE, -1, HIRC_GATE };
+static const int timer11_parent_idx[] = { HXT_GATE, LXT_GATE, PCLK2, -1, -1,
+					  LIRC_GATE, -1, HIRC_GATE };
+static const int uart_parent_idx[] = { HXT_GATE, SYSCLK1_DIV2 };
+static const int wdt0_parent_idx[] = { -1, LXT_GATE, PCLK3_DIV4096, LIRC_GATE };
+static const int wdt1_parent_idx[] = { -1, LXT_GATE, PCLK3_DIV4096, LIRC_GATE };
+static const int wdt2_parent_idx[] = { -1, LXT_GATE, PCLK4_DIV4096, LIRC_GATE };
+static const int wwdt0_parent_idx[] = { -1, -1, PCLK3_DIV4096, LIRC_GATE };
+static const int wwdt1_parent_idx[] = { -1, -1, PCLK3_DIV4096, LIRC_GATE };
+static const int wwdt2_parent_idx[] = { -1, -1, PCLK4_DIV4096, LIRC_GATE };
 static const int spi0_parent_idx[] = { PCLK1, APLL };
 static const int spi1_parent_idx[] = { PCLK2, APLL };
 static const int spi2_parent_idx[] = { PCLK1, APLL };
@@ -109,11 +121,11 @@ static const int spi3_parent_idx[] = { PCLK2, APLL };
 static const int qspi_parent_idx[] = { PCLK0, APLL };
 static const int i2s_parent_idx[] = { APLL, SYSCLK1_DIV2 };
 static const int can_parent_idx[] = { APLL, VPLL };
-static const int cko_parent_idx[] = { HXT, LXT, HIRC, LIRC,
+static const int cko_parent_idx[] = { HXT_GATE, LXT_GATE, HIRC_GATE, LIRC_GATE,
 				      AXICLK_DIV4, SYSPLL, DDRPLL,
 				      EPLL_DIV2, APLL, VPLL };
-static const int smc_parent_idx[] = { HXT, PCLK4 };
-static const int kpi_parent_idx[] = { HXT, LXT };
+static const int smc_parent_idx[] = { HXT_GATE, PCLK4 };
+static const int kpi_parent_idx[] = { HXT_GATE, LXT_GATE };
 
 static const struct clk_div_table ip_div_table[] = {
 	{0, 2}, {1, 4}, {2, 6}, {3, 8}, {4, 10},
@@ -277,16 +289,16 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 					 clk_base + REG_CLK_PWRCTL, 3);
 
 	hws[CAPLL] = ma35d1_reg_clk_pll(dev, CAPLL, pllmode[0], "capll",
-					hws[HXT], clk_base + REG_CLK_PLL0CTL0);
+					hws[HXT_GATE], clk_base + REG_CLK_PLL0CTL0);
 	hws[SYSPLL] = ma35d1_clk_fixed("syspll", 180000000);
 	hws[DDRPLL] = ma35d1_reg_clk_pll(dev, DDRPLL, pllmode[1], "ddrpll",
-					hws[HXT], clk_base + REG_CLK_PLL2CTL0);
+					hws[HXT_GATE], clk_base + REG_CLK_PLL2CTL0);
 	hws[APLL] = ma35d1_reg_clk_pll(dev, APLL, pllmode[2], "apll",
-				       hws[HXT], clk_base + REG_CLK_PLL3CTL0);
+				       hws[HXT_GATE], clk_base + REG_CLK_PLL3CTL0);
 	hws[EPLL] = ma35d1_reg_clk_pll(dev, EPLL, pllmode[3], "epll",
-				       hws[HXT], clk_base + REG_CLK_PLL4CTL0);
+				       hws[HXT_GATE], clk_base + REG_CLK_PLL4CTL0);
 	hws[VPLL] = ma35d1_reg_clk_pll(dev, VPLL, pllmode[4], "vpll",
-				       hws[HXT], clk_base + REG_CLK_PLL5CTL0);
+				       hws[HXT_GATE], clk_base + REG_CLK_PLL5CTL0);
 
 	hws[EPLL_DIV2] = ma35d1_clk_fixed_factor(dev, "epll_div2", "epll", 1, 2);
 	hws[EPLL_DIV4] = ma35d1_clk_fixed_factor(dev, "epll_div4", "epll", 1, 4);
@@ -454,7 +466,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[CKO_GATE] = ma35d1_clk_gate(dev, "cko_gate", "cko_div",
 					clk_base + REG_CLK_SYSCLK1, 13);
 
-	hws[GTMR_GATE] = ma35d1_clk_gate(dev, "gtmr_gate", "hirc",
+	hws[GTMR_GATE] = ma35d1_clk_gate(dev, "gtmr_gate", "hirc_gate",
 					 clk_base + REG_CLK_SYSCLK1, 14);
 
 	hws[GPA_GATE] = ma35d1_clk_gate(dev, "gpa_gate", "hclk0",
@@ -655,7 +667,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[UART16_GATE] = ma35d1_clk_gate(dev, "uart16_gate", "uart16_div",
 					   clk_base + REG_CLK_APBCLK0, 28);
 
-	hws[RTC_GATE] = ma35d1_clk_gate(dev, "rtc_gate", "lxt",
+	hws[RTC_GATE] = ma35d1_clk_gate(dev, "rtc_gate", "lxt_gate",
 					clk_base + REG_CLK_APBCLK0, 29);
 	hws[DDR_GATE] = ma35d1_clk_gate(dev, "ddr_gate", "ddrpll",
 					clk_base + REG_CLK_APBCLK0, 30);

-- 
2.55.0

