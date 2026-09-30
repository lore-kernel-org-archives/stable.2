Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546651CF7C;
	Wed, 30 Sep 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789161; cv=none; b=Yh+azyR5zg+m8/OfKYRN9ec6DMpzI7xD4pElQqbCMEJUE0XPdjPHLl+NvDZ4zbmVCq/CP2SDTzfdWrfMB4VA2iKuHJYqz4A9LwKL720EMsH/MvbUzVJFKfsbJ0t6MqS7q9iopGIAJ+q3L/DZbVvXLQjIt8fUHQKvPj7yguAN9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789161; c=relaxed/simple;
	bh=aJpTd9FnbsDWjvzrF7GDhcwZ+4qnb3VNB8IcPOk9sw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLJkHGcuLY76l8uvb/Fc1mm01oM3ucSL4pS8iFozXqoKuRNTpqn78/fF44qI1rtMvALwdSjG1G7atpfHYN1tJiWztuQOoNhJia3lTa3lvfGPv9D7ph4RwZOYoaJDxjx37VrqYXiaCtQjuGvzQ4ty2P6dyKQigrl8eECUZlaNf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rab9vyKX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rab9vyKX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 201841A107D;
	Wed, 30 Sep 2026 17:25:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8B2D60749;
	Wed, 30 Sep 2026 17:25:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55912103284B8;
	Wed, 30 Sep 2026 19:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790789156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mZvEpaFZrL7sZc8hczs8U0IzP8KZqdxqF/bu88DD5Gs=;
	b=Rab9vyKX9unXZrb7kEb33b15+oA/6TTGmowd/60xRiBdmH7mTY4Pi8klCIuURd8c5kzBB9
	RO8r2lgHSmWU07bNnLMnF7CFRcSps96IPHIsGh3m4vBEW5bA9Gfyh43cRh1yo0OQxc9FEC
	zFiQkRSlvTEM43umBc9jpzat2nuSWvPZ8H0MmVRayD/AiDJq51zVPtxDt2q40UL19Wj/lx
	tqE7nF71tSFbybIrX91uOd18HKI9AZlHnP6S80+jo7TMqEgNHyhsehOgHrPTihjtHEUXxo
	T1FzbrsQlg8xl/92z6PH6fa4QOeK+Jo+KfIFSnbHVCFQEjmFJis1SFAtxcRFug==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 30 Sep 2026 19:24:54 +0200
Subject: [PATCH v6 08/12] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perso-ma35d1-upstream-clk-v6-8-48937ee6c9bb@bootlin.com>
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

HXT and LXT are crystal oscillator inputs of the clock controller, they
are described in the DT, so retrieve them, in order, and store them in
their respective HXT/LXT hw table entries.

Since old DTs reference the HXT fixed-clock without naming it and do not
describe LXT at all, we assume that HXT must be present, and fallback to
creating a fixed clock for LXT if it is not described (for backward
compatibility purposes).

The downstream gate clocks can directly use the hw clocks as parents,
instead of relying on string matching.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 43 ++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index ceebcbd8c18b..d955d79abdd2 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -4,6 +4,7 @@
  * Author: Chi-Fang Li <cfli0@nuvoton.com>
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -191,6 +192,15 @@ static struct clk_hw *ma35d1_clk_gate(struct device *dev, const char *name, cons
 				    reg, shift, 0, &ma35d1_lock);
 }
 
+static struct clk_hw *ma35d1_clk_gate_parent(struct device *dev, const char *name,
+					     struct clk_hw *parent,
+					     void __iomem *reg, u8 shift)
+{
+	return devm_clk_hw_register_gate_parent_hw(dev, name, parent,
+						   CLK_SET_RATE_PARENT,
+						   reg, shift, 0, &ma35d1_lock);
+}
+
 static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *pllmode)
 {
 	const char *of_str;
@@ -215,10 +225,12 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *clk_node = pdev->dev.of_node;
+	struct clk_bulk_data *clks;
 	void __iomem *clk_base;
 	static struct clk_hw **hws;
 	static struct clk_hw_onecell_data *ma35d1_hw_data;
 	u32 pllmode[PLL_MAX_NUM];
+	int num_clks;
 	int ret;
 
 	ma35d1_hw_data = devm_kzalloc(dev,
@@ -240,12 +252,27 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
-	hws[HXT_GATE] = ma35d1_clk_gate(dev, "hxt_gate", "hxt",
-					clk_base + REG_CLK_PWRCTL, 0);
-	hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
-	hws[LXT_GATE] = ma35d1_clk_gate(dev, "lxt_gate", "lxt",
-					clk_base + REG_CLK_PWRCTL, 1);
+	num_clks = devm_clk_bulk_get_all(dev, &clks);
+	if (num_clks < 0)
+		return num_clks;
+
+	if (!num_clks) {
+		dev_err(dev, "missing crystal input clocks\n");
+		return -ENODEV;
+	}
+
+	hws[HXT] = __clk_get_hw(clks[0].clk);
+
+	if (num_clks > 1)
+		hws[LXT] = __clk_get_hw(clks[1].clk);
+	else
+		/* Old DTs do not describe the low-speed crystal */
+		hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
+
+	hws[HXT_GATE] = ma35d1_clk_gate_parent(dev, "hxt_gate", hws[HXT],
+					       clk_base + REG_CLK_PWRCTL, 0);
+	hws[LXT_GATE] = ma35d1_clk_gate_parent(dev, "lxt_gate", hws[LXT],
+					       clk_base + REG_CLK_PWRCTL, 1);
 	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000);
 	hws[HIRC_GATE] = ma35d1_clk_gate(dev, "hirc_gate", "hirc",
 					 clk_base + REG_CLK_PWRCTL, 2);
@@ -632,8 +659,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[UART16_GATE] = ma35d1_clk_gate(dev, "uart16_gate", "uart16_div",
 					   clk_base + REG_CLK_APBCLK0, 28);
 
-	hws[RTC_GATE] = ma35d1_clk_gate(dev, "rtc_gate", "lxt",
-					clk_base + REG_CLK_APBCLK0, 29);
+	hws[RTC_GATE] = ma35d1_clk_gate_parent(dev, "rtc_gate", hws[LXT],
+					       clk_base + REG_CLK_APBCLK0, 29);
 	hws[DDR_GATE] = ma35d1_clk_gate(dev, "ddr_gate", "ddrpll",
 					clk_base + REG_CLK_APBCLK0, 30);
 

-- 
2.55.0

