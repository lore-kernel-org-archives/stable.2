Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021588;
	b=EC7ZWd74lig98CgvJoToq8lbwsZC8y8BeKtC24MJQjaC/XUSbEUBVStgmAQ+oyNnYbMQ
	 atkq1bWetc08G4s3U2eaR8iBQ5RXZ4Cv5i04HnY8B5muQgetxC7+Ul/VRG0PBQNPoQEcs
	 mi2Y8zhfaZryE00o0d4ZKeqEGTp5WhTJuy+E4esgtzIZPXRNmTiEa/iaL+qdBtZNqybzq
	 93AFguTSD3Ut8WYwq3qA4AItgWCVrj/VLe9rTpfzPhA0etJFqCp4xge4YrPc6V+Hs+fUP
	 C5E24Gie79VO302EnfNuHb7W0V13Ul1MHMR0bJ5pKJz3bUaw31ThKsXPyXKl7Aw1F8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021588;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=n/KnFPEXkZk4mn/ZwqdLrpMQFF2e10V2K2RI4DEGki8=;
	b=YIasXtBwR+rmg/CjxEIeZOgDS4FWZGglOGG96LpyMlmechTT5F8kNluB0aVGxjBQSk5W
	 h/Ks8yZu1tKUdFdEnwdhALXUh+k0ZN/3OkIRpXv8lZfd4vaKn9TcCX0zg4EkUl8Zn2LX7
	 jP7a1ikzCk66bhAaRSN3x9GCwJfGPNqiZgDT4AlSd/jozcAhC1R7Zma/UIV2G8Q7Cu3C4
	 5LoZiy0y5k6EVN7AVPYm9eU/JvHkS1ZDbLDtRFtx83BwImCtuk4bLK7GWHimgwLf3lBLu
	 Bh8A3YTvC3vTAwG8r+ccpQlDjAjchqBx1pJ4VZkQBOZ5sfEKgctr50sImP/sHzNDlNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xXTIiLXL;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42411606A338;
	Wed, 18 Nov 2026 17:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42411606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xXTIiLXL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA14E1A169B;
	Wed, 18 Nov 2026 17:06:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A95465FE9B;
	Wed, 18 Nov 2026 17:06:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B88DD11BC29F0;
	Wed, 18 Nov 2026 18:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795021584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n/KnFPEXkZk4mn/ZwqdLrpMQFF2e10V2K2RI4DEGki8=;
	b=xXTIiLXLapr6q0xRhwdqKZhf2E/byMMV5xrMkJnGVLXaMzq0H5YU9GjvBgTzX8nVbkMlFA
	wi/cMla2b1aORd/KyVJHcrNkfgX1T3JRZAG/Vgy0tKP+cPv4ZRtmK3yUc37w9BGP9E23eG
	R21S618eoCaJZ1LHcSdZuVsNGoOL35yCU6qPF1N81gmVnWGSOP2CdyHutapgivjs+VPJtV
	Us6GU1t+h0A2CDmwQAMQVDi55hQtiICHSgG2L9LSrtM0WcO2pH9aVVonTFE0rz2ltWa+Vm
	qPqFlczebmJ3pvmW+lYPGnZuDj+LEzu1+k5C4UY/yL0uPQtRWHp+uogeBPGO6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 17:59:14 +0100
Subject: [PATCH v12 05/10] clk: nuvoton: ma35d1: Reparent the gates
 correctly
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
Message-Id: <20261118-perso-ma35d1-upstream-clk-v12-5-bee2c8dad4e1@bootlin.com>
References: <20261118-perso-ma35d1-upstream-clk-v12-0-bee2c8dad4e1@bootlin.com>
In-Reply-To: <20261118-perso-ma35d1-upstream-clk-v12-0-bee2c8dad4e1@bootlin.com>
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
index 4019df22a74e..d69c9fc0f39e 100644
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
@@ -283,16 +295,16 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
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
@@ -460,7 +472,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[CKO_GATE] = ma35d1_clk_gate(dev, "cko_gate", "cko_div",
 					clk_base + REG_CLK_SYSCLK1, 13);
 
-	hws[GTMR_GATE] = ma35d1_clk_gate(dev, "gtmr_gate", "hirc",
+	hws[GTMR_GATE] = ma35d1_clk_gate(dev, "gtmr_gate", "hirc_gate",
 					 clk_base + REG_CLK_SYSCLK1, 14);
 
 	hws[GPA_GATE] = ma35d1_clk_gate(dev, "gpa_gate", "hclk0",
@@ -661,7 +673,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[UART16_GATE] = ma35d1_clk_gate(dev, "uart16_gate", "uart16_div",
 					   clk_base + REG_CLK_APBCLK0, 28);
 
-	hws[RTC_GATE] = ma35d1_clk_gate(dev, "rtc_gate", "lxt",
+	hws[RTC_GATE] = ma35d1_clk_gate(dev, "rtc_gate", "lxt_gate",
 					clk_base + REG_CLK_APBCLK0, 29);
 	hws[DDR_GATE] = ma35d1_clk_gate(dev, "ddr_gate", "ddrpll",
 					clk_base + REG_CLK_APBCLK0, 30);

-- 
2.56.0

