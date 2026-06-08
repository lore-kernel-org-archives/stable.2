Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE130FF21;
	Mon,  8 Jun 2026 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886803; cv=none; b=G5h9asueZ1zlfcOYlaBbOtd+vhLhziK+r8agZWntw48Z35Q0Ta5QDT0Zi7BKKpQaXk7SiBMLYc+YjwkkCYQDrEnA0OfcLyaiRzhlhC+51jS7mh/itGU6qYJ/iKFDPLyAePKPc+alFQlIf/2385yGwt//8fPTT/PVtmf7W7zum2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886803; c=relaxed/simple;
	bh=+eSvQyg0WYIA5OXyNDQfLE+z6DeiJKTxn5DMaIKwvbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aL7fqzSr54C0sibIbkH6eNIMl8ouUoxsY4uI8Qz5NSwu9aeZEDsMoanXkhSzbR7kRSc6NDaGAJSgLWOW6U5Bi1Tf5Wkt34x9WvKdM7fRK/Wr96AbU1SOAz/jWTv8qDXDw3PNQ3wmrTwKnFCzWE4ZX/aG+T25qJGwsobAsf9etcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8DxVXgQLSZq_p4RAA--.22545S3;
	Mon, 08 Jun 2026 10:46:40 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCxOMEKLSZq9ESfAA--.25894S4;
	Mon, 08 Jun 2026 10:46:39 +0800 (CST)
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
Subject: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust bus speed
Date: Mon,  8 Jun 2026 10:45:33 +0800
Message-Id: <20260608024533.32419-3-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260608024533.32419-1-wanghongliang@loongson.cn>
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxOMEKLSZq9ESfAA--.25894S4
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr15KF15uw15Xw1DAw4fZwc_yoWrXw1kpF
	W5CFZ5Gr4qqF42grsaq3W7ZFyYvws5JayUCFy7tw1xW3Z3Zr1DZa4ftFn09FWvgF97uayU
	XayDGr43CFyUZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

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
index b475dd27b7af..46dafa11b301 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -12,6 +12,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
@@ -63,11 +64,18 @@
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
 };
 
 /*
@@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
 static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 {
 	u16 val;
+	u32 pclk, div;
+	struct clk *clk;
 	struct i2c_timings *t = &priv->i2c_t;
 	struct device *dev = priv->adapter.dev.parent;
 	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
@@ -107,12 +117,30 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 	else
 		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 
+	if (dev_of_node(dev)) {
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (!IS_ERR_OR_NULL(clk))
+			pclk = clk_get_rate(clk);
+		else
+			pclk = LS2X_I2C_PCLK_FREQ;
+
+		div = priv->div;
+
+		val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
+	} else {
+		/* clocks and clock-div are only ACPI properties. */
+		if (!device_property_read_u32(dev, "clocks", &pclk) &&
+		    !device_property_read_u32(dev, "clock-div", &div))
+			val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
+		else
+			val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
+	}
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
@@ -295,6 +323,8 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->div = (unsigned long)device_get_match_data(dev);
+
 	/* Map hardware registers */
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
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

