Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931799;
	b=2L6sxQBWBm8U6M01U7jAnbmtUJJ3eQ9Yps1w6kc62/KUvgRipSXFFxM6TnY7qqXYR2RZ
	 obFA3uG6FHPnqLDyBfizbCNpPPPmy55ihlXYSCwOMrt6djE6aFaDLv8T1r8t98qJeS01g
	 S87Tz9nISBY0FEm0EukFXSuKnHzdYo6ZVnwcGWLOIro+FmOLjBqjD0eJUQFshMSFouReg
	 CdTDjWBZU8NUeTGhQatZ+QfN0ErTntssFtpUQl+EFmdr/oQV01ZQaICgIYdXm03ctAjTE
	 b8YzexUFHtZH9PJTFtGle0IjonCTdULpHGs3TbQO7PcqHyplhaVH+O/X1nlGg5sKWfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931799;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=noEq/oDfxdHv3ZN0zalPXPeXSKk0a1Plk07yiuVI0G4=;
	b=K6oQQZfXrmsR/trYzkdY44I1uzL18BydMSzBfaKuEZ1CRfIq0q78aScQpMbgA18ofVhh
	 VshBJLrld0NHL8wHyD78Z1XT8CAodtZO6KIEjhxzoL6g5l7+Zg4jydwjKNo0E4yBZdUNH
	 uQgPE6qjqRNJ0Tt0B2y2PvMsqX74zwLJ0odbxMfPJ8izkQTWXM4FSXmYKig6RiBMuvMD2
	 0iDpXsMGX3ZqcxKqXpBi52Cwn6lXwZf7BXIhDeIuZFG76KxPMLuZ49gsZz4ReuJyb92Cx
	 Z/MYKfJf8+BepMttrY3+VEo97BCbQ1M8zgou5oiy1VtCd4m4D7OWRL/MxX1nvKRvfug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18254606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18254606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Cx+9EMOu1q0+ccAA--.18156S3;
	Fri, 06 Nov 2026 10:23:08 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJDxE+QCOu1qCq8yAA--.19503S4;
	Fri, 06 Nov 2026 10:23:05 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH v11 2/2] i2c: ls2x: Add clocks property parsing and adjust bus speed
Date: Fri,  6 Nov 2026 10:22:56 +0800
Message-Id: <20261106022256.30514-3-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261106022256.30514-1-wanghongliang@loongson.cn>
References: <20261106022256.30514-1-wanghongliang@loongson.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxE+QCOu1qCq8yAA--.19503S4
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXryrXFWktr1kGr4kAFWDtrc_yoWrKFWxpa
	yDC34rGr4qgF12grsxJw1UZFyayws5JayxuFy2y3Zru3Z3Arn8X3WftFnIvF4ruFyxWayD
	ZayDWFsrCFWjvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=

The original driver uses a fixed PCLK frequency(LS2X_I2C_PCLK_FREQ) and
fixed div(5) for I2C bus speed calculation. As PCLK frequency and div
vary on different SoCs and ACPI platforms, this leads to inaccurate I2C
bus speed calculation and poor adaptability across platforms.

Improve the accuracy of I2C bus speed calculation across different
platforms by parsing the real I2C bus reference clock (PCLK) and div.
Support both DTS and ACPI.

For DTS:
- Retrieve I2C bus reference clock via the common clock framework
- Fetch div from match data for LS2K/LS7A series
- Fallback to default values if clock lookup fails or the obtained
  pclk or div is zero

For ACPI:
- Parse "clocks" property to get I2C bus reference clock
- Parse "clock-div" property to get div
- Fallback to the default values if property parsing fails or the
  obtained pclk or div is zero

Calculate the I2C clock prescaler based on reference clock, div and
target bus frequency with the formula:

prescale = (pclk * 10) / (div * bus_freq_hz) - 1

Dynamically acquiring PCLK and div per platform ensures accurate I2C bus
speed calculation and reliable operation across different platforms.

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
Tested-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
---
 drivers/i2c/busses/i2c-ls2x.c | 44 ++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index ef2e2a26981e..75d08cce6b8a 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -12,6 +12,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
@@ -63,11 +64,19 @@
 /* The default bus frequency, which is an empirical value */
 #define LS2X_I2C_FREQ_STD	(33 * HZ_PER_KHZ)
 
+/* The div of i2c reference clock on LS2K0500/2K1000/2K2000 */
+#define LS2X_I2C_2K_CLOCK_DIV	40
+
+/* The div of i2c reference clock on LS7A1000/7A2000 */
+#define LS2X_I2C_7A_CLOCK_DIV	50
+
 struct ls2x_i2c_priv {
 	struct i2c_adapter	adapter;
 	void __iomem		*base;
 	struct i2c_timings	i2c_t;
 	struct completion	cmd_complete;
+	unsigned int		div;
+	unsigned int		pclk;
 };
 
 /*
@@ -107,12 +116,14 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 	else
 		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 
+	val = div64_u64((u64)priv->pclk * 10,
+			(u64)priv->div * t->bus_freq_hz) - 1;
+
 	/*
 	 * According to the chip manual, we can only access the registers as bytes,
 	 * otherwise the high bits will be truncated.
 	 * So set the I2C frequency with a sequential writeb() instead of writew().
 	 */
-	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
 	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
 	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
 }
@@ -287,6 +298,7 @@ static const struct i2c_algorithm ls2x_i2c_algo = {
 static int ls2x_i2c_probe(struct platform_device *pdev)
 {
 	int ret, irq;
+	struct clk *clk;
 	struct i2c_adapter *adap;
 	struct ls2x_i2c_priv *priv;
 	struct device *dev = &pdev->dev;
@@ -304,6 +316,32 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	if (dev_of_node(dev)) {
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+		if (clk) {
+			priv->pclk = clk_get_rate(clk);
+			if (!priv->pclk)
+				priv->pclk = LS2X_I2C_PCLK_FREQ;
+		} else {
+			priv->pclk = LS2X_I2C_PCLK_FREQ;
+		}
+
+		priv->div = (unsigned long)device_get_match_data(dev);
+		if (!priv->div)
+			priv->div = LS2X_I2C_2K_CLOCK_DIV;
+	} else {
+		/* clocks and clock-div properties are used only in ACPI path. */
+		ret = device_property_read_u32(dev, "clocks", &priv->pclk);
+		if (ret || !priv->pclk)
+			priv->pclk = LS2X_I2C_PCLK_FREQ;
+
+		ret = device_property_read_u32(dev, "clock-div", &priv->div);
+		if (ret || !priv->div)
+			priv->div = LS2X_I2C_7A_CLOCK_DIV;
+	}
+
 	/* Add the i2c adapter */
 	adap = &priv->adapter;
 	adap->retries = 5;
@@ -349,8 +387,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
 				 ls2x_i2c_suspend, ls2x_i2c_resume, NULL);
 
 static const struct of_device_id ls2x_i2c_id_table[] = {
-	{ .compatible = "loongson,ls2k-i2c" },
-	{ .compatible = "loongson,ls7a-i2c" },
+	{ .compatible = "loongson,ls2k-i2c", .data = (void *)LS2X_I2C_2K_CLOCK_DIV, },
+	{ .compatible = "loongson,ls7a-i2c", .data = (void *)LS2X_I2C_7A_CLOCK_DIV, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);
-- 
2.47.2

