Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F443BD241;
	Mon, 17 Aug 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957827; cv=none; b=HmFkR3xoVKaDsxqKHdIt7ejT+CT36S7SCvLSwBo9bRCBOQIG9bOyGgjL+XuNEI0/e5GAc4JrAbSzj94oFSWvuL/Jb+T0HvJDPpocS3JQ2nsrfX5QULJ6fDcJeIkaAX5ETauMPwF4DXYty4C7fp0xRcIctwwXZ1VMa+V4OVmiQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957827; c=relaxed/simple;
	bh=twgfasG1qCJet0Els0Yo0gKIOaN4CqpS1I4Ked/MunE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=br1kxmamCX8irJWCA5WsGq54/+SkRLdlYRMLCQvXw8wmxxTos9di8KX6N5HLnmZ2MJPxy32QvFT/ymC7JY7O/YeP83ffBIRtFVrs/THpRALEtr0Lf7InWhJ1xc8TNvr5W4zQdUZteeszfBnP+SQc6fen9CDWkA9z/6vNxqQR5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxrtL_z4JqsNMBAA--.5571S3;
	Mon, 17 Aug 2026 17:10:23 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJAxW873z4JqP8QHAA--.7094S4;
	Mon, 17 Aug 2026 17:10:21 +0800 (CST)
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
	Xi Ruoyao <xry111@xry111.site>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH v10 2/2] i2c: ls2x: Add clocks property parsing and adjust bus speed
Date: Mon, 17 Aug 2026 17:07:21 +0800
Message-Id: <20260817090721.30582-3-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260817090721.30582-1-wanghongliang@loongson.cn>
References: <20260817090721.30582-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxW873z4JqP8QHAA--.7094S4
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXryrXFWktr1kGr4kWFy8JFc_yoWrKrykpa
	yDC34rGr4qgr12grs3Jw1UZFyayws5GayxCFy7K3Zxu3Z3Arn8X3WftFnIvF4ruFyxWayD
	ZayDWFsrCFWjvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

Tested-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
---
 drivers/i2c/busses/i2c-ls2x.c | 44 ++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index b475dd27b7af..57d6d38e2711 100644
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

