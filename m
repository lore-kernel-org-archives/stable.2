Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021584;
	b=ADiq4F676pIFV2on/MZcCwgPTF/kR0m4YgSS80mcyCTmM6zAFvT4vkGvqzDajmuxZucQ
	 Ymo0imgTgCffEV8m/ZKXBS5aeeWCR/nXltR+/iT1XHnjEYqnTtHW0gUbbfgXvCGT3egJx
	 PBRXszuM2FbpgVjlbeSAqmJuGoInX2dPuX76juxbwxg3q+Gvc1Lmk/B9xfs4OHl5kfCTd
	 3acmDkHb0eA03/HM3QaIF8UfQig4i01Zgat0hnqQyJtSBlZk6NdTngp3p8Zp9ZG8FpyCr
	 /lNhZcHPX5KJ030HZJdJe2v3FdbX5Xpy2vM055/DhM6voUF5YAzaqipkHvFDKLZ3rUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021584;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=2QkUzJRe8ww4UhAZVZ0N75Y2fS2ppLIbZH0pa1w2a0I=;
	b=snm8nlHfdiC70Jn8zVn21yZ5GQI/qSNjRSeICDZ2JOfzlhwsBvrRg2FEMky7Zu9vfMPZ
	 mYDsJkrVrCNaDJ2DGKGUt3Ac62SEr6SsBFii1Pud2ilUZ1PtlyEsBCUJZaOX138wztORk
	 qgPRpSJryXKeaX0XF+TMjOhSpRWrRwq76gR5oj+DiL/Z6Hsd+dkDs//gpzc+gHV38ZiFi
	 S1rOvedO1sq0JppQSerXsHvRcDQ+uwdgnFVv1AML96MxM4esOajqLrG8dAaroX+/FysmT
	 ojxNGJzJVXJDJdG7AZ7z6SjRb3z0YbtKwrr8Wpvy+HW/D/PWwta+WAQkTRWB6CXB0IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=prZzb8XM;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3538606A336;
	Wed, 18 Nov 2026 17:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3538606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=prZzb8XM
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 67AD64E41636;
	Wed, 18 Nov 2026 17:06:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F5E45FE9B;
	Wed, 18 Nov 2026 17:06:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 569DE11BC1F23;
	Wed, 18 Nov 2026 18:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795021580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2QkUzJRe8ww4UhAZVZ0N75Y2fS2ppLIbZH0pa1w2a0I=;
	b=prZzb8XMu7pxAhm4IwUFoJIAjQo70p+pbzyqMlAfWcTqyacXCRdCAOiG7CvIW3+Rfko3m0
	HIvf8ZOCo2gKdUlPN/dgzD8LPDGm/RmPqm+YQx6gNt6Lrue+6kkpT8dEc93SmPRK20m+JP
	YsLP8OjPnSsxJCl4EF8yktJre984/V8x7jZGgZATS0esHWmctgQQtilL4yXGnM9ga0LZfL
	Ynw5k1Afr6Kkg8uQsCdZfdBsMUeKL5y+Cqt9eWZY1nQnM6AWauGKcn2LusOs34+3WanbBj
	8IkmXxYuypn6mge8HY567YgRXhDfwTRKRCcpSQBy6akD1pR4mEZ6eal/QsazgA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 17:59:13 +0100
Subject: [PATCH v12 04/10] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
 when possible
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
Message-Id: <20261118-perso-ma35d1-upstream-clk-v12-4-bee2c8dad4e1@bootlin.com>
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

HXT and LXT are crystal oscillator inputs of the clock controller. As
such, they are external clock sources which should not be registered by
this driver.

HXT is already described in the DT, but is not named. In order to point
to this parent from its direct child which is HXT_GATE, we must provide
a fw_name (when it is named, new DTs) and a .name (for when it's not
named, but the fixed clock node name is used).

LXT is missing in old DTs, so we must create that clock and register it
for backward compatibility reasons. It should however be described and
pointed at in updated DTs.

Both HXT and LXT are exposed by this driver only in the backward
compatibility case. Otherwise, both clocks are expected to be retrieved
from the DT.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 44 +++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index ba12d4068e83..4019df22a74e 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -65,6 +65,14 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define MA35D1_MUX_MAX_PARENTS	10
 
+static const struct clk_parent_data hxtg_parent_data[] = {
+	{ .fw_name = "hxt", .name = "clk_hxt" },
+};
+
+static const struct clk_parent_data lxtg_parent_data[] = {
+	{ .fw_name = "lxt", .name = "lxt" },
+};
+
 /* Mux parent selection, by index into the controller's clock table */
 static const int ca35clk_parent_idx[] = { HXT, CAPLL, DDRPLL };
 static const int sysclk0_parent_idx[] = { EPLL_DIV2, SYSPLL };
@@ -191,6 +199,15 @@ static struct clk_hw *ma35d1_clk_gate(struct device *dev, const char *name, cons
 				    reg, shift, 0, &ma35d1_lock);
 }
 
+static struct clk_hw *ma35d1_clk_gate_parent_data(struct device *dev, const char *name,
+						  const struct clk_parent_data *parent_data,
+						  void __iomem *reg, u8 shift)
+{
+	return devm_clk_hw_register_gate_parent_data(dev, name, parent_data,
+						     CLK_SET_RATE_PARENT,
+						     reg, shift, 0, &ma35d1_lock);
+}
+
 static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *pllmode)
 {
 	const char *of_str;
@@ -219,7 +236,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	static struct clk_hw **hws;
 	static struct clk_hw_onecell_data *ma35d1_hw_data;
 	u32 pllmode[PLL_MAX_NUM];
-	int ret;
+	int ret, num_clks;
 
 	ma35d1_hw_data = devm_kzalloc_flex(dev, *ma35d1_hw_data, hws,
 					   MA35D1_CLK_COUNT);
@@ -239,12 +256,25 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
-	hws[HXT_GATE] = ma35d1_clk_gate(dev, "hxt_gate", "hxt",
-					clk_base + REG_CLK_PWRCTL, 0);
-	hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
-	hws[LXT_GATE] = ma35d1_clk_gate(dev, "lxt_gate", "lxt",
-					clk_base + REG_CLK_PWRCTL, 1);
+	num_clks = of_clk_get_parent_count(clk_node);
+	if (num_clks < 1 || num_clks > 2)
+		return -EINVAL;
+
+	/*
+	 * Old DTs do not describe the low-speed crystal. They may also expect
+	 * an HXT output from this driver. In practice, nobody should use these
+	 * clocks directly, but they must be kept for backward compatility
+	 * purposes.
+	 */
+	if (num_clks == 1) {
+		hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
+		hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
+	}
+
+	hws[HXT_GATE] = ma35d1_clk_gate_parent_data(dev, "hxt_gate", hxtg_parent_data,
+						    clk_base + REG_CLK_PWRCTL, 0);
+	hws[LXT_GATE] = ma35d1_clk_gate_parent_data(dev, "lxt_gate", lxtg_parent_data,
+						    clk_base + REG_CLK_PWRCTL, 1);
 	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000);
 	hws[HIRC_GATE] = ma35d1_clk_gate(dev, "hirc_gate", "hirc",
 					 clk_base + REG_CLK_PWRCTL, 2);

-- 
2.56.0

