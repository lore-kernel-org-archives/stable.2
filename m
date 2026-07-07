Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF83242A4;
	Tue,  7 Jul 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396405; cv=none; b=XelsSVnZuDscZsN9cRMAyjPaq85SmnQMfRTOIjAu5UmQI6bfPKOSk3eszk99EdXG7L3jR0TRjuCv6vRlX8CNHKg1GUKno8uPVEuaLe3HVXGLFKtnCbLvBhf+XZCq/gkJZLRba2uguKurrsRFwgKQzswzuquM5i6x/qDnGL3iCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396405; c=relaxed/simple;
	bh=5A3JLo0kESX1OiYCTzKz3yebxAnvlQMiHKNdZqjvGkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPT0xeHK5hu35RwPe0CEVufa7cR+ncbhFbtf4bnA9w+sNKqcwBWXnh5TMcFs3q070HH6lQxT18wx3dXSQK+jG6/1cRLVoonl1GVwcEjo/YBzVwSgCsYZgE8RsFLsZ2Oky2q0Fw7U7aHMpZWfYi9AwZALPcm+D3BOSiHj9H51o/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8AxiusxeExqQcUAAA--.3472S3;
	Tue, 07 Jul 2026 11:53:21 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJAxX8creExqYXcDAA--.21037S4;
	Tue, 07 Jul 2026 11:53:21 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Hongliang Wang <wanghongliang@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH v7 2/2] i2c: ls2x: Add clocks property parsing and adjust bus speed
Date: Tue,  7 Jul 2026 11:51:04 +0800
Message-Id: <20260707035104.3092-3-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260707035104.3092-1-wanghongliang@loongson.cn>
References: <20260707035104.3092-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX8creExqYXcDAA--.21037S4
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr15KF15uw15Xw1DAw4fZwc_yoWrXry8pF
	Z8CF95Gr4qqF42grsxtw18ZFy3tws5Jay8GFy7tw1xW3Z3Arn8Za4ftFnI9F4v9F97XayU
	XayDGrsxCFWjvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

The i2c-ls2x driver supports dts and acpi parameter passing.

In dts, uses clock framework, by parsing clocks property to
get i2c bus reference clock, and define the div of reference
clock by device data.

In acpi, by passing clocks property to describe i2c bus reference
clock and clock-div property to describe the div of reference clock.

Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
and div, calculate the prcescale of i2c divider register. The
calculation formula is

prcescale = (clock_a*10)/(div*clock_s)-1

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
---
 drivers/i2c/busses/i2c-ls2x.c | 36 ++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index b475dd27b7af..18b79dc759bf 100644
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
@@ -107,12 +116,13 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 	else
 		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 
+	val = (priv->pclk * 10) / (priv->div * t->bus_freq_hz) - 1;
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
@@ -287,6 +297,7 @@ static const struct i2c_algorithm ls2x_i2c_algo = {
 static int ls2x_i2c_probe(struct platform_device *pdev)
 {
 	int ret, irq;
+	struct clk *clk;
 	struct i2c_adapter *adap;
 	struct ls2x_i2c_priv *priv;
 	struct device *dev = &pdev->dev;
@@ -304,6 +315,25 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	if (dev_of_node(dev)) {
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (!IS_ERR_OR_NULL(clk))
+			priv->pclk = clk_get_rate(clk);
+		else
+			priv->pclk = LS2X_I2C_PCLK_FREQ;
+
+		priv->div = (unsigned long)device_get_match_data(dev);
+	} else {
+		/* clocks and clock-div are only ACPI properties. */
+		ret = device_property_read_u32(dev, "clocks", &priv->pclk);
+		if (ret)
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
@@ -349,8 +379,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
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

