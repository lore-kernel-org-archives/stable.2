Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9551C048
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789168; cv=none; b=Ru9FugkxE00SodjRnozqKIdh+Tlr0O0q8+AHr06LCZSjLqRB7pgDp7G1RmFyRa2Cfkf0F4/fQyTIJQ+ZRvPfNbKcFBRBNFvbq1egX0R2AFIeJrFgZGD9cpIvDmd05pjFO2A0IX+kUjCD7vAyISN4N7BcGMX0FO9gPazcVo6U9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789168; c=relaxed/simple;
	bh=vGDm1DyD/3vrrT4bSbQX3dWWdA9OiOCJtggPRBr9Tzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzD9DR1sIuDRRTU2fDp5RnQpafM3xQORSPeQf7C3wEZEVrF/V3tGOsQ9DGQ9WpkGXCpnYN0sxs8MkjuZdhYbswkNCRunwT4EpZ7/5a2KYZ2/NHRowCVZlsuJEwsLmQKy37cOUqFljT91aLvtiApgZAS0ckIvDKo0q+eAibpsoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qFDgMJ/o; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qFDgMJ/o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CB581A107C;
	Wed, 30 Sep 2026 17:26:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4DE760749;
	Wed, 30 Sep 2026 17:26:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB6A0103291EA;
	Wed, 30 Sep 2026 19:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790789164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pHX3FxLc35EBcXDgU8Mdx/URxIIN4Tfi71fuJNvMy00=;
	b=qFDgMJ/oG8VxVZ+30z+n9OIXk6YwD5PXCM58pPi1s8UaEV5wdFpxt3/47CT1xq6zIVRHIu
	VFU6pyViiqeYaiJwYzqmCw3VGM64WW/ei6NqmNLrNDU18pQOykBdKpFRTRrJGclugn1x09
	UOvCe/Dptw4ElC8C+by4wkGix2UZhVI/y2yAPQCWtzLqWVWNFrH7ae0pWS0vSKQZQZTPHB
	0OjF8ybmBi79oOjTeMWIhRffBnnXFc5Qno8HI93Zn3FSpHFr1ehuEZZc+SMj+rcZ+q3Mmf
	YcM0Xdu2u5TM6I/hG9CzNPXkzobiKKReN2qtAru7SYWycbgba2/+oXKysUo8HQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 30 Sep 2026 19:24:56 +0200
Subject: [PATCH v6 10/12] clk: nuvoton: ma35d1: Reparent SYSPLL correctly
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perso-ma35d1-upstream-clk-v6-10-48937ee6c9bb@bootlin.com>
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
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The clock tree is still incorrect. SYSPLL is derived from HXT, very much
like CAPLL, DDRPLL, VPLL, APLL and EPLL. SYSPLL has a fixed frequency,
but if HXT gets gated, SYSPLL stops running.

Reparent SYSPLL under HXT_GATE to properly define the clock tree
topology. After this change, the frequencies are identical, but the
clock tree looks (again) much closer to the reality.

Even though the TRM does not explicitly shows that HIRC and LIRC are
internally sourced from HXT and LXT, respectively, there are high
chances that these should be reparented as well. I will not do it but
the discussion is open and in case it becomes relevant, the 'parent'
field of the modified ma35d1_clk_fixed() helper can just be set
accordingly.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 384449d473c7..16cf2771e5ed 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -132,9 +132,9 @@ static const struct clk_div_table eadc_div_table[] = {
 	{13, 28}, {14, 30}, {15, 32}, {0, 0},
 };
 
-static struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
+static struct clk_hw *ma35d1_clk_fixed(const char *name, int rate, const char *parent)
 {
-	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+	return clk_hw_register_fixed_rate(NULL, name, parent, 0, rate);
 }
 
 static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
@@ -279,22 +279,22 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 		hws[LXT] = __clk_get_hw(clks[1].clk);
 	else
 		/* Old DTs do not describe the low-speed crystal */
-		hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
+		hws[LXT] = ma35d1_clk_fixed("lxt", 32768, NULL);
 
 	hws[HXT_GATE] = ma35d1_clk_gate_parent(dev, "hxt_gate", hws[HXT],
 					       clk_base + REG_CLK_PWRCTL, 0);
 	hws[LXT_GATE] = ma35d1_clk_gate_parent(dev, "lxt_gate", hws[LXT],
 					       clk_base + REG_CLK_PWRCTL, 1);
-	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000);
+	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000, NULL);
 	hws[HIRC_GATE] = ma35d1_clk_gate(dev, "hirc_gate", "hirc",
 					 clk_base + REG_CLK_PWRCTL, 2);
-	hws[LIRC] = ma35d1_clk_fixed("lirc", 32000);
+	hws[LIRC] = ma35d1_clk_fixed("lirc", 32000, NULL);
 	hws[LIRC_GATE] = ma35d1_clk_gate(dev, "lirc_gate", "lirc",
 					 clk_base + REG_CLK_PWRCTL, 3);
 
 	hws[CAPLL] = ma35d1_reg_clk_pll(dev, CAPLL, pllmode[0], "capll",
 					hws[HXT_GATE], clk_base + REG_CLK_PLL0CTL0);
-	hws[SYSPLL] = ma35d1_clk_fixed("syspll", 180000000);
+	hws[SYSPLL] = ma35d1_clk_fixed("syspll", 180000000, "hxt_gate");
 	hws[DDRPLL] = ma35d1_reg_clk_pll(dev, DDRPLL, pllmode[1], "ddrpll",
 					hws[HXT_GATE], clk_base + REG_CLK_PLL2CTL0);
 	hws[APLL] = ma35d1_reg_clk_pll(dev, APLL, pllmode[2], "apll",
@@ -335,8 +335,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[PCLK3_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk3_div4096", "pclk3", 1, 4096);
 	hws[PCLK4_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk4_div4096", "pclk4", 1, 4096);
 
-	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000);
-	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000);
+	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000, NULL);
+	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000, NULL);
 
 	/* DDR */
 	hws[DDR0_GATE] = ma35d1_clk_gate(dev, "ddr0_gate", "ddrpll",

-- 
2.55.0

