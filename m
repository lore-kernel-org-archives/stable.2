Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009094;
	b=O/9koIEfl5IpdMt19S0655IGEL325/UYA4d8Mf8X0wh5bIduv0l5uDQ5O9x13D6iKmNh
	 zG2EQ++l6fDWrB0S4NKugCU8kHodSV89fvG4hqHEGFSXORwDuh0SisnSP6a9iDwKTb87C
	 UwUiFrAK60vjleWh+PVtEHEF1+iBhQAEeOsUIQ6qM1r/+Uyxe5CugeqSJLHakzqTPgOom
	 /ohylC9KVjB096N25OpZ6Mz/tBhHNo8xTm03aYPffO48N6hFLS2oJTT6jRS8+E4KWTlbh
	 sUAun4LvDh/yz/wlhxJs7pzBko+7hegmtNEVclt453djDcKaBFb6SEJ3GxXhhldjKsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009094;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=iNWdLzbXEobM28b9C+AS459N37QlRkIdIpDJ06HXMhk=;
	b=wNDK8lFAofuJWKcC9zPIh1pAYSMYDXBGYLT1aqOwHJKQRFA8B+V/vAOlSyIuPDib4ByH
	 7xyeGT/sMddlH+h6yGOGlL/0iURPgwbN8LLN8CRxyGbse5xIUloej3pqGwDEFCZOUoNlB
	 6BiSKqFrICEiwRfYfUcrhrU1m/SuluMgBgimsi+CykRLdon0mTW2BM6+sU4kOxcW7oH3J
	 TpLWHWAwNXxIa9KVgpAFapw7n6Byf4j9g5otgCbrvqtGOtRqJ/Zju6pPfM54dTjf/wK6a
	 B6ZMYw1ls9KFziUT2MJbm4lZ/boHqt0CAFdygPcFeqqd2sPeCAkmhgyJFaVp6rK7XdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xryRjjKn;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFD60A260A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DFD60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xryRjjKn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8CC8A1A16D9;
	Wed, 18 Nov 2026 13:38:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 584675FE9B;
	Wed, 18 Nov 2026 13:38:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 782B511BC1FF3;
	Wed, 18 Nov 2026 14:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795009089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iNWdLzbXEobM28b9C+AS459N37QlRkIdIpDJ06HXMhk=;
	b=xryRjjKnwNLk3nhHVovTFZtcUQ9bp1fVnRMgGUOd8lXQ7atzoRB8JavI+4TrAWp++dlX7z
	dec2Aayds3t/KdfaQp3U2T5nYjV9SFoUAzXTDSZt/arxoz+Lmjio7Dki9ErYit3QZqk6Se
	Yku9KAp7+b8NG8ea4qlsBmpWMi4oVuZBYH2d5c1Rj7CwMOFL4TgwnLUiTSkCPcgq/Gcyg9
	sUzLYFlyXwqpEyVEO0QkRDaUzsOhHdH0dS+xn7PpBzfin37igvjo+sIckKhz/F1bbvQb20
	Rg4QlV0GC4cPvnRNLIswNvUyAXNIFNlAD9cU8XFkIbrtepxw5d9u5Kqi7AXOfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 14:37:11 +0100
Subject: [PATCH v11 04/10] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
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
Message-Id: <20261118-perso-ma35d1-upstream-clk-v11-4-bd1d1e060926@bootlin.com>
References: <20261118-perso-ma35d1-upstream-clk-v11-0-bd1d1e060926@bootlin.com>
In-Reply-To: <20261118-perso-ma35d1-upstream-clk-v11-0-bd1d1e060926@bootlin.com>
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
index 00d635cdb604..33b397d7b7c5 100644
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
 
 	ma35d1_hw_data = devm_kzalloc(dev,
 				      struct_size(ma35d1_hw_data, hws, MA35D1_CLK_COUNT),
@@ -240,12 +257,25 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
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

