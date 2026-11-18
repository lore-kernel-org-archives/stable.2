Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021601;
	b=D+1B/jHt49w45RxqqMmxe5FXCg9AtPwobPKY7VbKZ5otFLJKgkiiuSNelPanb7d7s2OV
	 2joKnI208//gW/FpHsknf5wUoUMLLpYLuKoAZj5GDNfacHuxK0A9Hii6ghAq1aIjlONr/
	 t7iyP/uSXC3tvIe+G4u+MXTw/Zm48eE3V9noYeOl/mcESo6OSA/96PBJq1MZjYtPtKCtr
	 i5OqaWMjKnfKkIr1SxEZlZc1b44pIP7wIsJMa+oV0T3Mhr0fKpBvRw4rmjnFC5V4sITz/
	 HQuK9SwxGNT9jfNT1hF3xSNfMuHbWJ3mx8+Mo2Qfb3ThwSyswVHG36ziQ0hGpYb/HQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021601;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=wGwaYPRu1rAFbngpc6skzEuknfDV2uliRZuE0fH/0L0=;
	b=skyGbkLTzM1kX8/QA2hJqxZd0b4VMpMNJAY7S1bjjmANCtAZ8lKfq4T2AH39uXHPmApM
	 v+XgWNXtac5TE1NF7/jlrdUA2t0Ypd/wm8MMgStOnDebZFMF2sTUqV2gYEpiuC6sKj8WS
	 grx+LUaMasaYRwuf0w4CxDBE4tDVP6N0IFzmFn9y1SnTygrAySVPzNWjpyReer3IHPVRV
	 1a4aGHmiTWGAzWFF0rTcMeT0/qN698fu7z2MMqJZ9ywMbrZOjRep/3eSNul5fjadD6P+C
	 TrA2gFIhndYepZloZpGVLXnjL/oAqptnR0c5smLNH7uKYje3MLNHOsW/gj703jQHg+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=I4raib82;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F0606A333;
	Wed, 18 Nov 2026 17:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7F0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=I4raib82
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B4795C4F77B;
	Wed, 18 Nov 2026 17:06:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CA8245FE9B;
	Wed, 18 Nov 2026 17:06:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 515E111BC2986;
	Wed, 18 Nov 2026 18:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795021597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wGwaYPRu1rAFbngpc6skzEuknfDV2uliRZuE0fH/0L0=;
	b=I4raib8296m7gjrxF1NWz9BTGmsYa1VuWskfJxDZX5mtNyvfkYPBIaWG7/wVJUkRSMen48
	RXAPGTRT7xOcTJt1nAlAQ34wpBw4fHexJqgnYLU82X4A3O5Wfyubt/Qnxrl2VSQD3sopvA
	wI8QsWEoYVuODx24WnrNpNFRr6aJ5hKb6BAVx+mzIRtMH2Q1XWjYutau5/bPRnxBxluba1
	SJ7F6JEK1ZG6TlIs05T/Z1qo7WG58093e7K+KCel5LQRCmVZpb/O0yVR5E1XssoxMrgIJI
	xeDmLAhCbgr0KtdaoSFBDQg2kbXCJIfRwSCWn0JY2/nBPI097CARnvJaKymqUA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 17:59:17 +0100
Subject: [PATCH v12 08/10] clk: nuvoton: ma35d1: Reparent SYSPLL correctly
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
Message-Id: <20261118-perso-ma35d1-upstream-clk-v12-8-bee2c8dad4e1@bootlin.com>
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

The clock tree is still incorrect. SYSPLL is derived from HXT_GATE, very
much like CAPLL, DDRPLL, VPLL, APLL and EPLL. SYSPLL has a fixed
frequency, but if HXT gets gated, SYSPLL stops running.

Reparent SYSPLL under HXT_GATE to properly define the clock tree
topology. After this change, the frequencies are identical, but the
clock tree looks (again) much closer to the reality.

Since the TRM does not explicitly shows that HIRC and LIRC are
internally sourced from HXT and LXT, respectively, I haven't reparented
them (even though that was tempting). This can be done later anyway.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index c11afc2f8f6d..a5a36f88d973 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -139,6 +139,12 @@ static const struct clk_div_table eadc_div_table[] = {
 	{13, 28}, {14, 30}, {15, 32}, {0, 0},
 };
 
+static struct clk_hw *ma35d1_clk_fixed_parent_hw(struct device *dev, const char *name, int rate,
+						 const struct clk_hw *parent_hw)
+{
+	return devm_clk_hw_register_fixed_rate_parent_hw(dev, name, parent_hw, 0, rate);
+}
+
 static struct clk_hw *ma35d1_clk_fixed(struct device *dev, const char *name, int rate)
 {
 	return devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
@@ -285,6 +291,9 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 
 	hws[HXT_GATE] = ma35d1_clk_gate_parent_data(dev, "hxt_gate", hxtg_parent_data,
 						    clk_base + REG_CLK_PWRCTL, 0);
+	if (IS_ERR(hws[HXT_GATE]))
+		return PTR_ERR(hws[HXT_GATE]);
+
 	hws[LXT_GATE] = ma35d1_clk_gate_parent_data(dev, "lxt_gate", lxtg_parent_data,
 						    clk_base + REG_CLK_PWRCTL, 1);
 	hws[HIRC] = ma35d1_clk_fixed(dev, "hirc", 12000000);
@@ -296,7 +305,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 
 	hws[CAPLL] = ma35d1_reg_clk_pll(dev, CAPLL, pllmode[0], "capll",
 					hws[HXT_GATE], clk_base + REG_CLK_PLL0CTL0);
-	hws[SYSPLL] = ma35d1_clk_fixed(dev, "syspll", 180000000);
+	hws[SYSPLL] = ma35d1_clk_fixed_parent_hw(dev, "syspll", 180000000, hws[HXT_GATE]);
 	hws[DDRPLL] = ma35d1_reg_clk_pll(dev, DDRPLL, pllmode[1], "ddrpll",
 					hws[HXT_GATE], clk_base + REG_CLK_PLL2CTL0);
 	hws[APLL] = ma35d1_reg_clk_pll(dev, APLL, pllmode[2], "apll",

-- 
2.56.0

